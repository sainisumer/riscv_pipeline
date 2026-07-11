module adder (
    input logic [31:0] prev_pc,
    input logic [31:0] value,
    output logic [31:0] pc
);
  assign pc = prev_pc + value;  
endmodule