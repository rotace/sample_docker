include ../../Makefile

REGISTRY_NAME=registry1
REGISTRY_HOST=localhost
REGISTRY_PORT=5000

# online task
push.httpd:
	sudo docker pull httpd
	sudo docker tag httpd ${REGISTRY_HOST}:${REGISTRY_PORT}/httpd
	sudo docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/httpd

push.doxygen:
	sudo docker pull hrektts/doxygen
	sudo docker tag hrektts/doxygen ${REGISTRY_HOST}:${REGISTRY_PORT}/doxygen
	sudo docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/doxygen

push.cpp:
	sudo docker build -t ${REGISTRY_HOST}:${REGISTRY_PORT}/cpp ./cpp
	sudo docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/cpp

push.python:
	sudo docker build -t ${REGISTRY_HOST}:${REGISTRY_PORT}/python ./python
	sudo docker push ${REGISTRY_HOST}:${REGISTRY_PORT}/python
