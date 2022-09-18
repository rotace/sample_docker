include ../../Makefile

GITLAB_HOST=10.0.11.11
DOCKER_HOST=10.0.11.12
SSL_DIR=/etc/gitlab/ssl

openssl-backup:
	sudo mv ${SSL_DIR}/server.crt server.crt.back
	sudo mv ${SSL_DIR}/server.key server.key.back

openssl-genkey:
	sudo openssl genrsa -out ${SSL_DIR}/server.key 2048

openssl-gencsr:
	sudo openssl req -new -key ${SSL_DIR}/server.key -out ${SSL_DIR}/cert.csr

openssl-gencrt:
	sudo openssl x509 -in ${SSL_DIR}/cert.csr -out ${SSL_DIR}/server.crt -req -signkey ${SSL_DIR}/server.key -days 3650 -extfile openssl.cnf

openssl-check:
	openssl s_client -connect ${GITLAB_HOST}:443 -showcerts < /dev/null

