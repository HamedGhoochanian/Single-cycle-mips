module ALU(input [31:0] data1,data2,input [2:0] aluoperation,output reg [31:0] result,output reg zero,lt,gt,branch);

  always@(aluoperation,data1,data2)
  begin
    case (aluoperation)
      3'b010 : result = data1 + data2;                   // ADD
      3'b110 : result = data1 - data2;                   // SUB
      3'b000 : result = data1 & data2;                   // AND
      3'b001 : result = data1 | data2;                   // OR
      3'b111 : result = (data1 > data2) ? 32'd1 : 32'd0; // SLT
      3'b011 : branch = (data1 != data2) ? 1'b1 : 1'b0;  // BNE
      3'b101 : branch = (data1 == data2) ? 1'b1 : 1'b0;  // BEQ
    endcase
    

    gt = (data1>data2) ? 1'b1 : 1'b0;
    lt = (data1>data2) ? 1'b0 : 1'b1; 
    zero = (result==32'd0) ? 1'b1 : 1'b0;      
  end
  

endmodule

module testbench;
  
  reg [31:0] d1,d2;  /* d1=data1, d2=data2 */
  reg [2:0] aluop;   /* aluop=aluoperation */
  
  wire [31:0] r; /* r=result */
  wire gt,lt,z,branch; /* z=zero */
  
  ALU u0(d1, d2, aluop, r, z, lt, gt, branch);
  
  initial begin
    
    #5
    d1=31'd1;
    d2=31'd2;
    aluop=4'b0000;
    
    #20
    aluop=4'b0011;
  end
  
  initial repeat(1000)#2 d1=d1+1;
  
endmodule
