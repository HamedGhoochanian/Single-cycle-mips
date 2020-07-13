module RegFile (clk, readreg1, readreg2, writereg, writedata, RegWrite, readdata1, readdata2, sig_regRead, sig_regDist);
  input [4:0] readreg1, readreg2, writereg;
  input [31:0] writedata;
  input clk, RegWrite, sig_regRead, sig_regDist;
  output reg  [31:0] readdata1, readdata2;
  reg [31:0] regfile [31:0];
  integer i;
  initial
    begin
      for (i=0;i<32;i=i+1)
        regfile[i] = 32'd0;
    end

 	always @(posedge clk, RegWrite, readreg1, readreg2) begin
		// Write
    regfile[0]=0;
		if(RegWrite == 1) 
      begin
      if(sig_regDist == 1)
      begin
				regfile[writereg] <= writedata;
			end
			else 
      begin
				regfile[readreg2] <= writedata;
			end
      end
			// write to file
			$writememb("registers.mem",regfile);
		// Read
    if (sig_regRead == 1)
    begin
			readdata1 = regfile[readreg1];
			readdata2 = regfile[readreg2];
    end
	end

  initial begin 
    $dumpfile("register.vcd");
    $dumpvars(0,RegFile,regfile[0],regfile[1],regfile[2],regfile[3],regfile[4],regfile[5],regfile[6],regfile[7],regfile[8],regfile[9],regfile[10],regfile[11],regfile[12],regfile[13],regfile[14],regfile[15],regfile[16],regfile[17],regfile[18],regfile[19],regfile[20],regfile[21],regfile[22],regfile[23],regfile[24],regfile[25],regfile[26],regfile[27],regfile[28],regfile[29],regfile[30],regfile[31]);
  end
endmodule




