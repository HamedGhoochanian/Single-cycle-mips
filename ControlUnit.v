module ControlUnit(
	input [5:0] opcode, funct,
    output reg [3:0] ALUOp,
    output reg
		RegWrite, RegDst
		MemRead, MemWrite, MemToReg
		Branch, Jump,
        ALUSrc,
);
	
	always @(opcode, funct) begin
		// Reset every signal
		RegWrite = 1'b1;
		RegDst = 1'b0;
		MemRead = 1'b0;
		MemWrite = 1'b0;
		Branch = 1'b0;
        Jump = 1'b0;
        ALUOp = 1'b0;
        ALUSrc = 1'b0;
        MemToReg = 1'b0;

        if(
            (opcode == 6'b000000 && funct == 6'b100000)
            ||
            (opcode == 6'b001000)
        )
            begin // add, addi
            ALUOp = 4'b0000;
        end
        
        if(
            (opcode == 6'b000000 && funct == 6'b101011)
            || opcode == 6'b000100 || opcode == 6'b000101)
            begin // sub
            ALUOp = 4'b0001;
        end

        if(
            (opcode == 6'b000000 && funct == 6'b100110)
            ||
            (opcode == 6'b001110)
        )
            begin // or, ori
            ALUOp = 4'b0011;
        end

        if(
            (opcode == 6'b000000 && funct == 6'b100100)
            ||
            (opcode == 6'b001100)
        )
            begin // and, andi
            ALUOp = 4'b0010;
        end

        if(
            (opcode == 6'b000000 && funct == 6'b100110)
            ||
            (opcode == 6'b001110)
        )
            begin // xor, xori
            ALUOp = 4'b0100;
        end

        if(
            (opcode == 6'b000000 && funct == 6'b101010)
            ||
            (opcode == 6'b001010)
        )
            begin // slt, slti
            ALUOp = 4'b0101;
        end

        if(opcode == 6'b000000) begin
            if (func == 6'b100000
                || func == 6'b100100
                || func == 6'b100101
                || func == 6'b100111
                || func == 6'b100110
                || func == 6'b101010
                || func == 6'b100010
                || func == 6'b000000
                ) //add, sll, sub, and, or, nor, xor, slt, I copied it from prev homework code :D
                    RegDst = 1'b1;
        end
        if (op == 6'b001000
            or op == 6'b001100
            or op == 6'b001101
            or op == 6'b001100
            or op == 6'b001110
            or op == 6'b001010) //addi, andi, ori, xori, slti
            ALUSrc = 1'b1;
        if(op == 6'b000100 || op == 6'b000101) begin //beq, bne
            Branch = 1'b1;
            RegWrite = 1'b0;
        end
        if(op == 6'b000010) begin //j
            Jump = 1'b1;
            RegWrite = 1'b0;
        end
        if(op == 6'b101011) begin //sw
            MemWrite = 1'b1;
            RegWrite = 1'b0;
        end
        if(op == 6'b100011) begin//lw
            MemRead = 1'b1;
            MemToReg = 1'b1;
        end
    end
endmodule;