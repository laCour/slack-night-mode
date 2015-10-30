all: clean build

build: default themes

clean:
	rm -rf css/*
	mkdir css/variants

default:
	sass scss/main.scss:css/default.css --style compact

themes:
	for sass in scss/themes/build-variants/*.scss; do \
		theme=`basename $$sass .scss`; \
	sass $$sass:css/variants/$$theme.css --style compact; done
