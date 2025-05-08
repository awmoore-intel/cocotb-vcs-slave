print("HERE")

import cocotb
import cocotb.simulator
from cocotb.triggers import Timer

#import simics
#import conf

#print(conf.sim)

@cocotb.test
async def test_hello_world(dut):
    """Test that the simulator is working."""
    #dut.reset.value = 0
    await Timer(500, unit="ps")
    dut.reset.value = 1
    await Timer(500, unit="ps")
    dut.reset.value = 0

    return True

#@cocotb.test
async def test_hello_world1(dut):
    """Test that the simulator is working."""
    #dut.reset.value = 0
    await Timer(500, unit="ps")
    dut.reset.value = 1
    await Timer(500, unit="ps")
    return True