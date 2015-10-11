module ConditionCode(
	input clk,
	input reset,
	input ldCC,
	input [15:0] bus,
	output [2:0] CC
);
	wire [2:0] cc_in;
	Register #(3) ccReg(clk, reset, ldCC, cc_in, CC);
	
	assign cc_in = bus[15] == 1 ? 3'b100 :
						bus ? 3'b001 : 3'b010;
endmodule
