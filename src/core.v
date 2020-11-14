`include "src/instructions_defs.v" 
`include "src/alu_defs.v" 

module core(input clock,
	    input reset,
	    input [31:0] IF_instruction,
	    output [31:0] pc_register);

	/* 
	*
	* INSTRUCTION FETCH
	*
	*/

	wire pc_jump_enable;
        wire [31:0] pc_jump_address;
	
	program_counter pc(clock,
	       		   reset, 
			   pc_jump_enable, 
			   pc_jump_address, 
			   pc_register);

	wire [31:0] ID_instruction;
	wire [31:0] ID_pc_register;

	pipeline_register_IF_ID IF_ID(clock,
				      reset,
				      IF_instruction,
				      pc_register,
				      ID_instruction,
				      ID_pc_register);

	/* 
	*
	* INSTRUCTION DECODE
	*
	*/

	wire [4:0] rm_read_reg_1 = ID_instruction[25:21];
	wire [4:0] rm_read_reg_2 = ID_instruction[20:16];
	wire [4:0] rm_write_reg_1;
	wire [31:0] rm_write_data;
	wire rm_write_enable;
	wire [31:0] rm_read_data_1;
	wire [31:0] rm_read_data_2;

	registers_memory rm(clock, 
			    reset,
	       		    rm_read_reg_1,
	       		    rm_read_reg_2,
	       		    rm_write_reg_1,
	       		    rm_write_data, 
			    rm_write_enable, 
			    rm_read_data_1, 
			    rm_read_data_2);

	wire [1:0] cu_alu_operand_source;
	wire [5:0] cu_alu_control;
	wire cu_dm_write_enable;
	wire cu_rm_write_data_source;
	wire cu_rm_write_enable;
	wire cu_pc_conditional_branch_sel;

	control_unit cu(ID_instruction[31:26],
			ID_instruction[5:0],
			pc_jump_enable,
			cu_pc_conditional_branch_sel,
			cu_alu_operand_source,
			cu_alu_control, 
			cu_dm_write_enable,
			cu_rm_write_data_source,
			cu_rm_write_enable);

	wire [31:0] ID_imm;

	sign_ext se16to32b(ID_instruction[15:0],
	       		   ID_imm);

	wire [31:0] pc_branch_address;
	wire [31:0] ID_imm_shifted;

	bit_shift_left bsl(ID_imm, 
			   2, 
			   ID_imm_shifted);

	adder pcadd(ID_pc_register,  
		    ID_imm_shifted,
		    pc_branch_address);

	mux_two_inputs m1(cu_pc_conditional_branch_sel,
			  rm_read_data_1,
			  pc_branch_address,
			  pc_jump_address);

	wire [4:0] EX_rs;
	wire [4:0] EX_rt;
	wire [4:0] EX_rd;
	wire [4:0] EX_sa;
	wire [31:0] EX_imm;
	wire [31:0] EX_rm_read_data_1;
	wire [31:0] EX_rm_read_data_2;
	wire [1:0] EX_alu_operand_source;
	wire [5:0] EX_alu_control;
	wire EX_dm_write_enable;
	wire EX_rm_write_data_source;
	wire EX_rm_write_enable;

	pipeline_register_ID_EX ID_EX(clock,
				      reset,
				      ID_instruction[25:21],
				      ID_instruction[20:16],
				      ID_instruction[15:11],
				      ID_instruction[10:6],
				      ID_imm,
				      rm_read_data_1,
				      rm_read_data_2,
				      cu_alu_operand_source,
				      cu_alu_control,
				      cu_dm_write_enable,
				      cu_rm_write_data_source,
				      cu_rm_write_enable,
				      EX_rs,
				      EX_rt,
				      EX_rd,
				      EX_sa,
				      EX_imm,
				      EX_rm_read_data_1,
				      EX_rm_read_data_2,
				      EX_alu_operand_source,
				      EX_alu_control,
				      EX_dm_write_enable,
				      EX_rm_write_data_source,
				      EX_rm_write_enable);


	/*
	*
	* EXECUTE
	*
	*/
	
	reg [31:0] alu_operand_a = 0;
	reg [31:0] alu_operand_b = 0;
	reg [4:0] dst_register = 0;
	wire [31:0] alu_result;
	wire operands_are_equal;
	wire result_is_zero;

	always @(*) begin
		case(EX_alu_operand_source) 
			`R_TYPE_INSTRUCTION: begin
				alu_operand_a <= EX_rm_read_data_1;
				alu_operand_b <= EX_rm_read_data_2;
				dst_register <= EX_rd;
			end
			`I_TYPE_INSTRUCTION: begin
				alu_operand_a <= EX_rm_read_data_1;
				alu_operand_b <= EX_imm;
				dst_register <= EX_rt;
			end
		endcase
	end

	alu alu32b(alu_operand_a,
	       	   alu_operand_b,
	           EX_alu_control, 
		   alu_result, 
		   operands_are_equal, 
		   result_is_zero);
	
	wire [31:0] MEM_alu_result;
	wire [31:0] MEM_rm_read_data_2;
	wire [4:0] MEM_rm_write_reg_1;
	wire MEM_dm_write_enable;
	wire MEM_rm_write_data_source;
	wire MEM_rm_write_enable;

	pipeline_register_EX_MEM EX_MEM(clock,
					reset,
					alu_result,
					EX_rm_read_data_2,
					dst_register,
					EX_dm_write_enable,
					EX_rm_write_data_source,
					EX_rm_write_enable,
					MEM_alu_result,
					MEM_rm_read_data_2,
					MEM_rm_write_reg_1,
					MEM_dm_write_enable,
					MEM_rm_write_data_source,
					MEM_rm_write_enable);	
	
	/*
	*
	* DATA MEMORY ACCESS
	*
	*/

	wire [31:0] dm_read_data;
	data_memory dm(clock,
		       MEM_alu_result,
		       MEM_rm_read_data_2,
		       MEM_dm_write_enable,
		       dm_read_data);

		       
	wire [31:0] WB_alu_result;
	wire [31:0] WB_dm_read_data;
	wire [4:0] WB_rm_write_reg_1;
	wire WB_rm_write_data_source;
	wire WB_rm_write_enable;
	
	pipeline_register_MEM_WB MEM_WB(clock,
					reset,
					MEM_rm_write_reg_1,
					MEM_alu_result,
					dm_read_data,
					MEM_rm_write_data_source,
					MEM_rm_write_enable,
					WB_rm_write_reg_1,
					WB_alu_result,
					WB_dm_read_data,
					WB_rm_write_data_source,
					WB_rm_write_enable);
	/*
	*
	* WRITE-BACK
	*
	*/

	assign rm_write_enable = WB_rm_write_enable;
	assign rm_write_reg_1 = WB_rm_write_reg_1;

	mux_two_inputs m2(WB_rm_write_data_source,
			  WB_alu_result,
			  WB_dm_read_data,
			  rm_write_data);

endmodule
