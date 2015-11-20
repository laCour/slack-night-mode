all: clean build

build: default variants

clean:
	rm -rf css
	mkdir -p css/variants

default:
	sassc -t compact scss/main.scss css/aubergine.css

variants:
	for sass in scss/themes/build-variants/*.scss; do \
		theme=`basename $$sass .scss`; \
	sassc -t compact $$sass  css/variants/$$theme.css; done
