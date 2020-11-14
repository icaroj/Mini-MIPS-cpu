module pipeline_register_ID_EX(input clock,
			       input reset,
			       input [4:0] ID_rs, 
			       input [4:0] ID_rt, 
			       input [4:0] ID_rd,
			       input [4:0] ID_sa,
			       input [31:0] ID_imm,
			       input [31:0] ID_read_data_1, 
			       input [31:0] ID_read_data_2,
			       input [1:0] ID_alu_operand_source,
			       input [5:0] ID_alu_control,
			       input ID_dm_write_enable,
			       input ID_rm_write_data_source,
			       input ID_rm_write_enable,
			       //---------------------------------
			       output reg [4:0] EX_rs, 
			       output reg [4:0] EX_rt, 
			       output reg [4:0] EX_rd,
			       output reg [4:0] EX_sa,
			       output reg [31:0] EX_imm,
			       output reg [31:0] EX_write_data_1,
			       output reg [31:0] EX_write_data_2,
			       output reg [1:0] EX_alu_operand_source,
			       output reg [5:0] EX_alu_control,
			       output reg EX_dm_write_enable,
			       output reg EX_rm_write_data_source,
			       output reg EX_rm_write_enable);
			       	
	always @(posedge clock or posedge reset) begin
		if(reset) begin
			EX_rs <= 0;
			EX_rt <= 0;
			EX_rd <= 0;
			EX_sa <= 0;
			EX_imm <= 0;
			EX_write_data_1 <= 0;
			EX_write_data_2 <= 0;
			EX_alu_operand_source <= 0;
			EX_alu_control <= 0;
			EX_dm_write_enable <= 0;
			EX_rm_write_data_source <= 0;
			EX_rm_write_enable <= 0;

		end
		else begin
			EX_rs <= ID_rs;
			EX_rt <= ID_rt;
			EX_rd <= ID_rd;
			EX_sa <= ID_sa;
			EX_imm <= ID_imm;
			EX_write_data_1 <= ID_read_data_1;
			EX_write_data_2 <= ID_read_data_2;
			EX_alu_operand_source <= ID_alu_operand_source;
			EX_alu_control <= ID_alu_control;
			EX_dm_write_enable <= ID_dm_write_enable;
			EX_rm_write_data_source <= ID_rm_write_data_source;
			EX_rm_write_enable <= ID_rm_write_enable;
		end	
	end

endmodule
