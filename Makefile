test:
	mojo test

fmt:
	mojo format *.mojo

build:
	mkdir -p heapq/
	cp heapq.mojo heapq/
	touch heapq/__init__.mojo
	echo "from .heapq import *" >> heapq/__init__.mojo
	mojo package heapq -o heapq.mojopkg
	rm -r heapq/

clean:
	rm -rf heapq/
	rm -f heapq.mojopkg
