IMG=rightmesh/ubuntu-openjdk

.PHONY: all bionic xenial disco

all: bionic xenial disco

disco: disco/Dockerfile
	@docker build -t $(IMG):19.04 disco/ 1>/dev/null

bionic: bionic/Dockerfile
	@docker build -t $(IMG):18.04 bionic/ 1>/dev/null

xenial: xenial/Dockerfile
	@docker build -t $(IMG):16.04 xenial/ 1>/dev/null
