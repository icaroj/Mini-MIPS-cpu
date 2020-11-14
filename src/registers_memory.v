module registers_memory(input clock,
			input reset,
			input [4:0] read_reg_1,
		        input [4:0] read_reg_2, 
			input [4:0] write_reg,
			input [31:0] write_data,
			input write_enable, 
			// ---------------------- 
			output [31:0] read_data_1,
			output [31:0] read_data_2);	

	reg [31:0] registers [1:31];

	parameter REGISTERS_N = 32;
	parameter REGISTER_RZERO = 0;

	integer i;

	always @(negedge clock) begin
		if(reset) begin
			for(i=0; i < REGISTERS_N; i=i+1) begin
				registers[i] <= 0;
			end	
		end
		else begin 
			if(write_enable) begin
				registers[write_reg] <= write_data;
			end
		end
	end

	assign read_data_1 = (read_reg_1 == REGISTER_RZERO) ? 32'h0000_0000 : registers[read_reg_1];
	assign read_data_2 = (read_reg_2 == REGISTER_RZERO) ? 32'h0000_0000 : registers[read_reg_2];

endmodule
