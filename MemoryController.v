module MemoryController(clk, reset, addr, data_in, data_out, we, select, SW, KEY, LEDR, LEDG, HEX0, HEX1, HEX2, HEX3);
	parameter ADDRESS_BITS, MEMORY_BITS;
	
	input clk;
	input reset;
	input [ADDRESS_BITS-1:0] addr;
	input [MEMORY_BITS-1:0] data_in;
	output reg [MEMORY_BITS-1:0] data_out;
	input we;
	input select;
	input [9:0] SW;
	input [3:0] KEY;
	output reg [9:0] LEDR;
	output reg [7:0] LEDG;
	output reg [6:0] HEX0, HEX1, HEX2, HEX3;
	
	parameter TOTAL_ADDRESSES = 1 << ADDRESS_BITS;
	
	(* ram_init_file = "RAM.mif" *) reg [MEMORY_BITS-1:0] memory[0:TOTAL_ADDRESSES - 1];
	
	always @(posedge select) begin
		if(select) begin
			if(we) begin
				case(addr)
					TOTAL_ADDRESSES-6: LEDR <= data_in[9:0];
					TOTAL_ADDRESSES-5: LEDG <= data_in[7:0];
					TOTAL_ADDRESSES-4: HEX0 <= data_in[6:0];
					TOTAL_ADDRESSES-3: HEX1 <= data_in[6:0];
					TOTAL_ADDRESSES-2: HEX2 <= data_in[6:0];
					TOTAL_ADDRESSES-1: HEX3 <= data_in[6:0];
					default: memory[addr] <= data_in;
				endcase
			end
			else begin
				case(addr)
					TOTAL_ADDRESSES-8: data_out <= {6'b0, SW};
					TOTAL_ADDRESSES-7: data_out <= {12'b0, KEY};
					default: data_out <= memory[addr];
				endcase
			end
		end
	end
endmodule
