# Infrastructure

For my k8. Local setup

## Prerequisites
* Docker
* Kind
* Homebrew (macOS only)

## Local development

### Kind

#### Installation

You can install kind by just running `make install_kind`, on Linux or MacOS (brew)

#### Create cluster

```bash
make create_cluster
```

This will create a kind cluster with the name `cluster-1`. It will have 3 nodes; Control plane and 2 workers. Kubeconfig will automatically with be updated to `kind-cluster-1`, thanks to `kind` for being so kind.

#### Delete cluster

```bash
make delete_cluster 
```

This will delete the `cluster-1`

#### Load image directly into the cluster

```bash
kind load docker-image my-custom-image-0 my-custom-image-1 --name cluster-1
```

#### Use private docker registery

RTFD [here](https://kind.sigs.k8s.io/docs/user/private-registries)

#### More configs

See `kind/config.yaml` file.