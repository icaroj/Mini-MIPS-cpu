module bit_shift_left(input [31:0] in, input [31:0] n, output [31:0] out);
	assign out = in << n;
endmodule
