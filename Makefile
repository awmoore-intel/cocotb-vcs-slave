
simv: Crc32.sv
	vcs -full64 -sverilog -debug_all Crc32.sv -o simv

# VCS Compiled Design
libcrc.so: Crc32.sv
	vcs -full64 -slave -e vcs_main -sverilog -debug_all Crc32.sv -o libcrc.so -CFLAGS "-g -fPIC" \
	   -timescale=1ns/1ps \
	   +vpi -P pli.tab 

# Thread-Local-Storage library required for VCS
vcs_tls.so: $(VCS_HOME)/linux64/lib/vcs_tls.o
	ld -shared -o vcs_tls.so $^

venv:
	python3 -m venv venv
	venv/bin/pip install --upgrade pip
	venv/bin/pip install cffi wheel
	venv/bin/pip install ./_cocotb

run: venv libcrc.so vcs_tls.so main.py test.py
	bash -c "LD_PRELOAD=./vcs_tls.so ./venv/bin/python main.py"

waves:
	dve -vpd inter.vpd

clean:
	rm -rf vcs_tls.so libcrc.so* simv* venv csrc inter.vpd ucli.key