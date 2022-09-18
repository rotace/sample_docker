include ../Makefile

build:
	cp Doxyfile tmpfile
	echo "GENERATE_HTML=YES" >> tmpfile
	echo "GENERATE_LATEX=NO" >> tmpfile
	echo "GENERATE_RTF=NO" >> tmpfile
	echo "GENERATE_MAN=NO" >> tmpfile
	echo "GENERATE_XML=NO" >> tmpfile
	echo "HTML_OUTPUT=/output/sample" >> tmpfile
	sudo docker run --rm -v "${PWD}":/data -v offline_web_data:/output -it localhost:5000/doxygen doxygen tmpfile

clean:
	sudo rm -rf html latex tmpfile