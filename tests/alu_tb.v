`include "tests/test_config.v"
`include "src/alu_defs.v"

module ALU_TB;

	reg clock;
	reg [31:0] operator_a;
	reg [31:0] operator_b;
	wire [31:0] result;
	reg [5:0] opcode;
	wire operands_are_equal;
	wire result_is_zero;

	alu alu_module(operator_a,
		operator_b,
		opcode,
		result,
		operand_are_equal,
		result_is_zero);

	always begin
		clock = ~clock;
		#1;
	end

	initial begin
        	$dumpfile(`SIMULATION_FILE(alu_tb));
        	$dumpvars(0, alu_module);
		
		$display("\n====================");
		$display("RUNNING: ALU TESTS...");
		$display("====================");
		
		// initial all zero
		clock = 1'b0;
		operator_a = 0;
		operator_b = 0;
		opcode = 0;

		@(posedge clock);

		opcode = `ALU_CONTROL_ADD;
		operator_a = 32'd128;
		operator_b = 32'd127;

		@(posedge clock);

		if(result !== 32'd255) $display("ERROR: Addition Failed!");
		opcode = `ALU_CONTROL_AND;
		operator_a = 32'hFFFF_FFFF;
		operator_b = 32'h0000_FFFF;

		@(posedge clock);

		if(result !== 32'h0000_FFFF) $display("ERROR: Bitwise AND op failed!");

		@(posedge clock);

		$display("=================");
		$display("ALU TESTS END");
		$display("=================\n");

		$finish;
	end
endmodule

