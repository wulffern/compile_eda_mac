
tclver=tcl8.6.10
tkver=tk8.6.10

${tclver}:
	wget https://prdownloads.sourceforge.net/tcl/${tclver}-src.tar.gz
	tar zxvf ${tclver}-src.tar.gz

${tkver}:
	wget https://prdownloads.sourceforge.net/tcl/${tkver}-src.tar.gz
	tar zxvf ${tkver}-src.tar.gz

tcl: ${tclver}
	cd ${tclver}/unix &&./configure --prefix=/usr/local/opt2/tcl-tk && make && sudo make install

tk: ${tkver}
	cd ${tkver}/unix && ./configure --prefix=/usr/local/opt2/tcl-tk --with-tcl=/usr/local/opt2/tcl-tk/lib --with-x --x-includes=/opt/X11/include --x-libraries=/opt/X11/lib   && make && sudo make install
	cd /usr/local/opt2/tcl-tk/bin/ && sudo install_name_tool -change /usr/local/opt2/tcl-tk/lib:/opt/X11/lib/libtk8.6.dylib /usr/local/opt2/tcl-tk/lib/libtk8.6.dylib wish8.6

magic:
	git clone https://github.com/RTimothyEdwards/magic

cmagic: magic
	perl -pe "s/-g/-g -Wno-error=implicit-function-declaration/ig" -i magic/configure
	cd magic && ./configure --prefix=/usr/local/opt2/tcl-tk --with-tcl=/usr/local/opt2/tcl-tk/lib --with-tk=/usr/local/opt2/tcl-tk/lib --x-includes=/opt/X11/include --x-libraries=/opt/X11/lib && make
	#cd magic && sudo make install


xschem:
	git clone https://github.com/StefanSchippers/xschem.git

cxschem:
	cd xschem && ./configure --prefix=/usr/local/eda
	perl -ibak -pe "s/CFLAGS/#CFLAGS/ig;s/LDFLAGS/#LDFLAGS/ig" xschem/Makefile.conf
	echo "CFLAGS=-I/opt/X11/include -I/opt/X11/include/cairo -I/usr/local/opt2/tcl-tk/include -O2\n LDFLAGS= -L/usr/local/opt2/tcl-tk/lib -L/opt/X11/lib -lm -lcairo  -lX11 -lXrender -lxcb -lxcb-render -lX11-xcb -lXpm -ltcl8.6 -ltk8.6" >> xschem/Makefile.conf
	cd xschem && make
	cd xschem && sudo make install
	sudo install_name_tool -change /usr/local/opt2/tcl-tk/lib:/opt/X11/lib/libtk8.6.dylib /usr/local/opt2/tcl-tk/lib/libtk8.6.dylib /usr/local/eda/bin/xschem

XCircuit:
	git clone git@github.com:RTimothyEdwards/XCircuit.git

cxcircuit: XCircuit
	cd XCircuit &&   ./configure   --with-tcl=/usr/local/opt2/tcl-tk/lib --with-tk=/usr/local/opt2/tcl-tk/lib --prefix /usr/local/opt2/   && make && sudo make install

netgen:
	git clone git@github.com:RTimothyEdwards/netgen.git

cnetgen: netgen
	perl -pe "s/-g/-g -Wno-error=implicit-function-declaration/ig" -i netgen/configure
	cd netgen && ./configure --prefix /usr/local/eda/ --with-tcl=/usr/local/opt2/tcl-tk/lib --with-tk=/usr/local/opt2/tcl-tk/lib --x-includes=/opt/X11/include --x-libraries=/opt/X11/lib && make && sudo make install
	sudo install_name_tool -change /usr/local/opt2/tcl-tk/lib:/opt/X11/lib/libtk8.6.dylib /usr/local/opt2/tcl-tk/lib/libtk8.6.dylib /usr/local/eda/lib/netgen/tcl/netgenexec
ngspice:
	git clone https://git.code.sf.net/p/ngspice/ngspice ngspice
	#cd ngspice; git checkout ngspice-36

# Pre-requisites
# brew install bison
# # fix bison paths
# Need to use gcc-11 or gcc-12 from homebrew to get openmp to work
cngspice: ngspice
#--enable-xspice --enable-cider --with-readline=yes --enable-openmp
	cd ngspice && ./autogen.sh && ./configure \
	--prefix /usr/local/eda/ \
	--with-x \
	--x-includes=/opt/X11/include \
	--x-libraries=/opt/X11/lib \
	--enable-xspice  \
	--enable-openmp \
	--enable-pss \
	--enable-cider \
	CC=gcc-12 CXX=g++-12 \
	--with-readline=/usr/local/opt/readline \
	--disable-debug CFLAGS=" -O2 -I/opt/X11/include/freetype2 -I/usr/local/include -I/usr/local/opt/readline/include " \
	LDFLAGS=" -L/usr/local/opt/readline/lib -L/usr/local/lib -lomp" \
	&& make clean && make -j8
	#cd ngspice &&  sudo make install
