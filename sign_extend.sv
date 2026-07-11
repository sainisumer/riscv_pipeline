module sign_extend(
    input  logic [31:0] instr,
    output logic [31:0] extend_value
);

assign extend_value = {{20{instr[31]}}, instr[31:20]};

endmodule
