`include "tests/test_config.v"

module CPU_TB;

	reg clock;
	reg reset;

	cpu cpu_module(clock, reset);

	always begin 
		clock = ~clock;
		#1;
	end

	initial begin
        	$dumpfile(`SIMULATION_FILE(cpu_tb));
        	$dumpvars(0, cpu_module);

		$display("\n========================");
		$display("RUNNING: CPU  TESTS...");
		$display("========================");

		clock = 1;
		reset = 1;

		@(posedge clock);

		reset = 0;

		repeat(20) @(posedge clock);

		$display("====================");
		$display("CPU TESTS END");
		$display("====================\n");

		$finish;
	end
endmodule
