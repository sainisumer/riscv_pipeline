module alu_ctrl (
    input logic [2:0]funct3,
    input logic [6:0]funct7,
    output logic [3:0]alctrl,
    input logic [1:0]aluop
);
   
    always@(funct3,funct7,aluop)//done alctrl 2,6,0,1,3,4,5,7,8,9
    begin
        case (aluop)
            4'h0: alctrl <= 2;//add
            4'h1: alctrl <= 6;//subtract
            4'h2: begin
                case(funct3)
                3'h0:if(funct7 == 'h20)
                    alctrl <=6;//sub
                    else
                    alctrl <=2;//add
                3'h6: alctrl <=1;//bitwise or
                3'h7: alctrl <=0;//bitwise and
                3'h4: alctrl <= 3;//xor
                3'h1: alctrl <= 4;//sll
                3'h5: if(funct7 == 'h20) 
                         alctrl <= 7;//sra
                      else
                         alctrl <= 5;//srl
                3'h3: alctrl <= 8;//slt
                3'h2: alctrl <= 9;//sltu
                default: alctrl <= 0;
                endcase
                
            end
            
            
            default: alctrl <= 0;
        endcase
    end
endmodule