
all: build/rio_build.bit

rio.ldf: rio.tcl debouncer.v blink.v rio.v
	diamondc rio.tcl

build/rio_build.bit: rio.ldf
	diamondc syn.tcl

clean:
	rm -rf build rio.ldf
