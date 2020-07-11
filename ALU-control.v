module ALUcontrol(ALU_control, ALUop, func);
    input [1:0] ALUop;
    input [3:0] ALU_control;
    output reg [2:0] ALU_control;
    wire [5:0] concated;
    assign concated = {ALUop, func};
    always @(concated)
    casex (concated)  
        6'b11xxxx: ALU_control=3'b000;  
        6'b10xxxx: ALU_control=3'b100;  
        6'b01xxxx: ALU_control=3'b001;  
        6'b000000: ALU_control=3'b000;  
        6'b000001: ALU_control=3'b001;  
        6'b000010: ALU_control=3'b010;  
        6'b000011: ALU_control=3'b011;  
        6'b000100: ALU_control=3'b100;  
        default: ALU_control=3'b000;  
    endcase
endmodule