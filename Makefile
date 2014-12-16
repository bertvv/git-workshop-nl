## Presentation makefile

# Directory for reveal.js
REVEAL_JS_DIR := reveal.js

# File name of the reveal.js tarball
REVEAL_JS_TAR := 2.6.1.tar.gz

# Download URL
REVEAL_JS_URL := https://github.com/hakimel/reveal.js/archive/$(REVEAL_JS_TAR)

# Style for code blocks
# Valid values are the names of css files in reveal.js/lib/css/
highlight_style := zenburn

# Convert the list of source files (Markdown) into presentations
sources := $(wildcard *.md)
objects := $(patsubst %.md,%.html,$(sources))
templates := $(wildcard template/*)

all: $(objects)

## Build presentation
%.html: %.md reveal.js $(templates)
	pandoc --standalone \
		--template=template/reveal-template.html \
		--include-in-header=template/custom.css \
		--no-highlight --variable hlss=$(highlight_style) \
		--to revealjs \
		--output $@ $<

## Download and install reveal.js locally
$(REVEAL_JS_DIR):
	wget $(REVEAL_JS_URL)
	tar xzf $(REVEAL_JS_TAR)
	rm $(REVEAL_JS_TAR)
	mv -T reveal.js* $(REVEAL_JS_DIR)

## Cleanup

.PHONY: clean mrproper

clean:
	rm -f *.html
	rm -f *.pdf

## Thorough cleanup (also removes reveal.js)
mrproper: clean
	rm -rf $(REVEAL_JS_DIR)

## Handouts
%-handouts.pdf: %.md
	pandoc --variable mainfont="DejaVu Sans" \
		--variable monofont="DejaVu Sans Mono" \
		--variable fontsize=11pt \
		--variable geometry:margin=1.5cm \
		--from markdown  $< \
		--latex-engine=lualatex \
		--output $@

