prefix = /usr/local
folder = $(prefix)/share/xml/s1000d/stylesheet/S1000D-XSL-Stylesheets

all:

.PHONY: install uninstall

install:
	mkdir -p $(folder)
	cp -r s1000dtodb dbtofo $(folder)
	cp s1kd2pdf $(prefix)/bin
	$(MAKE) -C doc install

uninstall:
	rm -rf $(folder)
	rm -f $(prefix)/bin/s1kd2pdf
	$(MAKE) -C doc uninstall
