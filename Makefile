TS_NODE=node --experimental-specifier-resolution=node --loader=ts-node/esm

gen:
	flutter pub run build_runner watch --delete-conflicting-outputs

distribute.android:
	CHANNEL=stable $(TS_NODE) ./scripts/distribute.ts

distribute.android.beta:
	CHANNEL=beta $(TS_NODE) ./scripts/distribute.ts

#  max build number 2147483647
# time build number  22011218n
#                     y m d H n=M/6
# each 6 minute could only one build
BUILD_NUMBER=$(shell date +%y%m%d%H)
# todo enabled when 2.5 $(shell echo `expr $$(date +%M) / 6`);

build.android:
	flutter build apk --release \
		--target-platform android-arm64 \
		--split-per-abi \
		--build-number=$(BUILD_NUMBER)

build.ios:
	flutter build ios --flavor Release \
		--build-number=$(BUILD_NUMBER)

build.ipa:
	flutter build ipa --flavor Release \
		--build-number=$(BUILD_NUMBER)
	xcodebuild -exportArchive -exportPath ./build/ios \
		-archivePath ./build/ios/archive/Runner.xcarchive \
		-exportOptionsPlist ./build/ios/archive/Runner.xcarchive/info.plist

clean:
	flutter clean

convert.genshin-data: ensure.genshin-data convert

fmt:
	dart format .
	pnpx prettier -w ./scripts/{,**/}*.ts

dep: dep.npm dep.flutter
install: install.npm install.flutter

dep.npm:
	pnpm up --latest

dep.flutter:
	flutter pub upgrade

install.npm:
	pnpm i

install.flutter:
	flutter pub get

convert:
	$(TS_NODE) ./scripts/genshindb.convert.ts

define git_fetch
    if [[ -d $(2) ]]; then \
		echo "pulling...";  \
		cd $(2) && git pull --rebase; \
	else \
		git clone --depth=1 $(1) $(2); \
	fi
endef

ensure.genshin-data:
	$(call git_fetch,https://github.com/Dimbreath/GenshinData.git,./vendordata/GenshinData)

