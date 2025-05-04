module fetch_unit(input clk,rst,input [4:0] pc_srcE,pc_targetE,output [31:0] instrD,output [4:0] pcD);
// internal wires
  wire [4:0] pc,pcD,pc_srcE;
  wire pc_targetE;
// pipeline registers for instrD, pcD
  reg [31:0] instrDreg;
  reg [4:0] pcregD;
//instruction memory 
  instruction_memory im(.clk(clk),.reset(rst),.pc(pc),.instruction_code(instr));

// program counter
  pc pc(.clk(clk),..reset(rst),.pc(pc);
// logic to drive instr and pc to registers

        always@(posedge clk)
          begin
            if(!rst)
              begin
                  instrDreg <= 0;
                  pcregD <= 0 ;
              end
            else
                begin
                    instrDreg <= instr;
                    pcregD <= pc;
                end    
          end
  
  

  
