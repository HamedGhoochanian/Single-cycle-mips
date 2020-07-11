//ALU
module ALU(input [31:0] data1, data2, input [3:0] aluoperation, output reg [31:0] result, output reg zero, lt, gt);
    always @(aluoperation, data1, data2)
        begin
            case (aluoperation)
                4'b0000: result = data1+data2; // ADD
                4'b0001: result = data1-data2; // SUB
                4'b0010: result = data1 & data2; // AND
                4'b0011: result = data1 | data2; // OR
                4'b0100: result = data1 ^ data2; // XOR
                default: result = data1+data2; // ADD
            endcase

            if (data1 > data2)
                begin
                    gt = 1'b1;
                    lt = 1'b0;
                end
            else if (data1 < data2)
                begin
                    gt = 1'b0;
                    lt = 1'b1;
                end

            if (result == 32'd0)
                zero = 1'b1;
            else
                zero = 1'b0;

        end
endmodule

//register file
module RegisterFile(clk, readAddress1, readAddress2, writeAddress, writeData, RegWrite, readData1, readData2);
    input [4:0] readAddress1, readAddress2, writeAddress;
    input [31:0] writeData;
    input clk, RegWrite;
    output [31:0] readData1, readData2;

    reg [31:0] regFile [31:0];

    always @(posedge clk)
        begin
            if (RegWrite)
                begin
                    regFile[writeAddress] = writeData;
                    assign readData2 = writeData;
                    assign readData1 = regFile[readAddress1];
                end
            else
                begin
                    readData1 = regFile[readAddress1];
                    readData2 = regFile[readAddress2];
                end
        end
endmodule

//instruction memory
module instructionMemory(input [7:0] address, output reg [31:0] readData);

    reg [31:0] mem_array [255:0];
    integer i;
    initial
        begin
            for (i = 0; i < 256; i = i+1)
                mem_array[i] = i*10;
        end

    always @(memread, address, mem_array[address])
        begin
            readData = mem_array[address];
        end
endmodule

//data memory
module dataMemory(input memread, input memwrite, input [7:0] address, input [31:0] writeData, output reg [31:0] readdata);

    reg [31:0] mem_array [127:0];

    integer i;
    initial
        begin
            for (i = 0; i < 128; i = i+1)
                mem_array[i] = i*10;
        end

    always @(memread, memwrite, address, mem_array[address], writeData)
        begin
            if (memread)
                begin
                readdata = mem_array[address];
                end

            if (memwrite)
                begin
                    mem_array[address] = writeData;
                end
        end
endmodule

module ControlUnit(input [5:0] inst,output RegDst,Jump,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSRC,RegWrite)
    
endmodule