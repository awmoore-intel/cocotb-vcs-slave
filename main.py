#import ctypes
#ctypes.CDLL("./libvcsmain.so")
import os
from cffi import FFI
# fork in python
# https://stackoverflow.com/questions/1952210/how-to-fork-a-process-in-python

print("Hello world")

ffi = FFI()
ffi.cdef("""
void VcsInit();
int vcs_main(int argc, char** argv);
void vlog_startup_routines_bootstrap();
void VcsSimUntil(unsigned long *);
void vpi_control(int, int);
void gpi_set_signal_value_int(void* sig_hdl, int32_t value,
                              int action);
         """)

#l = ffi.dlopen(None)
c = ffi.dlopen(os.environ["PWD"] + "/libcrc.so", flags=ffi.RTLD_GLOBAL)
p = ffi.new("char[]", b"libcrc.so")
u = ffi.new("char[]", b"-ucli")
a = ffi.new("char[]", b"-do")
b = ffi.new("char[]", b"run.do")
c.vcs_main(4, ffi.new("char*[]", [p,u, a,b]))
c.VcsInit()

os.environ["COCOTB_TEST_MODULES"] = "test"
vcs = ffi.dlopen("./venv/lib/python3.10/site-packages/cocotb/libs/libcocotbvpi_vcs.so")
vcs.vlog_startup_routines_bootstrap()

import pygpi.entry
pygpi.entry.load_entry([])
c.VcsSimUntil(ffi.new("unsigned long*", 1000000))
print("END")