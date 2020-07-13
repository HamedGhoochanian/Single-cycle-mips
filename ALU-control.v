//* takes instruction code and func and return a ALU code

module ALUcontrol(opCode, funct, ALU_control);
    input [5:0] opCode;
    input [5:0] funct;
    output reg [2:0] ALU_control;
    wire [7:0] concated;
    assign concated = {opCode, funct};
    always @(concated)
    casex (concated)  
        12'b000000100000: ALU_control=3'b010;  //add
        12'b000000100010: ALU_control=3'b110;  //sub
        12'b000000100100: ALU_control=3'b000;  //and
        12'b000000100101: ALU_control=3'b001;  //or
        12'b000000101010: ALU_control=3'b111;  //slt
        12'b001000xxxxxx: ALU_control=3'b010;  //addi
        12'b001000xxxxxx: ALU_control=3'b010;  //addi
        12'b001101xxxxxx: ALU_control=3'b001;  //ori
        12'b001010xxxxxx: ALU_control=3'b111;  //slti
        12'b001100xxxxxx: ALU_control=3'b000;  //andi
        12'b000100xxxxxx: ALU_control=3'b101;  //beq
        12'b000101xxxxxx: ALU_control=3'b011;  //bne 
        default: ALU_control=3'b000;  
    endcase
endmodule