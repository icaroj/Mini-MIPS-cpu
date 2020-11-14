module cpu(input clock, input reset);

	wire [31:0] pc_register_bus;
	wire [31:0] im_instruction_bus;

	instruction_memory im(.clock(clock),
			      .address(pc_register_bus),
			      .data(im_instruction_bus));

	core cpu_core(.clock(clock),
	       	      .reset(reset),
		      .IF_instruction(im_instruction_bus),
		      .pc_register(pc_register_bus));

endmodule
