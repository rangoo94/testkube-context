# Multiple contexts for Testkube CLI

## Installation

Install with:

```
sudo sh -c "`curl -fsSL https://raw.github.com/rangoo94/testkube-context/main/install.sh`"
```

or copy the [`testkube-context.sh`](./testkube-context.sh) file to desired destination.

## Usage

```shell
$ tkc
[ ] default (api.testkube.dev / Testkube / dawid-minikube-arm64-docker-driver)
[ ] dev (api.testkube.dev / Testkube / Testkube-cloud-test-dev)
[*] prod (api.testkube.io / Testkube / testkube-cloud-basic)

$ tkc use dev
[ ] default (api.testkube.dev / Testkube / dawid-minikube-arm64-docker-driver)
[*] dev (api.testkube.dev / Testkube / Testkube-cloud-test-dev)
[ ] prod (api.testkube.io / Testkube / testkube-cloud-basic)

$ tkc new xyz
Created context: xyz
[ ] default (api.testkube.dev / Testkube / dawid-minikube-arm64-docker-driver)
[ ] dev (api.testkube.dev / Testkube / Testkube-cloud-test-dev)
[ ] prod (api.testkube.io / Testkube / testkube-cloud-basic)

$ tkc
[ ] default (api.testkube.dev / Testkube / dawid-minikube-arm64-docker-driver)
[ ] dev (api.testkube.dev / Testkube / Testkube-cloud-test-dev)
[ ] prod (api.testkube.io / Testkube / testkube-cloud-basic)
[*] xyz (null)

$ testkube login --root-domain testkube.xyz

Login

Please select an option:
  > GitHub

Your browser should open automatically. If not, please open this link in your browser:
https://api.testkube.xyz/idp/auth?access_type=offline&client_id=testkube-cloud-cli&connector_id=github&redirect_uri=http%3A%2F%2F127.0.0.1%3A8090%2Fcallback&response_type=code&scope=openid+profile+email+offline_access&state=state
(just login and get back to your terminal)

Continue [Y/n]: Yes

 ✅  waiting for auth token

Please select an option:
  > Testkube

Please select an option:
  > testkube-cloud-test-xyz

Your config was updated with new values 🥇

Your current context is set to

  Namespace        :
  Telemetry Enabled: false

$ tkc
[ ] default (api.testkube.dev / Testkube / dawid-minikube-arm64-docker-driver)
[ ] dev (api.testkube.dev / Testkube / Testkube-cloud-test-dev)
[ ] prod (api.testkube.io / Testkube / testkube-cloud-basic)
[*] xyz (api.testkube.xyz / Testkube / testkube-cloud-test-xyz)
```
