module data_memory(input clock,
	     	   input [31:0] address,
		   input [31:0] write_data,
		   input write_enable, 
		   //---------------------
		   output [31:0] read_data);

	parameter MEMORY_SIZE = 128;

	reg [31:0] data_memory [0:MEMORY_SIZE-1];

	always @(posedge clock) begin
		if(write_enable) begin
			data_memory[address[6:0]] <= write_data;
		end
	end

	assign read_data = data_memory[address[6:0]][31:0];
	
		
endmodule
