`include "alu.v"
`include "ControlUnit.v"
`include "Data-Memory.v"
`include "regfile.v"
`include "parser.v"
`include "Inst-Memory.v"
`include "ALU-control.v"



module Core(input clk);
	reg[31:0] PC = 32'b0;
    wire instmem_signal = 1'b0;
	wire [31:0] instruction;
	wire [5:0] funct;
	wire [4:0] rs, rt, rd, shamt;
	wire [31:0] address;
	wire [15:0] immediate;
	wire [5:0] opcode;
    wire [2:0] alu_op;
	wire regRead, 
        memToReg, 
        regDst,
	    memRead, 
        memWrite, 
        ALUsrc,
        lt,
        gt, 
        zero,
        jump,
        branch,
        bCond;
	wire [31:0] writeData, data1, data2, readData;

    //* Instruction Memory
    InstructionMemory IM(PC,instruction);

    //* Parse instruction
    instruction_parser parse(opcode,
                            rs,
                            rt,
                            rd,
                            shamt,
                            funct,
                            immediate,
                            instruction);

    //* Control unit
    ControlUnit CU(opcode,
                    funct,
                    regWrite,
                    regDst,
                    memRead,
                    memWrite,
                    memToReg,
                    branch,
                    jump,
                    ALUsrc);

    //* ALU control
    ALUcontrol AC(opcode, 
                funct,
                alu_op);

    //* Arithmatic login unit
    ALU alu(data1, 
            (!ALUsrc) ? data2: {{16{immediate[15]}}, immediate},
            alu_op,
            writeData,
            zero,
            lt,
            gt,
            bCond);

    //* Data memory
    DataMemory DM(memRead,
                memWrite,
                address,
                writeData,
                readData);
    
    //* REGISTER FILE
    RegFile RF(clk,
                rs,
                rt,
                rd,
                writeData,
                regWrite,
                data1,
                data2,
                regRead,
                regDst);
    reg bf,jf;



    
    always @(posedge clk)
    begin
        if(bCond == 1'd1 && branch == 1'b1 && bf == 1'b1) 
        begin
			PC = PC + 1 + $signed(immediate);
            jf=1'b1;
            bf=1'b0;
        end
        else if(opcode == 6'b000010 & jump == 1'b1)begin
			PC = address;
            jf = 1'b0;
            bf = 1'b1;
		end
        else begin
			PC = PC+1;
            jf = 1'b1;
            bf = 1'b1;
		end
    end
    initial begin
        $dumpfile("core.vcd");
        $dumpvars(1,Core);
    end
endmodule

//* mammad
/* wire reg_write_sig, reg_dst_sig,
        mem_read_sig, mem_write_signal, mem_to_reg_sig,
        banch_sig, jump_sig,
        alu_src_sig;
    
    wire [3:0] alu_op;
    
    reg [7:0] PC = 16'd0;
    wire [31:0] instr;

    wire [5:0] opcode, funct;
    wire [4:0] rr1, rr2, wr;
    wire [25:0] addr;
    wire [15:0] immdt;

    wire [31:0] mem_read, data_1, data_2, write_data, alu_out;
    wire [31:0] alu_data;
    wire zero, lt, gt;

    IMemBank instr_mem(1'b1, PC, instr);
    
    // Read data from instr

    assign opcode = instr[31:26];

    always @(instr) begin
        rr1 = instr[25:21];
        rr2 = instr[20:16];
        immdt = instr[15:0];
        addr = instr[25:0];
        if(reg_dst_sig == 1'b0)
            wr = instr[15:11];
        else
            wr = instr[20:16];

        ControlUnit signals(
            opcode, funct,
            alu_op,
            reg_write_sig,
            reg_dst_sig,
            mem_read_sig,
            mem_write_signal,
            mem_to_reg_sig,
            branch_sig,
            jump_sig,
            alu_src_sig
        );

        if(mem_to_reg_sig == 1'b1)
            write_data = mem_read;
        else
            write_data = alu_out;

        RegFile reg_content(clk, rr1, rr2, wr, write_data, reg_write_sig, data_1, data_2)        ;

        if(alu_src_sig == 1'b0)
            alu_data = data_2;
        else
            alu_data = {{16{immdt[15]}}, immdt}; //sign extend the immdt
        
        ALU alu(data_1, alu_data, alu_op, alu_out, zero, lt, gt);

        DMemBank dmb(mem_read_sig, mem_write_signal, alu_out, data_2, mem_read);

    end


    always @(posedge clk) begin
        if((zero == 1'b1 && opcode == 6'b000100) || (zero == 1'b0 && opcode == 6'b000101)):
            PC = PC + 1 + $signed(  );
        else if(jump_sig == 1)
            PC = addr;
        else
            PC = PC + 1;
    end */