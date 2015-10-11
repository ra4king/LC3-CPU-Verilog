module SEXT(in, out);
	parameter BIT_SIZE_IN, BIT_SIZE_OUT;
	
	input [BIT_SIZE_IN-1:0] in;
	output reg [BIT_SIZE_OUT-1:0] out;
	
	integer i;
	always @(in) begin
		out[BIT_SIZE_IN-1:0] <= in;
		
		for(i = BIT_SIZE_IN; i < BIT_SIZE_OUT; i=i+1)
			out[i] <= in[BIT_SIZE_IN-1];
	end
endmodule
