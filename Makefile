APP_NAME := Cardinal
BUNDLE_ID := com.madda.cardinal
APP_DIR := cardinal
BUILD_TARGET := universal-apple-darwin
RELEASE_APP := $(APP_DIR)/src-tauri/target/$(BUILD_TARGET)/release/bundle/macos/$(APP_NAME).app
INSTALL_DIR := /Applications
INSTALLED_APP := $(INSTALL_DIR)/$(APP_NAME).app

.PHONY: prod

prod:
	@osascript -e 'tell application id "$(BUNDLE_ID)" to quit' >/dev/null 2>&1 || true
	@pkill -x "$(APP_NAME)" >/dev/null 2>&1 || true
	cd "$(APP_DIR)" && npm run tauri build -- --target "$(BUILD_TARGET)"
	rm -rf "$(INSTALLED_APP)"
	cp -R "$(RELEASE_APP)" "$(INSTALL_DIR)/"
	open "$(INSTALLED_APP)"
