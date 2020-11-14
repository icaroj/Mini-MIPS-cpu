module pipeline_register_MEM_WB(input clock,
				input reset,
				input [4:0] MEM_write_reg_1,
				input [31:0] MEM_alu_result,
				input [31:0] MEM_dm_read_data,
				input MEM_rm_write_data_source,
				input MEM_rm_write_enable,
				//------------------------------
				output reg [4:0] WB_write_reg_1,
				output reg [31:0] WB_alu_result,
				output reg [31:0] WB_dm_read_data,
				output reg WB_rm_write_data_source,
				output reg WB_rm_write_enable);
		
	always @(posedge clock or posedge reset) begin
		if(reset) begin
			WB_write_reg_1 <= 0;
			WB_alu_result <= 0;
			WB_dm_read_data <= 0;
			WB_rm_write_data_source <= 0;
			WB_rm_write_enable <= 0;
		end 
		else begin
			WB_write_reg_1 <= MEM_write_reg_1;
			WB_alu_result <= MEM_alu_result;
			WB_dm_read_data <= MEM_dm_read_data;
			WB_rm_write_data_source <= MEM_rm_write_data_source;
			WB_rm_write_enable <= MEM_rm_write_enable;
		end
	end

endmodule

