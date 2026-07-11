module regfile (
    input logic regwrite,
    input logic clk,
    input logic rst,
    input logic[4:0] addr1,
    input logic[4:0] addr2,
    output logic[31:0] rd_data1,
    output logic[31:0] rd_data2,
    input logic[31:0] regwdata,
    input logic[4:0] waddr
);
    reg [31:0] mem[31:0];
    always@(posedge clk)
    begin
        if(regwrite&rst)
        mem[waddr] <= regwdata;
    end
    initial
    begin
        for(int i =0;i<32;i++)
        mem[i] = i+1;
    end
   // $readmemh("regdata.hex",mem);
    assign rd_data1 = mem[addr1];
    assign rd_data2 = mem[addr2];
endmodule