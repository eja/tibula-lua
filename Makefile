ejaPath=/opt/eja.it
ejaVersion=$(shell date +%y%m%d%H%M)

all:  tibula


backup:
	tar zcR $(ejaPath)/lib/tibula > $(ejaPath)/bkp/ejaTibula-$(ejaVersion).tar.gz


clean:
	@- rm $(ejaPath)/lib/tibula.eja
	

clean-luasql:
	@- rm -Rf $(ejaPath)/lib/luasql


clean-eja:
	@- rm -Rf $(ejaPath)/src/
	

clean-all: clean clean-luasql clean-eja
	@  echo "all clean"
	
update: clean backup
	@  git add .
	@- git commit
	@  git push -u origin master
	@  scp /opt/eja.it/bkp/ejaTibula-$(ejaVersion).tar.gz ubaldu@frs.sourceforge.net:/home/frs/project/tibula/tibula-$(ejaVersion).tar.gz

	
$(ejaPath)/src/eja: 
	@-  git clone https://github.com/ubaldus/eja.git $(ejaPath)/src/
	@  cd $(ejaPath)/src/ && make 
	
	
$(ejaPath)/bin/eja:
	@  cd $(ejaPath)/src/ && make install


$(ejaPath)/lib/luasql: $(ejaPath)/src/eja
	@- mkdir -p $(ejaPath)/bin
	@- mkdir -p $(ejaPath)/lib
	@- mkdir -p $(ejaPath)/var
	@- mkdir -p $(ejaPath)/tmp
	@- rm -Rf $(ejaPath)/tmp/luasql
	@  git clone https://github.com/ubaldus/luasql.git $(ejaPath)/tmp/luasql
	
	
mysql: $(ejaPath)/lib/luasql 
	@ cd $(ejaPath)/tmp/luasql && make LUA_LIBDIR=$(ejaPath)/lib/ CFLAGS="-I"$(ejaPath)"/src/lua/src/ -fPIC " mysql install
	@  make tibula


sqlite3: $(ejaPath)/lib/luasql 
	@ cd $(ejaPath)/tmp/luasql && make LUA_LIBDIR=$(ejaPath)/lib/ CFLAGS="-I"$(ejaPath)"/src/lua/src/ -fPIC " sqlite3 install
	@ make tibula


tibula: $(ejaPath)/src/eja $(ejaPath)/bin/eja
	@  cat *.lua > $(ejaPath)/lib/tibula.lua
	@  $(ejaPath)/src/eja --export $(ejaPath)/lib/tibula.lua
	@- rm $(ejaPath)/lib/tibula.lua	

