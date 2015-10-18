ejaPath=/opt/eja.it
ejaVersion=$(shell date +%y%m%d%H%M)


all:  tibula


eja: $(ejaPath)
	@-  git clone https://github.com/ubaldus/eja.git eja
	@  cd eja && make 
	

$(ejaPath):
	@- mkdir -p $(ejaPath)/bin
	@- mkdir -p $(ejaPath)/lib
	@- mkdir -p $(ejaPath)/var
	@- mkdir -p $(ejaPath)/tmp
	
	
$(ejaPath)/bin/eja:
	@  cd eja && make install
	

$(ejaPath)/bkp:
	@  mkdir -p $(ejaPath)/bkp


mysql: eja
	@- rm -Rf luasql
	@  git clone https://github.com/ubaldus/luasql.git luasql
	@  cd luasql && make LUA_LIBDIR=$(ejaPath)/lib/ CFLAGS="-I../eja/lua/src/ -fPIC " mysql install
	@  make tibula


sqlite3: eja
	@- rm -Rf luasql
	@  git clone https://github.com/ubaldus/luasql.git luasql
	@  cd luasql && make LUA_LIBDIR=$(ejaPath)/lib/ CFLAGS="-I../eja/lua/src/ -fPIC " sqlite3 install
	@  make tibula


tibula: eja
	@  cat *.lua > $(ejaPath)/lib/tibula.lua
	@  eja/eja --export $(ejaPath)/lib/tibula.lua
	@- rm $(ejaPath)/lib/tibula.lua	
	

backup: $(ejaPath)/bkp
	tar zcR ../tibula > $(ejaPath)/bkp/ejaTibula-$(ejaVersion).tar.gz


clean:
	@- rm $(ejaPath)/lib/tibula.eja


clean-sql:
	@- rm -Rf $(ejaPath)/lib/luasql
	@- rm -Rf luasql


clean-eja:
	@- rm -Rf eja
	

clean-all: clean clean-sql clean-eja


update: clean-all backup
	@  git add .
	@- git commit
	@  git push -u origin master
	@  scp /opt/eja.it/bkp/ejaTibula-$(ejaVersion).tar.gz ubaldu@frs.sourceforge.net:/home/frs/project/tibula/tibula-$(ejaVersion).tar.gz
	

install: $(ejaPath)/bin/eja tibula


uninstall: clean-all
	@- rm ${ejaPath}/bin/eja


