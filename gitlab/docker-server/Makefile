include ../../Makefile

GITLAB_HOST=10.0.11.11
DOCKER_HOST=10.0.11.12

# OpenSSL
openssl.check:
	openssl s_client -connect ${GITLAB_HOST}:443 -showcerts < /dev/null

gitlab.crt:
	openssl s_client -connect ${GITLAB_HOST}:443 -showcerts < /dev/null | openssl x509 -outform PEM > gitlab.crt

# Gitlab Runner
runner.setup: gitlab.crt
	curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
	sudo apt install gitlab-runner
	sudo mkdir -p /etc/gitlab-runner/certs
	sudo cp gitlab.crt /etc/gitlab-runner/certs/gitlab-server.com.crt

runner.register:
	sudo gitlab-runner register

runner.unregister:
	sudo gitlab-runner unregister

runner.list:
	sudo gitlab-runner list

runner.delete:
	sudo gitlab-runner verify --delete

runner.config:
	sudo nano /etc/gitlab-runner/config.toml

# Gitlab Runner On Docker
runner.docker.setup: gitlab.crt
	sudo docker run -d --name runner --restart always -v /var/run/docker.sock:/var/run/docker.sock -v runner_conf:/etc/gitlab-runner gitlab/gitlab-runner:latest
	sudo cp gitlab.crt /var/lib/docker/volumes/runner_conf/_data/certs/gitlab-server.com.crt

runner.docker.clean:
	sudo docker stop runner
	sudo docker rm runner

runner.docker.register:
	sudo docker exec -it runner gitlab-runner register

runner.docker.unregister:
	sudo docker exec -it runner gitlab-runner unregister

runner.docker.list:
	sudo docker exec -it runner gitlab-runner list

runner.docker.delete:
	sudo docker exec -it runner gitlab-runner verify --delete

runner.docker.config:
	sudo nano /var/lib/docker/volumes/runner_conf/_data/config.toml

# Apache On Docker
apache.docker.setup:
	sudo docker run -d --name web --restart always -p 80:80 -v web_data:/usr/local/apache2/htdocs httpd

apache.docker.clean:
	sudo docker stop web
	sudo docker rm web