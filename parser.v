module instruction_parser(
	output wire [5:0] opcode,
	output reg [4:0] rs, rt, rd, shiftamount, 
	output reg [5:0] funct,
	output reg[15:0] immediate,
	input [31:0] instruction
);

	assign opcode = instruction[31:26];
	
	always @(instruction) begin
		// R-type
		if(opcode == 6'd0) begin
			shiftamount = instruction[10:6];
			rd = instruction[15:11];
			rt = instruction[20:16];
			rs = instruction[25:21];
			funct = instruction[5:0];
		end
		// J type
		else if(opcode == 6'h2) begin
	//		address = instruction[26:0];
		end
		// I type
		else begin
			rt = instruction[20:16];
			rs = instruction[25:21];
			immediate = instruction[15:0];
		end
        
        

	end
	
endmodule
