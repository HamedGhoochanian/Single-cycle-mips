//memory unit
module InstructionMemory(input [31:0] address, output reg [31:0] instruction);
 
  reg [31:0] mem_array [63:0];
    reg [31:0] inst [56:0];
  
  integer i;
  initial begin
		$readmemb("instruction.mem", mem_array);
    for (i=0; i<64; i=i+1)   
      mem_array[i]=32'd0;
  end
 
  always@(address)
  begin
    if (check == 1'b0)
		  instruction = mem_array[address];
  end
endmodule

