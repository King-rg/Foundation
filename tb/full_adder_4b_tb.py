import cocotb
from cocotb.triggers import RisingEdge, FallingEdge
from cocotb.clock import Clock

async def get_signal(clk, signal):
    await RisingEdge(clk)
    return signal.value

@cocotb.test()
async def full_adder_4b_tb(dut):
    """Test the 4-bit ripple-carry adder"""
    
    # Start the clock
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Define test cases: tuples of (a, b, cin, expected_sum, expected_cout)
    test_cases = [
        (0b0001, 0b0010, 0, 0b0011, 0),
        (0b1111, 0b0001, 0, 0b0000, 1),
        (0b1010, 0b0101, 0, 0b1111, 0),
        (0b1000, 0b1000, 1, 0b0001, 1),
        (0b0111, 0b0111, 0, 0b1110, 0)
    ]
    
    for a, b, cin, expected_sum, expected_cout in test_cases:
    
        # Apply inputs
        dut.a.value = a
        dut.b.value = b
        dut.cin.value = cin
        
        await RisingEdge(dut.clk);

        # Wait for a rising clock edge to latch inputs
        
        # Check results
        assert dut.sum.value == expected_sum, f"Sum mismatch: expected {expected_sum}, got {dut.sum.value} for inputs a={a}, b={b}, cin={cin}"
        assert dut.cout.value == expected_cout, f"Carry-out mismatch: expected {expected_cout}, got {dut.cout.value} for inputs a={a}, b={b}, cin={cin}"
