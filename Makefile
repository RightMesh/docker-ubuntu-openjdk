IMG=rightmesh/ubuntu-openjdk

.PHONY: all bionic xenial

all: bionic xenial

bionic: bionic/Dockerfile
	@docker build -t $(IMG):18.04 bionic/ 1>/dev/null

xenial: xenial/Dockerfile
	@docker build -t $(IMG):16.04 xenial/ 1>/dev/null
