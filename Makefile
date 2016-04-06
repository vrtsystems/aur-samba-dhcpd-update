.PHONY: clean all install

all: build/samba-dnsupdate.sh \
		build/dhcpd-update-samba-dns.sh \
		build/dhcpd-update-samba-dns.conf

build/.stamp:
	mkdir build
	touch $@

# Adjust paths to suit Debian/Ubuntu
build/%: % build/.stamp
	sed -e 's:/etc/dhcpd:/etc/dhcp:g' \
		$^ > $@

clean:
	-rm -fr build

install:
	install -v -d -m 0755 $(DESTDIR)/usr/bin
	install -v -d -m 0755 $(DESTDIR)/etc/dhcp
	install -v -m 0755 build/samba-dnsupdate.sh $(DESTDIR)/usr/bin
	install -v -m 0755 build/dhcpd-update-samba-dns.sh $(DESTDIR)/usr/bin
	install -v -m 0755 build/dhcpd-update-samba-dns.conf $(DESTDIR)/etc/dhcp
