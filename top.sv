module top(input logic clk,rst);
reg [31:0] current_pc;
wire [31:0] pc,instr,src2;
wire [4:0] addr1,addr2,waddr;
wire [31:0] rd_data,rd_data1,rd_data2,rwaddr,mwdata,regwdata,result,pc_incr;
wire [0:0] memread,memwrite,memtoreg,regwrite,branch;
wire [3:0] alctrl;
wire [1:0] aluop;
wire [2:0] funct3;
wire [6:0] funct7,opcode;
logic [11:0] imm_val,reg_imm_val,regreg_imm_val;
wire alusrc,pcsrc;
// pipelining instr decode/execute stage //alu ctrl input // main ctrl output // alu  2nd stage
logic regmemread,regmemwrite,regmemtoreg,regregwrite,regbranch,wbmemtoreg;
logic [1:0]regaluop;
logic regalusrc;//main ctrl
logic [2:0] regfunct3;
logic [6:0] regfunct7;
logic [4:0] regwaddr;
logic [31:0] regrd_data1,regrd_data2,regregrd_data2;
// pipelining alu out  3rd  stage
logic regzero,regregbranch,regregregwrite,regregmemread,regregmemwrite,regregmemtoreg;
logic [4:0]regregwaddr;
logic [31:0] regresult,wb_reg_result;
//pipelining instr and pc
logic [31:0] ifid_pc;
logic [31:0] ifid_instr;
// pipelining datamem out  4th  stage;
logic wbregwrite;
logic [31:0] wbrd_data;
logic [4:0]wbwaddr;
logic wb_memread;
logic wbregwrite_delayed;
logic wbregwrite_final;
regfile regfilei(.regwrite(wbregwrite_final),.clk(clk),.rst(rst),.addr1(addr1),.addr2(addr2),.rd_data1(rd_data1),.rd_data2(rd_data2),.waddr(wbwaddr),.regwdata(regwdata));
//adder addi(.prev_pc(current_pc),.value('h4),.pc(pc));
adder addi(.prev_pc(current_pc),.value(pc_incr),.pc(pc));
instr_mem imemi(.pc(current_pc),.instr(instr));
data_mem dmemi(.memread(regregmemread),.memwrite(regregmemwrite),.clk(clk),.rst(rst),.rwaddr(rwaddr),.rd_data(rd_data),.mwdata(mwdata));
alu alui(.alctrl(alctrl),.clk(clk),.src1(regrd_data1),.src2(src2),.zero(zero),.result(result));
main_ctrl main_ctrli(.memwrite(memwrite),.memread(memread),.memtoreg(memtoreg),.regwrite(regwrite),.branch(branch),.opcode(opcode),.aluop(aluop),.alusrc(alusrc));
alu_ctrl alu_ctrli(.alctrl(alctrl),.funct3(regfunct3),.funct7(regfunct7),.aluop(regaluop));


assign wbregwrite_final = wb_memread ? wbregwrite_delayed : wbregwrite;

assign funct3 = ifid_instr[14:12];
assign funct7 = ifid_instr[31:25];
assign addr1  = ifid_instr[19:15]; // registered through fetch register
assign addr2  = ifid_instr[24:20]; // registered through fetch register
assign opcode = ifid_instr[6:0]; // registered through fetch register
assign regwdata = (wbmemtoreg)?wbrd_data:wb_reg_result; 
assign imm_val = ifid_instr[31:20];
//assign rwaddr = (regregmemread||regregmemwrite)?regresult:0;
assign rwaddr = regresult;
assign mwdata =  (regregmemwrite)?regregrd_data2:0;
assign waddr  = ifid_instr[11:7];
assign pcsrc = ~regzero&regregbranch;
assign pc_incr = pcsrc?regreg_imm_val:'h4;
//assign src2 = alusrc?imm_val:rd_data2;
assign src2 = regalusrc?(regfunct3=='h1||regfunct3=='h5)?reg_imm_val[4:0]:reg_imm_val:regrd_data2;
always@(posedge clk)
begin
    if(!rst)
    current_pc <= 0;
    else
    current_pc <= pc;
end


always_ff @(posedge clk) begin
  if (!rst) begin
    ifid_pc    <= 32'b0;
    ifid_instr <= 32'b0;
  end else begin
    ifid_pc    <= current_pc;
    ifid_instr <= instr;
  end
end


always@(posedge clk)
begin
if(!rst)
begin
    regaluop <=0;
    regmemread<=0;
    regmemwrite<=0;
    regmemtoreg<=0;
    regalusrc<=0;
    regregwrite<=0;
    regbranch<=0;
    regfunct3<=0;
    regfunct7<=0;
    regrd_data1<=0;
    regrd_data2<=0;
    regwaddr<=0;
    reg_imm_val<=0;
end
else begin
    regaluop <=aluop;
    regmemread<=memread;
    regmemwrite<=memwrite;
    regmemtoreg<=memtoreg;
    regalusrc<=alusrc;
    regregwrite<=regwrite;
    regbranch<=branch;
    regfunct3<=funct3;
    regfunct7<=funct7;
    regrd_data1<=rd_data1;
    regrd_data2<=rd_data2;
    regwaddr<=waddr;
    reg_imm_val<=imm_val;

end
end

always@(posedge clk)
begin
if(!rst)
begin
    regzero <=0;
    regresult<=0;
    regregbranch<=0;
    regregregwrite<=0;
    regregmemread<=0;
    regregmemwrite<=0;
    regregmemtoreg<=0;
    regregwaddr<=0;
    regregrd_data2<=0;
    regreg_imm_val<=0;
    
end
else begin
    regzero <=zero;
    regresult<=result;
    regregbranch<=regbranch;
    regregregwrite<=regregwrite;
    regregmemread<=regmemread;
    regregmemwrite<=regmemwrite;
    regregmemtoreg<=regmemtoreg;
    regregwaddr<=regwaddr;
    regregrd_data2<=regrd_data2;
    regreg_imm_val<=reg_imm_val;
    

end
end


//logic [31:0] regresult;

always@(posedge clk)
begin
if(!rst)
begin
    wbregwrite <=0;
    wb_reg_result<=0;
    wbmemtoreg<=0;
    wbrd_data<=0;
    wbwaddr<=0;
    
    
end
else begin
    wbregwrite <=regregregwrite;
    wbmemtoreg<=regregmemtoreg;
    wbrd_data<=rd_data;
    wbwaddr<=regregwaddr;
    wb_reg_result<=regresult;
    
    

end
end
// logic for lw to allign read data from dmem with regwrite by delaying regwrite using delayed memread

always@(posedge clk) begin
  if (!rst)
    wb_memread <= 1'b0;
  else
    wb_memread <= regregmemread; // EX/MEM → MEM/WB
end


always @(posedge clk) begin
  if (!rst)
    wbregwrite_delayed <= 1'b0;
  else
    wbregwrite_delayed <= wbregwrite;
end


endmodule
