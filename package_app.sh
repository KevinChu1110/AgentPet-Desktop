#!/bin/bash

# 設定變數
APP_NAME="AgentPet"
BUNDLE_ID="com.kevinchu.AgentPet"
APP_BUNDLE="$APP_NAME.app"

echo "🚀 開始編譯 AgentPet Release 版本..."
# 使用 swift build 編譯
swift build -c release --arch arm64

# 取得編譯好的執行檔路徑 (處理不同架構路徑)
EXECUTABLE_PATH=$(find .build -name "$APP_NAME" -type f -perm +111 | grep "release" | head -n 1)

if [ -z "$EXECUTABLE_PATH" ]; then
    echo "❌ 找不到編譯好的執行檔，請檢查編譯是否成功。"
    exit 1
fi

echo "📦 發現執行檔於: $EXECUTABLE_PATH"
echo "🛠️ 正在封裝 $APP_BUNDLE..."

# 清理舊的封裝
rm -rf "$APP_BUNDLE"
rm -f "$APP_NAME.zip"

# 建立目錄結構
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# 複製執行檔
cp "$EXECUTABLE_PATH" "$APP_BUNDLE/Contents/MacOS/"

# 建立 Info.plist
cat > "$APP_BUNDLE/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>$BUNDLE_ID</string>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>14.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

echo "✅ 打包完成：$APP_BUNDLE"

# 壓縮
echo "🗜️ 正在壓縮為 $APP_NAME.zip..."
zip -r "$APP_NAME.zip" "$APP_BUNDLE" > /dev/null

echo "🎉 準備就緒！您可以將 $APP_NAME.zip 上傳到 GitHub Releases 了。"
