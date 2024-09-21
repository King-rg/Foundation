module fifo #(
    parameter DEPTH = 16,           // Depth of the FIFO
    parameter WIDTH = 8             // Width of the data bus
)(
    input wire                 clk,        // Clock signal
    input wire                 reset,      // Asynchronous reset signal (active high)
    
    // Write interface
    input wire                 wr_en,      // Write enable
    input wire [WIDTH-1:0]     data_in,    // Data input
    output wire                full,       // FIFO full indicator

    // Read interface
    input wire                 rd_en,      // Read enable
    output reg [WIDTH-1:0]     data_out,   // Data output
    output wire                empty       // FIFO empty indicator
);

    // Internal memory storage
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // Pointers and counter
    reg [$clog2(DEPTH)-1:0] wr_ptr;        // Write pointer
    reg [$clog2(DEPTH)-1:0] rd_ptr;        // Read pointer
    reg [$clog2(DEPTH+1)-1:0] fifo_cnt;    // FIFO count

    // Write and read condition flags
    wire write = wr_en && !full;
    wire read  = rd_en && !empty;

    // FIFO status indicators
    assign full  = (fifo_cnt == DEPTH);
    assign empty = (fifo_cnt == 0);

    // Main FIFO operation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all internal registers
            wr_ptr   <= 0;
            rd_ptr   <= 0;
            fifo_cnt <= 0;
            data_out <= 0;
        end else begin
            // Write operation
            if (write) begin
                mem[wr_ptr] <= data_in;
                wr_ptr      <= (wr_ptr == DEPTH - 1) ? 0 : wr_ptr + 1;
            end

            // Read operation
            if (read) begin
                data_out <= mem[rd_ptr];
                rd_ptr   <= (rd_ptr == DEPTH - 1) ? 0 : rd_ptr + 1;
            end

            // Update FIFO count
            case ({write, read})
                2'b10: fifo_cnt <= fifo_cnt + 1;  // Write only
                2'b01: fifo_cnt <= fifo_cnt - 1;  // Read only
                default: fifo_cnt <= fifo_cnt;    // No change
            endcase
        end
    end

endmodule
