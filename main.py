import os
from cffi import FFI

print("Hello world")

ffi = FFI()
ffi.cdef("""
void VcsInit();
int vcs_main(int argc, char** argv);
void vlog_startup_routines_bootstrap();
void cocotbvpi_entry_point();
void VcsSimUntil(unsigned long *);
void vpi_control(int, int);
int _embed_sim_init(int argc, char** argv);
void* gpi_get_root_handle(const char *name);
void* gpi_get_handle_by_name(void* base, const char *name, int discovery_method);
void gpi_set_signal_value_int(void* sig_hdl, int32_t value,
                              int action);
         """)

#l = ffi.dlopen(None)
c = ffi.dlopen("./libcrc.so", flags=ffi.RTLD_GLOBAL)
p = ffi.new("char[]", b"libcrc.so")
u = ffi.new("char[]", b"-ucli")
a = ffi.new("char[]", b"-do")
b = ffi.new("char[]", b"run.do")
c.vcs_main(4, ffi.new("char*[]", [p,u, a,b]))
c.VcsInit()

use_cocotb_test = True

vcs = ffi.dlopen("./venv/lib/python3.10/site-packages/cocotb/libs/libcocotbvpi_vcs.so")
if use_cocotb_test:
    os.environ["COCOTB_TEST_MODULES"] = "test"
    vcs.vlog_startup_routines_bootstrap()
    import pygpi.entry
    pygpi.entry.load_entry([])
    c.VcsSimUntil(ffi.new("unsigned long*", 10000000000))
else:
    vcs.cocotbvpi_entry_point()
    gpi = ffi.dlopen("venv/lib/python3.10/site-packages/cocotb/libs/libcocotb.so")
    root = gpi.gpi_get_root_handle(b"Crc32")
    reset = gpi.gpi_get_handle_by_name(root, b"reset", 0)
    gpi.gpi_set_signal_value_int(reset, 1, 0)
    c.VcsSimUntil(ffi.new("unsigned long*", 1000000))
    c.vpi_control(67, 0)

assert False, "Should not reach here"