PREFIX=/usr/local
FOLDER=$(PREFIX)/share/xml/s1000d/stylesheet/S1000D-XSL-Stylesheets

install:
	mkdir -p $(FOLDER)
	cp -r s1000dtodb dbtofo $(FOLDER)
	cp s1kd2pdf $(PREFIX)/bin
