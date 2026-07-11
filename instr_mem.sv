module instr_mem (
    input logic [31:0] pc,
    output logic [31:0] instr
);

  reg [7:0] mem[1024];
  assign instr ={mem[pc+3],mem[pc+2],mem[pc+1],mem[pc]};
  initial
  $readmemh("instrmem.hex",mem);
endmodule