bootstrap.all: bootstrap.npm bootstrap

bootstrap:
	dart pub global activate melos
	dart pub global activate pubtidy
	melos bootstrap

lint:
	melos analyze --no-select

gen:
	melos generate

dep:
	melos dep

clean:
	melos clean

fmt:
	melos exec -c 1 -- pubtidy
	melos format

#  max build number 2147483647
#                    220217115
# time build number  22011218n
#                     y m d H n=M/6
# each 6 minute could only one build
BUILD_NUMBER=$(shell TZ=UTC-8 date +%y%m%d%H)$(shell TZ=UTC-8 echo `expr $$(date +%M) / 6`)

build.android:
	BUILD_NUMBER=$(BUILD_NUMBER) melos build:android

build.ios:
	BUILD_NUMBER=$(BUILD_NUMBER) melos build:ios

## Node

TS_NODE=node --experimental-specifier-resolution=node --loader=ts-node/esm

dep.npm:
	pnpm up --latest

bootstrap.npm:
	pnpm i

convert:
	$(TS_NODE) ./scripts/genshindb.convert.ts

convert.debug:
	$(TS_NODE) ./scripts/debug.ts


define git_fetch
    if [[ -d $(2) ]]; then \
		echo "pulling...";  \
		cd $(2) && git pull --rebase; \
	else \
		git clone --depth=1 $(1) $(2); \
	fi
endef

ensure.vendor:
	git submodule update --init --remote --force