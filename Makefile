prefix = "/usr/local"
ejaPathBin=$(prefix)/bin/eja
ejaPathLib=$(prefix)/lib/eja
ejaVersion = $(shell date +%y%m%d%H%M)


all:  sqlite3 mysql tibula

eja:
	@-  git clone https://github.com/ubaldus/eja.git eja
	@  cd eja && make 
	
$(prefix)/bin/eja:
	@  cd eja && make prefix=$(prefix) install
	
luasql:
	@  git clone https://github.com/ubaldus/luasql.git luasql	

mysql: eja luasql
	@  cd luasql && make LUA_LIBDIR="$(prefix)/lib/eja" CFLAGS="-I../eja/lua/src/ -fPIC " mysql install
	@  make tibula


sqlite3: eja luasql
	@  cd luasql && make LUA_LIBDIR="$(prefix)/lib/eja" CFLAGS="-I../eja/lua/src/ -fPIC " sqlite3 install
	@  make tibula


tibula:
	@  cat *.lua > $(prefix)/lib/eja/tibula.lua
	@  eja --export $(prefix)/lib/eja/tibula.lua
	@- rm $(prefix)/lib/eja/tibula.lua	
	

clean:
	@- rm $(prefix)/lib/eja/tibula.eja


clean-sql:
	@- rm -Rf $(prefix)/lib/eja/luasql
	@- rm -Rf luasql


clean-eja:
	@- rm -Rf eja
	

clean-all: clean clean-sql clean-eja


install: $(prefix)/bin/eja tibula


update: clean-all
	@  git add .
	@- git commit
	@  git push -u origin master
	@  tar zcR ../tibula > /tmp/ejaTibula-$(ejaVersion).tar.gz
	@  scp /tmp/ejaTibula-$(ejaVersion).tar.gz ubaldu@frs.sourceforge.net:/home/frs/project/tibula/tibula-$(ejaVersion).tar.gz
	
