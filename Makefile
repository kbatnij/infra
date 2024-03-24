KIND_VERSION := 0.22.0

all: check_docker install_kind create_cluster

check_docker:
	@command -v docker > /dev/null || (echo "Docker not found, please install Docker" && exit 1)
	@echo "Docker is installed."

install_kind: check_docker
	@command -v kind > /dev/null || (echo "Installing Kind..." && \
	OS=$$(uname -s) && ARCH=$$(uname -m) && \
	case $$OS in \
		Linux) \
			URL="https://kind.sigs.k8s.io/dl/v$(KIND_VERSION)/kind-linux-$$ARCH" && \
			[ $$ARCH = "x86_64" ] && SUFFIX="amd64" || [ $$ARCH = "aarch64" ] && SUFFIX="arm64" || { echo "Unsupported architecture: $$ARCH"; exit 1; }; \
			curl -Lo kind "$$URL-$$SUFFIX" && chmod +x kind && sudo mv kind /usr/local/bin/kind ;; \
		Darwin) \
			command -v brew > /dev/null || { echo "Homebrew not found, please install Homebrew."; exit 1; }; \
			brew install kind ;; \
		*) \
			echo "Unsupported OS: $$OS" && exit 1 ;; \
	esac)
	@echo "Kind installation successful."

create_cluster: check_docker
	@kind create cluster --config kind/config.yaml --name cluster-1

delete_cluster: check_docker
	@kind delete cluster --name cluster-1

.PHONY: all check_docker install_kind create_cluster delete_cluster
