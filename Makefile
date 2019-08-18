
all: clean markdown images

markdown: 
	cd help && \
	generate-md --layout mixu-bootstrap-2col --input index.md --output ../build

clean:
	rm -rf build
	mkdir build

images:
	cp -rf ./help/images ./build/