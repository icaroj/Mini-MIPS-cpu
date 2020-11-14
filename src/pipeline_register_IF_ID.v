module pipeline_register_IF_ID(input clock,
			       input reset,
			       input [31:0] IF_instruction, 
			       input [31:0] IF_pc_register,
			       //---------------------------------
			       output reg [31:0] ID_instruction,
			       output reg [31:0] ID_pc_register);

	always @(posedge clock or posedge reset) begin
		if(reset) begin
			ID_instruction <= 0;
			ID_pc_register <= 0;
		end
		else begin
			ID_instruction <= IF_instruction;
			ID_pc_register <= IF_pc_register;
		end
	end

endmodule
