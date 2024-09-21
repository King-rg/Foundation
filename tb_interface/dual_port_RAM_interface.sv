module dual_port_RAM_interface;

    // Parameters
    parameter DATA_W = 8;
    parameter DEPTH  = 8;
    parameter ADDR_W = $clog2(DEPTH);

    // Clock signal
    logic clk;

    // Write Port
    logic                  i_wren;
    logic [ADDR_W - 1 : 0] i_waddr;
    logic [DATA_W - 1 : 0] i_wdata;

    // Read Port
    logic [ADDR_W - 1 : 0] i_raddr;
    logic [DATA_W - 1 : 0] o_rdata;

    // Instantiate the dual_port_RAM module
    dual_port_RAM #(
        .DATA_W(DATA_W),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .i_wren(i_wren),
        .i_waddr(i_waddr),
        .i_wdata(i_wdata),
        .i_raddr(i_raddr),
        .o_rdata(o_rdata)
    );

endmodule
