PREFIX=/usr/local
FOLDER=$(PREFIX)/share/xml/s1000d/stylesheet/S1000D-XSL-Stylesheets

all:

.PHONY: install uninstall

install:
	mkdir -p $(FOLDER)
	cp -r s1000dtodb dbtofo $(FOLDER)
	cp s1kd2pdf $(PREFIX)/bin
	$(MAKE) -C doc install

uninstall:
	rm -rf $(FOLDER)
	rm -f $(PREFIX)/bin/s1kd2pdf
	$(MAKE) -C doc uninstall
