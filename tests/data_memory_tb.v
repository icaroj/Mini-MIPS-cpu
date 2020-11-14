`include "tests/test_config.v"

module DATA_MEMORY_TB;

	reg clock;
	reg [31:0] address;
	reg [31:0] write_data;
	reg write_enable;
	wire [31:0] read_data;

	data_memory data_memory_module(clock,
				      address,
				      write_data,
				      write_enable,
				      read_data);

	always begin 
		clock = ~clock;
		#1;
	end

	initial begin
        	$dumpfile(`SIMULATION_FILE(data_memory_tb));
        	$dumpvars(0, data_memory_module);

		$display("\n============================");
		$display("RUNNING: DATA_MEMORY TESTS...");
		$display("============================");

		clock = 1'b0;
		address = 0;
		write_data = 0;
		write_enable = 1'b0;

		@(posedge clock);

		address = 32'd1;
		write_data = 32'hAABB_CCDD;
		write_enable = 1'b1;

		@(posedge clock);

		write_enable = 0;

		@(posedge clock);

		write_enable = 1;
		write_data = 32'hFFFF_FFFF;
		address = 32'd2;


		@(posedge clock);

		$display("============================");
		$display("DATA_MEMORY TESTS END");
		$display("============================\n");

		$finish;
	end
endmodule
