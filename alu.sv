module alu (
    
    input logic [3:0]alctrl,
    input logic clk,
    input logic[31:0] src1,
    input logic[31:0]src2,
    output logic zero,
    output logic[31:0] result
);
   assign zero = (result == 0);
    always@(*)
    begin
        case (alctrl)
            4'h0: result <= src1 & src2;
            4'h1: result <= src1 | src2;
            4'h2: result <= src1 + src2;
            4'h6: result <= src1 - src2;
            4'h8: result <= src1 < src2?1:0;
            4'h9: result <= src1 < src2?1:0;
            4'h12: result <= ~(src1 | src2);
            4'h6: result <= src1 - src2;
            4'h6: result <= src1 - src2;
            4'h3: result <= src1 ^ src2;
            4'h4: result <= src1 << src2;
            4'h5: result <= src1 >> src2;
            4'h7: result <= src1 >>> src2;
            default: result <= 0;
        endcase
    end
endmodule