module pipeline_register_EX_MEM(input clock,
				input reset, 
				input [31:0] EX_alu_result,
				input [31:0] EX_read_data_2,
				input [4:0] EX_write_reg_1,
				input EX_dm_write_enable,
				input EX_rm_write_data_source,
				input EX_rm_write_enable,
				//-----------------------------
				output reg [31:0] MEM_alu_result,
				output reg [31:0] MEM_read_data_2,
				output reg [4:0] MEM_write_reg_1,
				output reg MEM_dm_write_enable,
				output reg MEM_rm_write_data_source,
				output reg MEM_rm_write_enable);
	
	always @(posedge clock or posedge reset) begin
		if(reset) begin
			MEM_alu_result <= 0;
			MEM_read_data_2 <= 0;
			MEM_write_reg_1 <= 0;
			MEM_dm_write_enable <= 0;
			MEM_rm_write_data_source <= 0;
			MEM_rm_write_enable <= 0;
		end
		else begin
			MEM_alu_result <= EX_alu_result;
			MEM_read_data_2 <= EX_read_data_2;
			MEM_write_reg_1 <= EX_write_reg_1;
			MEM_dm_write_enable <= EX_dm_write_enable;
			MEM_rm_write_data_source <= EX_rm_write_data_source;
			MEM_rm_write_enable <= EX_rm_write_enable;
		end
	end

endmodule
