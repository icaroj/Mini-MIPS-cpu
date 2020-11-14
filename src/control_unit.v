`include "src/alu_defs.v"
`include "src/instructions_defs.v"

module control_unit(input [5:0] instruction_opcode,
		    input [5:0] instruction_func,
		    //--------------------------
		    output reg pc_jump_enable,
		    output reg pc_conditional_branch,
		    output reg [1:0] alu_operand_source,
		    output reg [5:0] alu_control,
		    output reg dm_write_enable, 
		    output reg rm_write_data_source,
		    output reg rm_write_enable); 

	always @(instruction_opcode, instruction_func) begin
		case(instruction_opcode) 
			`OPCODE_R_TYPE_INST: decode_r_type_instruction();
			`OPCODE_ADDI: decode_i_type_instruction_addi();
			`OPCODE_ANDI: decode_i_type_instruction_andi();
			`OPCODE_BEQ: decode_i_type_instruction_beq();
			`OPCODE_SW: decode_i_type_instruction_sw();
			`OPCODE_LW: decode_i_type_instruction_lw();
		endcase
	end

	task decode_r_type_instruction;
		begin	
			case(instruction_func)
				`FUNC_ADD: begin
					dm_write_enable <= 0;
					pc_jump_enable <= 0;
					rm_write_enable <= 1;
					alu_control <= `ALU_CONTROL_ADD;
				end
				`FUNC_AND: begin 
					dm_write_enable <= 0;
					pc_jump_enable <= 0;
					rm_write_enable <= 1;
					alu_control <= `ALU_CONTROL_AND;
				end
				`FUNC_JR: begin
					dm_write_enable <= 0;
					pc_jump_enable <= 1;
					pc_conditional_branch <= 0;
					rm_write_enable <= 0;
					alu_control <= `ALU_CONTROL_ADD;
				end
				`FUNC_SUB: begin
					dm_write_enable <= 0;
					pc_jump_enable <= 0;
					rm_write_enable <= 1;
				       	alu_control <= `ALU_CONTROL_SUB;
				end
				`FUNC_XOR: begin 
					dm_write_enable <= 0;
					pc_jump_enable <= 0;
					rm_write_enable <= 1;
					alu_control <= `ALU_CONTROL_XOR;
				end
				`FUNC_NOP: begin
					dm_write_enable <= 0;
					pc_jump_enable <= 0;
					rm_write_enable <= 0;
					alu_control <= `ALU_CONTROL_NOOP;
				end
			endcase
		end
	endtask
	
	task decode_i_type_instruction_addi;
		begin
			dm_write_enable <= 0;

			pc_jump_enable <= 0;

			rm_write_enable <= 1;
			rm_write_data_source <= `ALU;
			
			alu_operand_source <= `I_TYPE_INSTRUCTION;
			alu_control <= `ALU_CONTROL_ADD;
			// TODO: add exception for overflow
		end
	endtask

	task decode_i_type_instruction_andi;
		begin
			dm_write_enable <= 0;

			pc_jump_enable <= 0;

			rm_write_enable <= 1;
			rm_write_data_source <= `ALU;

			alu_operand_source <= `I_TYPE_INSTRUCTION;
			alu_control <= `ALU_CONTROL_AND;
		end
	endtask

	task decode_i_type_instruction_beq;
		begin
			dm_write_enable <= 0;

			pc_jump_enable <= 1;
			pc_conditional_branch <= 1;

			rm_write_enable <= 0;
			rm_write_data_source <= `ALU;

			alu_operand_source <= `I_TYPE_INSTRUCTION;
			alu_control <= `ALU_CONTROL_NOOP;
		end
	endtask

	task decode_i_type_instruction_sw;
		begin
			dm_write_enable <= 1;

			pc_jump_enable <= 0;

			rm_write_enable <= 0;
			
			alu_operand_source <= `I_TYPE_INSTRUCTION;
			alu_control <= `ALU_CONTROL_ADD;
			// TODO: add exception for unaligned-address
		end
	endtask

	task decode_i_type_instruction_lw;
		begin
			dm_write_enable <= 0;

			pc_jump_enable <= 0;

			rm_write_enable <= 1;
			rm_write_data_source <= `DATA_MEMORY;

			alu_operand_source <= `I_TYPE_INSTRUCTION;
			alu_control <= `ALU_CONTROL_ADD;
		end
	endtask
endmodule
