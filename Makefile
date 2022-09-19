
hello:
	echo "Hello Docker Sample!"

# docker command
ps:
	sudo docker ps

psa:
	sudo docker ps -a

images:
	sudo docker image ls

volumes:
	sudo docker volume ls

df:
	sudo docker system df

clean:
	sudo docker system prune -a

# docker-compose command
com.ps:
	sudo docker-compose ps

com.images:
	sudo docker-compose images

com.check:
	sudo docker-compose config

com.build:
	sudo docker-compose build

com.up: com.build
	sudo docker-compose up -d

com.down:
	sudo docker-compose down

