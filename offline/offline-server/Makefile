include ../../Makefile

REGISTRY_NAME=registry1
REGISTRY_HOST=localhost
REGISTRY_PORT=5000

# offline task
reg.start:
	sudo docker run -d --name=${REGISTRY_NAME} --restart=always -p ${REGISTRY_PORT}:${REGISTRY_PORT} -v registry_data:/var/lib/registry registry

reg.ls:
	curl http://${REGISTRY_HOST}:${REGISTRY_PORT}/v2/_catalog

reg.stop:
	sudo docker stop ${REGISTRY_NAME}

reg.clean: reg.stop
	sudo docker rm ${REGISTRY_NAME}


git.start: com.up

git.ls: com.ps

git.clean: com.down