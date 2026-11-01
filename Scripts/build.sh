#!/usr/bin/env bash
#
# build.sh — Build Firebreak.ipa from source
#
# Modes:
#   ./Scripts/build.sh                        # unsigned .ipa (for SideStore/AltStore/TrollStore)
#   ./Scripts/build.sh --sign TEAM_ID         # signed .ipa (for direct install)
#   ./Scripts/build.sh --sign TEAM_ID --release
#
# Requirements:
#   - macOS 13+ with Xcode 15+ (Swift 5.9)
#   - XcodeGen: brew install xcodegen
#
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_ROOT"

TEAM_ID=""
CONFIG="Debug"
SIGNED=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --sign)
            TEAM_ID="$2"
            SIGNED=1
            shift 2
            ;;
        --release)
            CONFIG="Release"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [--sign TEAM_ID] [--release]"
            echo ""
            echo "  no args         → unsigned .ipa for SideStore/AltStore/TrollStore"
            echo "  --sign TEAM_ID  → signed .ipa (developer cert)"
            echo "  --release       → Release config (default Debug)"
            exit 0
            ;;
        *)
            echo "Unknown arg: $1" >&2
            exit 1
            ;;
    esac
done

BUILD_DIR="$PROJECT_ROOT/build"
DERIVED_DATA="$BUILD_DIR/DerivedData"
IPA_PATH="$BUILD_DIR/Firebreak.ipa"

echo "==> Step 1/4 — Generate Xcode project from project.yml"
if ! command -v xcodegen >/dev/null 2>&1; then
    echo "xcodegen not found. Install: brew install xcodegen"
    exit 1
fi

# If signing, patch the project.yml signing settings
if [[ "$SIGNED" -eq 1 ]]; then
    echo "    (signing mode — patching project.yml)"
    sed -i.bak \
        -e "s/CODE_SIGNING_REQUIRED: NO/CODE_SIGNING_REQUIRED: YES/" \
        -e "s/CODE_SIGN_IDENTITY: \"\"/CODE_SIGN_IDENTITY: \"iPhone Developer\"/" \
        project.yml
    xcodegen generate --spec project.yml
    rm -f project.yml.bak
    # Patch ExportOptions teamID
    sed -i.bak "s/YOUR_TEAM_ID/$TEAM_ID/" Supporting/ExportOptions.plist
    rm -f Supporting/ExportOptions.plist.bak
else
    xcodegen generate --spec project.yml
fi

echo "==> Step 2/4 — Build .app ($CONFIG, ${SIGNED:-unsigned})"
mkdir -p "$BUILD_DIR"

SIGN_FLAGS=()
if [[ "$SIGNED" -eq 0 ]]; then
    SIGN_FLAGS=(
        CODE_SIGNING_ALLOWED=NO
        CODE_SIGNING_REQUIRED=NO
        CODE_SIGN_IDENTITY=""
        CODE_SIGN_ENTITLEMENTS=""
    )
fi

xcodebuild \
    -project Firebreak.xcodeproj \
    -scheme Firebreak \
    -configuration "$CONFIG" \
    -destination "generic/platform=iOS" \
    -derivedDataPath "$DERIVED_DATA" \
    -allowProvisioningUpdates \
    "${SIGN_FLAGS[@]}" \
    build \
    | tee "$BUILD_DIR/build.log" \
    | tail -40

APP_PATH=$(find "$DERIVED_DATA/Build/Products" -name "Firebreak.app" -maxdepth 4 | head -1)
if [ -z "$APP_PATH" ]; then
    echo "FAILED: Firebreak.app not found in build products" >&2
    exit 2
fi
echo "    .app: $APP_PATH"

echo "==> Step 3/4 — Package IPA"
rm -rf "$BUILD_DIR/Payload"
mkdir "$BUILD_DIR/Payload"
cp -R "$APP_PATH" "$BUILD_DIR/Payload/"

# Remove any existing signature so SideStore can re-sign with user's Apple ID
rm -rf "$BUILD_DIR/Payload/Firebreak.app/_CodeSignature"
find "$BUILD_DIR/Payload/Firebreak.app" -name "_CodeSignature" -type d -exec rm -rf {} + 2>/dev/null || true

(
    cd "$BUILD_DIR"
    rm -f Firebreak.ipa
    zip -qry Firebreak.ipa Payload/
)

if [[ "$SIGNED" -eq 1 ]]; then
    echo "==> Step 4/4 — Re-sign IPA"
    xcodebuild \
        -exportArchive \
        -archivePath "$DERIVED_DATA" \
        -exportPath "$BUILD_DIR/signed" \
        -exportOptionsPlist Supporting/ExportOptions.plist \
        -allowProvisioningUpdates \
        | tail -20 || echo "    (re-sign via exportArchive failed — unsigned IPA still produced)"
fi

echo ""
echo "SUCCESS ✓"
echo "  IPA:    $IPA_PATH"
echo "  Size:   $(du -h "$IPA_PATH" | awk '{print $1}')"
echo ""
echo "Install via:"
echo "  - SideStore: drag Firebreak.ipa onto SideStore, enter Apple ID"
echo "  - AltStore:  same as SideStore"
echo "  - TrollStore: open .ipa directly (if your iOS supports it)"
echo "  - ios-deploy:  ios-deploy --bundle $IPA_PATH"
