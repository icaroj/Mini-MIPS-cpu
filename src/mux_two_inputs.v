module mux_two_inputs(input sel, 
		      input [31:0] in_1, 
		      input [31:0] in_2,
		      output [31:0] out);

	assign out = (sel) ? in_2 : in_1;

endmodule
