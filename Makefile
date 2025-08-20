.PHONY: build clean run lsp build-bouncekit

# Build BounceKit framework only
build-bouncekit:
	xcodebuild -project BouncyPresenceIndicators/BouncyPresenceIndicators.xcodeproj \
		-scheme BounceKit \
		-sdk iphonesimulator \
		-configuration Debug \
		-derivedDataPath build \
		build

# Configure xcode-build-server for LSP support (Neovim, etc.)
lsp:
	cd BouncyPresenceIndicators && xcode-build-server config \
		-project BouncyPresenceIndicators.xcodeproj \
		-scheme BouncyPresenceIndicators

# Build the entire project for iOS Simulator
build:
	xcodebuild -project BouncyPresenceIndicators/BouncyPresenceIndicators.xcodeproj \
		-scheme BouncyPresenceIndicators \
		-sdk iphonesimulator \
		-configuration Debug \
		-derivedDataPath build \
		build

# Clean build artifacts
clean:
	xcodebuild -project BouncyPresenceIndicators/BouncyPresenceIndicators.xcodeproj \
		-scheme BouncyPresenceIndicators \
		clean
	rm -rf build

# Build and run in iOS Simulator
run: build
	xcrun simctl boot "iPhone 15 Pro" 2>/dev/null || true
	open -a Simulator
	xcrun simctl install booted build/Build/Products/Debug-iphonesimulator/BouncyPresenceIndicators.app
	xcrun simctl launch booted com.example.BouncyPresenceIndicators