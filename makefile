.PHONY: docs test

NODEMON=./node_modules/.bin/nodemon
MOCHA=./node_modules/.bin/mocha

install:
	npm install

docs:
	#rm -rf ./docs
	./node_modules/.bin/docco src/{**/*,*} -l linear

clean:
	rm -rf ./lib
	#rm -rf ./docs

build:
	rm -rf ./lib
	./node_modules/.bin/coffee -t --bare -o lib/ -c src/
	./node_modules/.bin/coffee scripts/fetch_details.coffee
	mkdir ./lib/info
	cp src/info/details.json lib/info/details.json
	cp src/info/symbols.json lib/info/symbols.json

publish:
	npm publish

test:
	$(MOCHA) test/*.coffee

auto.test:
	$(NODEMON) --watch test --watch src -e coffee --exec "$(MOCHA) test/*.coffee"
