module carry_lookahead_adder #(parameter N = 4) (
    input  logic [N-1:0] A,
    input  logic [N-1:0] B,
    input  logic         Cin,
    output logic [N-1:0] Sum,
    output logic         Cout
);

    logic [N-1:0] G; // Generate bits
    logic [N-1:0] P; // Propagate bits
    logic [N:0]   C; // Carry bits

    // Generate and Propagate assignments
    assign G = A & B;
    assign P = A | B;

    // Initial carry
    assign C[0] = Cin;

    // Generate carry signals
    genvar i;
    generate
        for (i = 0; i < N; i++) begin : carry_generation
            assign C[i+1] = G[i] | (P[i] & C[i]);
        end
    endgenerate

    // Sum calculation
    assign Sum = A ^ B ^ C[N-1:0];

    // Final carry-out
    assign Cout = C[N];

endmodule
