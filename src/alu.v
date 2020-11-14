`include "src/alu_defs.v"

module alu(input [31:0] operand_a,
	input [31:0] operand_b,
	input [5:0] control,
	//-------------------------------
	output reg signed [31:0] result,
	output operands_are_equal,
	output result_is_zero);

	wire [31:0] result_wire;
	always @(*) begin 
		case(control) 
			`ALU_CONTROL_ADD: result <= operand_a + operand_b;
			`ALU_CONTROL_AND: result <= operand_a & operand_b;
			`ALU_CONTROL_OR:  result <= operand_a | operand_b;
			`ALU_CONTROL_SUB: result <= operand_a - operand_b;
			`ALU_CONTROL_XOR: result <= operand_a ^ operand_b;
			default: result <= 32'h0;
		endcase
	end

	assign operands_are_equal = (operand_a == operand_b) ? 1 : 0;
	assign result_is_zero = (result == 0) ? 1 : 0;

endmodule
