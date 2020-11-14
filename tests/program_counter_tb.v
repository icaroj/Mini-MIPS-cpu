`include "tests/test_config.v"

module PROGRAM_COUNTER_TB;

	reg clock;
	reg reset;
	reg jump_enable;
	reg [31:0] jump_address;
	wire [31:0] pc;

	program_counter pc_module(clock,
				reset,	
				jump_enable,
				jump_address,
				pc);

	always begin
		clock = ~clock;
		#1;
	end

	initial begin
        	$dumpfile(`SIMULATION_FILE(program_counter_tb));
        	$dumpvars(0, pc_module);
		
		$display("\n====================");
		$display("RUNNING: PC TESTS...");
		$display("====================");
		
		clock = 1;
		reset = 1;
		jump_enable = 0;
		jump_address = 0;

		@(posedge clock);
		reset = 0;

		repeat(3) @(posedge clock);
			
		jump_enable = 1'b1;
		jump_address = 32'h0001_0000;

		@(posedge clock);

		jump_enable = 0;

		repeat(3) @(posedge clock);

		reset = 1'b1;

		@(posedge clock);

		reset = 0;

		repeat(3) @(posedge clock);

		@(posedge clock);

		$display("=================");
		$display("PC TESTS END");
		$display("=================\n");

		$finish;
	end
endmodule

