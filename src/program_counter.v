module program_counter(input clock, 
		       input reset, 
		       input jump_enable,
		       input [31:0] jump_address,
		       //---------------------
		       output  [31:0] pc_value);

	reg [31:0] register_pc;
	wire [31:0] pc_plus_four; 

	always @(posedge clock or posedge reset) begin
		if(reset) begin
			register_pc <= 0;
		end 
		else begin
			register_pc <= (jump_enable) ? jump_address : pc_plus_four;
		end
	end

	assign pc_plus_four = register_pc + 32'd4;
	assign pc_value = register_pc;

endmodule

