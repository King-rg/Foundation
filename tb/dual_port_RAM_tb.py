import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock

class DualPortRAMInterface:
    def __init__(self, dut):
        self.dut = dut
        self.clk = dut.clk
        self.i_wren = dut.i_wren
        self.i_waddr = dut.i_waddr
        self.i_wdata = dut.i_wdata
        self.i_raddr = dut.i_raddr
        self.o_rdata = dut.o_rdata

        self.data_w = len(self.i_wdata)
        self.addr_w = len(self.i_waddr)

    async def write(self, addr, data):
        await RisingEdge(self.clk)
        self.i_wren.value = 1
        self.i_waddr.value = addr
        self.i_wdata.value = data
        await RisingEdge(self.clk)
        self.i_wren.value = 0
        self.i_waddr.value = 0
        self.i_wdata.value = 0

    async def read(self, addr):
        self.i_raddr.value = addr
        await RisingEdge(self.clk)
        await RisingEdge(self.clk)
        data = self.o_rdata.value.integer
        return data

@cocotb.test()
async def dual_port_ram_tb(dut):
    """Test the Dual-Port RAM"""

    # Start the clock (100MHz)
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Instantiate the RAM interface
    ram = DualPortRAMInterface(dut)

    # Reset signals
    dut.i_wren.value = 0
    dut.i_waddr.value = 0
    dut.i_wdata.value = 0
    dut.i_raddr.value = 0

    # Wait for a few clock cycles
    for _ in range(2):
        await RisingEdge(dut.clk)

    # Test parameters
    depth = 2 ** ram.addr_w
    data_w = ram.data_w

    # Initialize the RAM with known data
    for addr in range(depth):
        data = (addr * 3) % (2 ** data_w)
        await ram.write(addr, data)

    # Read back the data and verify
    for addr in range(depth):
        expected_data = (addr * 3) % (2 ** data_w)
        data = await ram.read(addr)
        assert data == expected_data, f"Data mismatch at address {addr}: expected {expected_data}, got {data}"

    # Additional random tests
    import random
    random.seed(0)

    for _ in range(10):
        addr = random.randint(0, depth - 1)
        data = random.randint(0, (2 ** data_w) - 1)
        await ram.write(addr, data)
        read_data = await ram.read(addr)
        assert read_data == data, f"Random test failed at address {addr}: expected {data}, got {read_data}"
