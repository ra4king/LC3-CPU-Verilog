module LC3_CPU(
	input CLOCK_50,
	input [9:0] SW,
	input [3:0] KEY,
	output [6:0] HEX0, HEX1, HEX2, HEX3, 
	output [9:0] LEDR,
	output [7:0] LEDG,
	output [15:0] PC_out,
	output [15:0] IR_out,
	output [1:0] sel_PCMUX_out,
	output [15:0] ADDER_out,
	output [2:0] CC_out,
	output [15:0] MAR_out,
	output [15:0] MEMORY_out,
	output [15:0] MDR_out,
	output MEM_EN_out, MEM_W_out,
	output [15:0] BUS_out,
	output [5:0] STATE_out,
	output [27:0] SIGNALS_out
);

	wire CLOCK;
	// Use the 50 MHz in the simulator.
	assign CLOCK = CLOCK_50;

// 50 MHz is too high a frequency, as it looks like
// long clock cycles are needed. I will have to optimize
// down the road.
// 
// Make the clock 50 times slower to 1 MHz
//	reg CLOCK;
//	reg [7:0] counter = 0;
//	always @(posedge CLOCK_50) begin
//		counter = counter + 1;
//		if(counter == 50) begin
//			CLOCK <= ~CLOCK;
//			counter = 0;
//		end
//	end
	
	wire [15:0] BUS;
	assign BUS_out = BUS;
	
	wire RESET;
	assign RESET = ~KEY[0];
	
	wire ldIR;
	wire [15:0] IR;
	Register #(16) ir(CLOCK, RESET, ldIR, BUS, IR);
	
	assign IR_out = IR;
	
	wire ldPC, drPC;
	wire [15:0] PC_in, PC;
	Register #(16) pc(CLOCK, RESET, ldPC, PC_in, PC);
	
	assign PC_out = PC;
	
	wire ldREG;
	wire [2:0] sel_DR, sel_SR1;
	wire [15:0] SR1, SR2;
	RegFile #(3, 16) REG(CLOCK, RESET, sel_DR, BUS, ldREG, sel_SR1, IR[2:0], SR1, SR2);
	
	wire [1:0] sel_PCMUX;
	
	assign sel_SR1 = sel_PCMUX == 2'b11 ? IR[11:9] : IR[8:6];
	assign sel_DR = IR[15:12] == 4'b0100 ? 3'b111 : IR[11:9];
	
	wire [15:0] ADDER;
	wire [15:0] ADDR1MUX, ADDR2MUX;
	assign ADDER = ADDR1MUX + ADDR2MUX;
	assign ADDER_out = ADDER;
	
	wire sel_ADDR1MUX;
	wire [1:0] sel_ADDR2MUX;
	
	assign ADDR1MUX = sel_ADDR1MUX ? PC : SR1;
	
	wire [15:0] SEXT11, SEXT9, SEXT6;
	SEXT #(.BIT_SIZE_IN(11), .BIT_SIZE_OUT(16)) s11(IR[10:0], SEXT11);
	SEXT #(.BIT_SIZE_IN(9), .BIT_SIZE_OUT(16)) s9(IR[8:0], SEXT9);
	SEXT #(.BIT_SIZE_IN(6), .BIT_SIZE_OUT(16)) s6(IR[5:0], SEXT6);
	
	assign ADDR2MUX = sel_ADDR2MUX == 2'b00 ? SEXT11 :
							sel_ADDR2MUX == 2'b01 ? SEXT9 :
							sel_ADDR2MUX == 2'b10 ? SEXT6 :
							16'b0;
	
	wire sel_MARMUX, drMARMUX;
	wire [15:0] MARMUX;
	assign MARMUX = sel_MARMUX ? ADDER : {8'b0, IR[7:0]};
	
	wire ldMAR;
	wire [15:0] MAR;
	Register #(16) mar(CLOCK, RESET, ldMAR, BUS, MAR);
	
	assign MAR_out = MAR;
	
	wire ldMDR, drMDR;
	wire [15:0] MDR_in, MDR;
	Register #(16) mdr(CLOCK, RESET, ldMDR, MDR_in, MDR);
	
	assign MDR_out = MDR;
	
	wire [15:0] memory_data;
	wire MEM_W, MEM_EN;
	assign MDR_in = MEM_EN ? memory_data : BUS;
	
	assign MEM_EN_out = MEM_EN;
	assign MEM_W_out = MEM_W;
	
	MemoryController #(.ADDRESS_BITS(16), .MEMORY_BITS(16)) mc(.clk(CLOCK), .reset(RESET), .addr(MAR), .data_in(MDR), .data_out(memory_data),
																				 .we(MEM_W), .select(MEM_EN), .SW(SW), .KEY(KEY), .LEDR(LEDR),
																				 .LEDG(LEDG), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3));
	
	assign MEMORY_out = memory_data;
	
	wire [15:0] PC_PLUS_ONE;
	assign PC_PLUS_ONE = PC + 1;
	
	assign PC_in = sel_PCMUX == 2'b00 ? BUS :
						sel_PCMUX == 2'b01 ? ADDER : PC_PLUS_ONE;
						
	assign sel_PCMUX_out = sel_PCMUX;
	
	wire [15:0] SEXT5;
	SEXT #(.BIT_SIZE_IN(5), .BIT_SIZE_OUT(16)) s5(IR[4:0], SEXT5);
	
	wire [15:0] SR2MUX;
	assign SR2MUX = IR[5] ? SEXT5 : SR2;
	
	wire drALU;
	wire [1:0] ALUK;
	wire [15:0] ALU_out;
	ALU alu(ALUK, SR1, SR2MUX, ALU_out);
	
	wire ldCC;
	wire [2:0] CC;
	ConditionCode cc(CLOCK, RESET, ldCC, BUS, CC);
	
	assign CC_out = CC;
	
	assign BUS = drPC ? PC : 16'bZ;
	assign BUS = drMARMUX ? MARMUX : 16'bZ;
	assign BUS = drALU ? ALU_out : 16'bZ;
	assign BUS = drMDR ? MDR : 16'bZ;
	
	Microcontroller control(CLOCK, RESET, IR, CC, ALUK, sel_PCMUX,
									sel_ADDR2MUX, sel_ADDR1MUX, sel_MARMUX,
									ldPC, ldIR, ldCC, ldREG, ldMAR, ldMDR, drPC,
									drALU, drMARMUX, drMDR, MEM_W, MEM_EN, STATE_out, SIGNALS_out);
endmodule
