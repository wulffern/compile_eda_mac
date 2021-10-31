
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
	cd ${tkver}/unix &&./configure ./configure --prefix=/usr/local/opt2/tcl-tk --with-tcl=/usr/local/opt2/tcl-tk/lib --with-x --x-includes=/opt/X11/include --x-libraries=/opt/X11/lib   && make && sudo make install
	cd /usr/local/opt2/tcl-tk/bin/ && sudo install_name_tool -change /usr/local/opt2/tcl-tk/lib:/opt/X11/lib/libtk8.6.dylib /usr/local/opt2/tcl-tk/lib/libtk8.6.dylib wish8.6

magic:
	git clone https://github.com/RTimothyEdwards/magic

cmagic: magic
	perl -pe "s/-g/-g -Wno-error=implicit-function-declaration/ig" -i magic/configure
	cd magic && ./configure --with-tcl=/usr/local/opt2/tcl-tk/lib --with-tk=/usr/local/opt2/tcl-tk/lib --x-includes=/opt/X11/include --x-libraries=/opt/X11/lib && make && sudo make install
