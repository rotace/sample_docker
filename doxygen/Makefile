include ../Makefile

doc.build:
	cp Doxyfile tmpfile
	echo "GENERATE_HTML=YES" >> tmpfile
	echo "GENERATE_LATEX=NO" >> tmpfile
	echo "GENERATE_RTF=NO" >> tmpfile
	echo "GENERATE_MAN=NO" >> tmpfile
	echo "GENERATE_XML=NO" >> tmpfile
	echo "HTML_OUTPUT=/output/sample" >> tmpfile
	sudo docker run --rm -v "${PWD}":/data -v offline_web_data:/output -it hrektts/doxygen doxygen tmpfile

doc.ls:
	sudo ls /var/lib/docker/volumes/offline_web_data/_data/sample/

doc.clean:
	sudo docker volume rm offline_web_data