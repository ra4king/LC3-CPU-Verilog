module RegFile(clk, reset, DR, data, we, sel_SR1, sel_SR2, SR1, SR2);
	parameter SEL_BITS, BIT_SIZE;
	parameter TOTAL_REGS = 1 << SEL_BITS;
	
	input clk;
	input reset;
	input [SEL_BITS-1:0] DR;
	input [BIT_SIZE-1:0] data;
	input we;
	input [SEL_BITS-1:0] sel_SR1, sel_SR2;
	output [BIT_SIZE-1:0] SR1, SR2;

	wire [BIT_SIZE-1:0] SR_out[TOTAL_REGS - 1:0];
	
	assign SR1 = SR_out[sel_SR1];
	assign SR2 = SR_out[sel_SR2];
	
	generate
		genvar i;
		for(i = 0; i < TOTAL_REGS; i = i + 1) begin : create_regs
			Register #(BIT_SIZE) r(clk, reset, we && DR == i, data, SR_out[i]);
		end
	endgenerate
endmodule
