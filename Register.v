module Register(clk, reset, we, in, out);
	parameter BIT_SIZE;
	
	input clk;
	input reset;
	input we;
	input [BIT_SIZE-1:0] in;
	output reg [BIT_SIZE-1:0] out;
	
	always @(posedge clk) begin
		if(reset)
			out <= 0;
		else if(we)
			out <= in;
	end
endmodule
