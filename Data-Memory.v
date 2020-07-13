//memory unit
module DataMemory(input memread, 
                input memwrite, 
                input [31:0] address, 
                input [31:0] writedata, 
                output reg [31:0] readdata);
 
  reg [31:0] mem_array [63:0];
  
  integer i;
  initial 
  begin
    for (i=0; i<64; i=i+1)   
      mem_array[i]=32'd0;
  end
 
  always@(memread, memwrite, address, mem_array[address], writedata)
  begin
    $monitor ("addres = %d\n",address);
    if(memwrite)
    begin
      mem_array[address]= writedata;
    end

    if(memread)begin
      readdata=mem_array[address];
    end
  end
endmodule