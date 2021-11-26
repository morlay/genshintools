gen:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

BASE_HREF=/

build.web: flutter.dep
	flutter build web --release --base-href $(BASE_HREF)

flutter.dep:
	flutter pub get

sync.all: pnpm.i convert.genshin-data sync.images

sync.images: node.images.sync

convert.genshin-data: ensure.paimon-moe ensure.genshin-data node.genshin-data.convert

fmt:
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

ensure.paimon-moe:
	$(call git_fetch,https://github.com/MadeBaruna/paimon-moe.git,./vendordata/paimon-moe)

node.%:
	pnpx ts-node -T ./scripts/$*.ts

