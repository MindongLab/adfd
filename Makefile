
all: clean markdown images

markdown: 
	pushd help && \
	generate-md --layout mixu-bootstrap-2col --input index.md --output ../build

clean:
	rm -rf build
	mkdir build

images:
	cp -rf ./help/images ./build/