
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

# Web
web.setup:
	sudo docker run -d --name web --restart always -p 80:80 -v web_data:/usr/local/apache2/htdocs httpd

web.clean:
	sudo docker stop web
	sudo docker rm web

# Doxygen
doc.create:
	sudo docker run --rm -v "${PWD}":/data -it hrektts/doxygen doxygen Doxyfile

doc.deploy:
	sudo docker exec web rm -rf /usr/local/apache2/htdocs/local/sample_docker
	sudo docker exec web mkdir -p /usr/local/apache2/htdocs/local/sample_docker
	sudo docker cp html web:/usr/local/apache2/htdocs/local/sample_docker

doc.clean:
	sudo docker exec web rm -rf /usr/local/apache2/htdocs/local/sample_docker
	sudo rm -rf html/ latex/
