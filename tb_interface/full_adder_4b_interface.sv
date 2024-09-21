module full_adder_4b_interface;

    // Declare inputs to the full adder as reg types
    logic [3:0] a, b;   // 4-bit input A and B
    logic cin;          // Carry-in

    // Declare outputs from the full adder as wire types
    logic [3:0] sum;    // 4-bit sum output
    logic cout;         // Carry-out

    logic c1, c2, c3;   // Intermediate carry signals
    logic clk;          // Clock signal

    // Instantiate the 4 full adders to form a 4-bit adder
    full_adder fa0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c1)
    );

    full_adder fa1 (
        .a(a[1]),
        .b(b[1]),
        .cin(c1),
        .sum(sum[1]),
        .cout(c2)
    );

    full_adder fa2 (
        .a(a[2]),
        .b(b[2]),
        .cin(c2),
        .sum(sum[2]),
        .cout(c3)
    );

    full_adder fa3 (
        .a(a[3]),
        .b(b[3]),
        .cin(c3),
        .sum(sum[3]),
        .cout(cout)
    );


endmodule
