module ALU(
	input [1:0] aluk,
	input [15:0] A, B,
	output [15:0] out
);

	wire [15:0] ADD = A + B;
	wire [15:0] AND = A & B;
	wire [15:0] NOT = ~A;
	wire [15:0] RSHIFT = {A[15], A[15:1]};
	
	assign out = aluk == 2'b00 ? ADD :
					 aluk == 2'b01 ? AND :
					 aluk == 2'b10 ? NOT :
					 RSHIFT;
endmodule
