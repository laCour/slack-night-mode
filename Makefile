all: clean build

build: default raw variants

clean:
	rm -rf css
	mkdir -p css/variants css/raw

default:
	sassc -t compact scss/main.scss css/black.css

variants:
	for sass in scss/themes/build-variants/*.scss; do \
		theme=`basename $$sass .scss`; \
	sassc -t compact $$sass  css/variants/$$theme.css; done

raw:
	sassc -t compact scss/styles.scss css/raw/black.css
