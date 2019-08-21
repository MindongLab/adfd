
all: clean markdown images assets

markdown: 
	cd help && \
	generate-md --layout mixu-bootstrap-2col --input index.md --output ../build

clean:
	rm -rf build
	mkdir build

images:
	cp -rf ./help/images ./build/

assets:
	cp -rf ./help/assets ./build/