SOURCE=DMC-S1000DXSL-A-01-00-00-00A-040A-A_EN-CA.XML

OUTPUT=s1kd2pdf.1
README=../s1kd2pdf.README.md

S1KD2DB=s1kd2db

PANDOC_MAN=pandoc -f docbook -t man -s
PANDOC_MD=pandoc -f docbook -t markdown_github -s

PREFIX=/usr/local
INSTALL_DIR=$(PREFIX)/share/man/man1

all: $(OUTPUT) $(README)

$(OUTPUT): $(SOURCE)
	$(S1KD2DB) $^ | $(PANDOC_MAN) -o $@

$(README): $(SOURCE)
	$(S1KD2DB) $^ | $(PANDOC_MD) -o $@

.PHONY: clean install uninstall

clean:
	rm -f $(OUTPUT) $(README)

install:
	cp $(OUTPUT) $(INSTALL_DIR)

uninstall:
	rm -f $(INSTALL_DIR)/$(OUTPUT)
