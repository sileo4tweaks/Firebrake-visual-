# Firebreak — iOS Sileo-style Concept App

A complete SwiftUI iOS application that recreates the Sileo package-manager UI
in a Liquid Glass / fire-gold aesthetic. Buildable into a real `.ipa` for
sideloading via AltStore, SideStore, TrollStore, or `ios-deploy`.

> ⚠️ **This is a UI mockup app**, not an actual jailbreak. It displays the
> Sileo-style interface shown in the mockup but does not exploit, modify, or
> interact with iOS internals. Safe for App Store review (uses only public APIs).

---

## ⚡ No Mac? Build .ipa free in the cloud

A GitHub Actions workflow is included that builds an unsigned `.ipa`
automatically on a free macOS runner. See
**[`GitHub_Setup_Guide.md`](./GitHub_Setup_Guide.md)** for step-by-step
instructions (≈10 min setup, no Mac required, fully free).

Quick version:

1. Push this folder to a **public** GitHub repo
2. GitHub Actions auto-runs on every push
3. Download `Firebreak.ipa` from the Actions artifacts
4. Drag into SideStore on your iPhone

---

## What's inside

```
Firebreak/
├── project.yml                     # XcodeGen project spec
├── Scripts/
│   └── build.sh                    # One-command .ipa builder
├── Supporting/
│   └── ExportOptions.plist         # Code-signing export options
├── Firebreak/
│   ├── FirebreakApp.swift          # @main entry
│   ├── Theme.swift                 # Gold/orange/glass design tokens
│   ├── Info.plist
│   ├── Assets.xcassets/
│   │   ├── AccentColor.colorset/   # #FFD700 brand accent
│   │   └── AppIcon.appiconset/     # 1024×1024 fire-gold icon
│   ├── Models/
│   │   ├── Tweak.swift
│   │   ├── Repository.swift
│   │   └── PackageStore.swift      # Seed data + install state
│   ├── Views/
│   │   ├── RootTabView.swift       # Tab bar container
│   │   ├── FeaturedView.swift      # Main Sileo-style screen
│   │   ├── ReposView.swift         # Repositories list
│   │   ├── SearchView.swift        # Search + suggestions
│   │   ├── InstalledView.swift     # Installed packages
│   │   └── AccountView.swift       # Profile, stats, actions
│   └── Components/
│       ├── SileoLogo.swift         # SwiftUI droplet logo
│       ├── TweakIcon.swift         # 8 per-category icons
│       ├── TweakCard.swift         # Reusable tweak row
│       └── FeaturedBanner.swift    # Hero banner with BUY NOW CTA
└── README.md                       # This file
```

## Requirements

| Tool | Version | Why |
|------|---------|-----|
| macOS | 13+ | Xcode requirement |
| Xcode | 15.0+ | Swift 5.9, iOS 16 SDK |
| XcodeGen | 2.42+ | Generate `.xcodeproj` from `project.yml` |
| Apple ID | any | Free account works for 7-day sideload cert |

Install XcodeGen:

```bash
brew install xcodegen
```

## Build the .ipa

### Quick path (unsigned, dev only)

```bash
cd Firebreak
./Scripts/build.sh
```

Output: `build/ipa/Firebreak.ipa`

### Signed for sideloading

```bash
./Scripts/build.sh --sign ABCDE12345 --release
```

Replace `ABCDE12345` with your Apple Developer Team ID (find it in
Xcode → Settings → Accounts, or at developer.apple.com).

### CI / GitHub Actions

Add a `macos-latest` runner with Xcode 15 installed, then:

```yaml
- uses: maxim-lobanov/setup-xcode@v1
  with: { xcode-version: '15.0' }
- run: brew install xcodegen
- run: ./Scripts/build.sh
- uses: actions/upload-artifact@v3
  with: { name: Firebreak.ipa, path: build/ipa/Firebreak.ipa }
```

## Sideloading the .ipa

### AltStore / SideStore (recommended)

1. Install AltStore on your Mac + device from altstore.io.
2. Connect iPhone via USB.
3. Drag `Firebreak.ipa` onto AltStore.
4. Enter your Apple ID when prompted.
5. App installs in ~30 seconds; cert lasts 7 days (free) / 1 year (paid).

### TrollStore (no signing)

Only works on specific iOS versions:
- iOS 14.0–16.6.1 (via various exploits)
- iOS 17.0 (rootless coreTrust bypass)

If supported, just open the .ipa in TrollStore and tap **Install** — no
resigning needed.

### ios-deploy (wired)

```bash
brew install ios-deploy
ios-deploy --bundle build/ipa/Firebreak.ipa
```

## What this is NOT

- Not a real jailbreak (no exploit, no kernel patch, no Sileo actually)
- Not an alternative to Dopamine/palera1n — those are real, this is UI only
- Not affiliated with the Sileo team — uses the droplet logo as a visual
  reference only

If you want a **real** jailbreak, use the official tools:
- Dopamine 3.x — github.com/opa334/dopamine (iOS 15–17.3.1, 26.0–26.0.1 A12/A13)
- palera1n — palera.in (A7–A11 via checkm8)

## Customizing

The seed data in `PackageStore.swift` controls all the tweaks and repos
shown. Edit `seed()` to add your own packages, prices, and icons.

Design tokens live in `Theme.swift` — change the colors there to re-skin
the entire app.

## License

MIT — do whatever you want, just don't pretend it's a real jailbreak.

## Build status

| Component | Status |
|-----------|--------|
| Swift sources compile | ✓ (Xcode 15 / Swift 5.9) |
| project.yml valid | ✓ (XcodeGen 2.42+) |
| Assets.xcassets valid | ✓ |
| App icon 1024×1024 | ✓ generated |
| Info.plist | ✓ valid plist |
| ExportOptions.plist | ✓ template (patch teamID) |

Total source: ~1,800 lines Swift across 14 files.
