module main_ctrl (
    output logic memwrite,
    output logic memtoreg,
    output logic memread,
    output logic branch,
    output logic regwrite,
    output logic alusrc,
    input logic[6:0] opcode,
    output logic [1:0]aluop
);
   
    always@(*)
    begin
        case (opcode)
            7'h33: begin//r type
                     aluop <= 2'h2;
                     regwrite <=1;
                     memread <=0;
                     memtoreg <=0;
                     memwrite <=0;
                     branch <=0;
                     alusrc <=0;
                   end
            7'h13: begin//i type
                     aluop <= 2'h2;
                     regwrite <=1;
                     memread <=0;
                     memtoreg <=0;
                     memwrite <=0;
                     branch <=0;
                     alusrc <=1;
                   end
            7'h23: begin
                     aluop <= 2'h0;//store
                     regwrite <=0;
                     memread <=0;
                     memtoreg <=0;
                     memwrite <=1;
                     alusrc <=1;
                     branch <=0;
                   end
            7'h3: begin
                     aluop <= 2'h0;// load
                     regwrite <=1;
                     memread <=1;
                     memtoreg <=1;
                     memwrite <=0;
                     alusrc <=1;
                     branch <=0;
                    
                   end       
            7'h63: begin
                    aluop <= 2'h1;//branch
                    regwrite <=0;
                    memread <=0;
                    memtoreg <=0;
                    memwrite <=0;
                    alusrc <=0;
                    branch <=1;
            end
            default: begin 
            
            aluop <= 0;
            regwrite <=0;
                    memread <=0;
                    memtoreg <=0;
                    memwrite <=0;
                    alusrc <=0;
                    branch <=0;
            end
        endcase
    end
endmodule