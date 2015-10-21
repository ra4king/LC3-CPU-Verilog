`timescale 1ns/1ps

module LC3_CPU_Test;

	reg clk;
	reg [9:0] switches = 9'b1;
	reg [3:0] key = 4'b1111;
	
	wire [6:0] HEX0, HEX1, HEX2, HEX3;
	wire [9:0] LEDR;
	wire [7:0] LEDG;
	wire [15:0] PC_out;
	wire [15:0] IR_out;
	wire [1:0] sel_PCMUX_out;
	wire [15:0] ADDER_out;
	wire [2:0] CC_out;
	wire [15:0] MAR_out;
	wire [15:0] MEMORY_out;
	wire [15:0] MDR_out;
	wire MEM_EN_out, MEM_W_out;
	wire [15:0] BUS_out;
	wire [5:0] STATE_out;
	wire [27:0] SIGNALS_out;
	
	LC3_CPU cpu(clk, switches, key, HEX0, HEX1, HEX2, HEX3, LEDR, LEDG, PC_out, IR_out, sel_PCMUX_out, ADDER_out, CC_out, MAR_out, MEMORY_out, MDR_out, MEM_EN_out, MEM_W_out, BUS_out, STATE_out, SIGNALS_out);
	
	initial begin
		$stop; // mem load -i ../../RAM.hex -format hex /LC3_CPU_Test/cpu/mc/memory
		
		clk = 0;
		key[0] = 0;
		#10 clk = ~clk;
		#5 key[0] = 1;
		#5 clk = ~clk;
		while(STATE_out != 6'b100100) begin
			#10 clk = ~clk;
		end
		
		$stop;
	end
endmodule
