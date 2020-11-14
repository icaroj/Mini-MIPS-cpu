`include "tests/test_config.v"

module REGISTERS_MEMORY_TB;

	reg clock;
	reg reset; 
	reg [4:0] read_reg_1;
	reg [4:0] read_reg_2;
	reg [4:0] write_reg;
	reg [31:0] write_data;
	reg write_enable;
	wire [31:0] read_data_1;
	wire [31:0] read_data_2;

	registers_memory reg_module(clock,
				    reset,
				    read_reg_1,
				    read_reg_2,
				    write_reg,
				    write_data,
				    write_enable,
				    read_data_1,
				    read_data_2);

	always begin 
		clock = ~clock;
		#1;
	end

	initial begin
        	$dumpfile(`SIMULATION_FILE(registers_memory_tb));
        	$dumpvars(0, reg_module);
		$display("\n==================================");
		$display("RUNNING: REGISTERS_MEMORY TESTS...");
		$display("==================================");
		
		clock = 1'b1;
		reset = 1'b1;
		read_reg_1 = 5'b0;
		read_reg_2 = 5'b0;
		write_reg = 5'b0;
		write_data = 32'b0;
		write_enable = 1'b0;

		@(posedge clock);
		reset = 0;
		
		@(posedge clock);

		reset = 1'b0;
		write_reg = 5'd1;
		write_data = 32'hCAFEBABE;
		write_enable = 1'b1;
		read_reg_1 = 5'd1;

		@(posedge clock);

		if(read_data_1 !== 32'hCAFEBABE) $display("ERROR: read_reg_1 != 0xCAFEBABE!");
		reset = 1'b0;
		read_reg_2 = 5'd1;

		@(posedge clock);

		if(read_data_2 !== 32'hCAFEBABE) $display("ERROR: read_reg_2 != 0xCAFEBABE!");
		reset = 1'b1;

		@(posedge clock);

		if(read_data_1 !== 0 && read_data_2 !== 0) $display("ERROR: reset failed!");
		reset = 1'b0;
		write_reg = 5'd0;
		write_data = 32'hFFFF_FFFF;
		write_enable = 1'b1;
		read_reg_1 = 5'd0;

		@(posedge clock);

		if(read_reg_1 !== 0) $display("ERROR: $r0 is not zero!");
		write_reg = 5'd5;
		read_reg_2 = 5'd5;

		@(posedge clock);
		
		if(read_data_2 !== 32'hFFFF_FFFF) $display("ERROR: read_reg_2 != 0xFFFF_FFFF!");
		write_reg = 5'd2;
		write_enable = 1'b0;
		read_reg_1 = 5'd2;

		@(posedge clock);

		if(read_data_1 === 32'hFFFF_FFFF) $display("ERROR: disable signal didnt prevent write!");

		$display("==================================");
		$display("REGISTERS_MEMORY TESTS END");
		$display("==================================\n");

		$finish;
	end
endmodule


