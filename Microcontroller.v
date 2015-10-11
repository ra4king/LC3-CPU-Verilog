module Microcontroller(
	input clk,
	input reset,
	input [15:0] IR,
	input [2:0] CC,
	output [1:0] ALUK,
	output [1:0] sel_PCMUX,
	output [1:0] sel_ADDR2MUX,
	output sel_ADDR1MUX,
	output sel_MARMUX,
	output ldPC,
	output ldIR,
	output ldCC,
	output ldREG,
	output ldMAR,
	output ldMDR,
	output drPC,
	output drALU,
	output drMARMUX,
	output drMDR,
	output MEM_W,
	output MEM_EN,
	output [5:0] state,
	output [27:0] signals_out
);

	reg [5:0] nextState = 0;
	wire [5:0] currState;
	Register #(6) stateReg(clk, reset, 1'b1, nextState, currState);
	
	assign state = currState;
	
	reg [27:0] signals;
	assign signals_out = signals;
	
	wire [5:0] nextSignalState;
	wire opTest, chkCC;

	reg [5:0] nextOPState;
	wire [5:0] nextCCState;
	assign nextCCState = (IR[11] & CC[2]) || (IR[10] & CC[1]) || (IR[9] & CC[0]) ? 6'b000101 : 6'b000000;
	
	always @(signals) begin
		case({opTest, chkCC})
			2'b00: nextState <= nextSignalState;
			2'b01: nextState <= nextCCState;
			2'b10: nextState <= nextOPState;
			2'b11: nextState <= 0;
		endcase
	end
	
	always @(IR) begin
		case(IR[15:12])
			4'b0000: nextOPState <= 6'b000100; // BR
			4'b0001: nextOPState <= 6'b000110; // ADD
			4'b0101: nextOPState <= 6'b000111; // AND
			4'b1001: nextOPState <= 6'b001000; // NOT
			4'b1101: nextOPState <= 6'b001001; // RSHIFT
			4'b0010: nextOPState <= 6'b001010; // LD
			4'b1010: nextOPState <= 6'b001101; // LDI
			4'b0110: nextOPState <= 6'b010010; // LDR
			4'b0011: nextOPState <= 6'b010101; // ST
			4'b1011: nextOPState <= 6'b011000; // STI
			4'b0111: nextOPState <= 6'b011101; // STR
			4'b1110: nextOPState <= 6'b100000; // LEA
			4'b1100: nextOPState <= 6'b100001; // JMP
			4'b0100: nextOPState <= IR[11] ? 6'b100010 : 6'b100011; // JSR
			4'b1111: nextOPState <= 6'b100100; // TRAP goes to HALT for now
			default: nextOPState <= 6'b000000;
		endcase
	end
	
	assign nextSignalState = signals[27:22];
	assign opTest = signals[21];
	assign chkCC = signals[20];
	assign ALUK = signals[19:18];
	assign sel_PCMUX = signals[17:16];
	assign sel_ADDR2MUX = signals[15:14];
	assign sel_ADDR1MUX = signals[13];
	assign sel_MARMUX = signals[12];
	assign ldPC = signals[11];
	assign ldIR = signals[10];
	assign ldCC = signals[9];
	assign ldREG = signals[8];
	assign ldMAR = signals[7];
	assign ldMDR = signals[6];
	assign drPC = signals[5];
	assign drALU = signals[4];
	assign drMARMUX = signals[3];
	assign drMDR = signals[2];
	assign MEM_W = signals[1];
	assign MEM_EN = signals[0];
	
	always @(currState) begin
		case(currState)
			6'b000000: signals <= 28'b0000010000100000100010100000; // do not branch
			6'b000001: signals <= 28'b0000100000000000000001000001;
			6'b000010: signals <= 28'b0000110000000000010000000100;
			6'b000011: signals <= 28'b0000001000000000000000000000;
			6'b000100: signals <= 28'b0000000100000000000000000000; // BR, chkCC
			6'b000101: signals <= 28'b0000000000010110100000000000; // do branch
			6'b000110: signals <= 28'b0000000000000000001100010000; // ADD
			6'b000111: signals <= 28'b0000000001000000001100010000; // AND
			6'b001000: signals <= 28'b0000000010000000001100010000; // NOT
			6'b001001: signals <= 28'b0000000011000000001100010000; // RSHIFT
			6'b001010: signals <= 28'b0010110000000111000010001000; // LD
			6'b001011: signals <= 28'b0011000000000000000001000001;
			6'b001100: signals <= 28'b0000000000000000001100000100;
			6'b001101: signals <= 28'b0011100000000111000010001000; // LDI
			6'b001110: signals <= 28'b0011110000000000000001000001;
			6'b001111: signals <= 28'b0100000000000000000010000100;
			6'b010000: signals <= 28'b0100010000000000000001000001;
			6'b010001: signals <= 28'b0000000000000000001100000100;
			6'b010010: signals <= 28'b0100110000001001000010001000; // LDR
			6'b010011: signals <= 28'b0101000000000000000001000001;
			6'b010100: signals <= 28'b0000000000000000001100000100;
			6'b010101: signals <= 28'b0101100000000111000010001000; // ST
			6'b010110: signals <= 28'b0101110000111101000001001000;
			6'b010111: signals <= 28'b0000000000000000000000000011;
			6'b011000: signals <= 28'b0110010000000111000010001000; // STI
			6'b011001: signals <= 28'b0110100000000000000001000001;
			6'b011010: signals <= 28'b0110110000000000000010000100;
			6'b011011: signals <= 28'b0111000000111101000001001000;
			6'b011100: signals <= 28'b0000000000000000000000000011;
			6'b011101: signals <= 28'b0111100000001001000010001000; // STR
			6'b011110: signals <= 28'b0111110000111101000001001000;
			6'b011111: signals <= 28'b0000000000000000000000000011;
			6'b100000: signals <= 28'b0000000000000111001100001000; // LEA
			6'b100001: signals <= 28'b0000000000011100100000000000; // JMP
			6'b100010: signals <= 28'b0000000000010010100100100000; // JSR if IR[11] == 1
			6'b100011: signals <= 28'b0000000000011100100100100000; // JSR if IR[11] == 0
			6'b100100: signals <= 28'b1001000000000000000000000000; // HALT
			default: signals <= 28'b0000000000000000000000000000;
		endcase
	end
endmodule
