// full_adder.sv - Full Adder IP in SystemVerilog

module full_adder (
    input  logic a,     // First input bit
    input  logic b,     // Second input bit
    input  logic cin,   // Carry-in bit
    output logic sum,   // Sum output bit
    output logic cout   // Carry-out bit
);

    // Full adder combinational logic
    always_comb begin
        sum  = a ^ b ^ cin;      // XOR for sum
        cout = (a & b) | (cin & (a ^ b));  // Carry-out logic
    end

endmodule
