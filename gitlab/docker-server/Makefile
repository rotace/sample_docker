GITLAB_HOST=10.0.11.11
DOCKER_HOST=10.0.11.12

openssl-check:
	openssl s_client -connect ${GITLAB_HOST}:443 -showcerts < /dev/null

openssl-register:
	openssl s_client -connect ${GITLAB_HOST}:443 -showcerts < /dev/null | openssl x509 -outform PEM > /etc/gitlab-runner/certs/gitlab-server.local.crt	

register-gitlab-runner-repository:
	curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash


