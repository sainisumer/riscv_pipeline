`include "top.sv"
`include "adder.sv"
`include "instr_mem.sv"
`include "data_mem.sv"
`include "regfile.sv"
//`include "sign_extend.sv"
`include "alu.sv"
`include "main_ctrl.sv"
`include "alu_ctrl.sv"

module tb;
reg clk;
reg rst_n;

 
top proc(
    .rst (rst_n),
    .clk (clk)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;



initial begin
   
    #(CLK_PERIOD*3) rst_n<=0;clk<=0;
    repeat(5) @(posedge clk);
    rst_n<=1;
    
    #200ns $finish;
end


    
endmodule