module fetch_unit(input clk,rst,input [4:0] pc_srcE,pc_targetE,output [31:0] instrD,output [4:0] pcD);

//instruction memory 
  instruction_memory im(.clk(clk),.reset(rst),.pc(pc),.instruction_code(instr));

// program counter
  pc pc(.clk(clk),..reset(rst),.pc(pc);
  
  

  
