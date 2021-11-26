TS_NODE=node --experimental-specifier-resolution=node --loader=ts-node/esm

gen:
	flutter pub run build_runner watch --delete-conflicting-outputs

dep:
	pnpm up --latest
	flutter pub upgrade

BASE_HREF=/

build.web:
	flutter build web --release --base-href=$(BASE_HREF)

distribute.android:
	CHANNEL=stable $(TS_NODE) ./scripts/distribute.ts

distribute.android.beta:
	CHANNEL=beta $(TS_NODE) ./scripts/distribute.ts

build.android:
	flutter build apk --release --build-number=$(shell date +%m%d%H%M)

build.ios:
	flutter build ios --no-codesign --release --build-number=$(shell date +%m%d%H%M)

clean:
	flutter clean

convert.genshin-data: ensure.genshin-data convert

fmt:
	dart format .
	pnpx prettier -w ./scripts/{,**/}*.ts

pnpm.i:
	pnpm i

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

convert.builds:
	$(TS_NODE) ./scripts/sync.builds.ts

convert:
	$(TS_NODE) ./scripts/genshindb.convert.ts

