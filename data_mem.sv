module data_mem (
    input logic memwrite,
    input logic memread,
    input logic clk,
    input logic rst,
    input logic[31:0] rwaddr,
    output logic[31:0] rd_data,
    input logic[31:0] mwdata
);
    reg [31:0] mem[31:0];
    initial begin
        for (int i =0 ;i<32 ;i++ ) begin
            mem[i] <= i;
            
        end
    end
    always@(posedge clk)
    begin
        if(!rst)
        rd_data<=0;
        else if(memwrite)
        mem[rwaddr] <= mwdata;
        else if(memread)
        rd_data <= mem[rwaddr];
        else
        rd_data <=0;
    end
endmodule