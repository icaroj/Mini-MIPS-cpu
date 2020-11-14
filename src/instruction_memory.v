module instruction_memory(input clock,
       			  input [31:0] address, 
			  //--------------------
			  output reg [31:0] data);

	parameter MEMORY_SIZE = 128;

	reg [31:0] instruction_memory [0:MEMORY_SIZE-1];

	initial begin
		instruction_memory[0][31:0] <= 32'b001000_00000_00001_0000000000010000;   // addi $r1, $r0, 16
		instruction_memory[1][31:0] <= 32'b000000_00000_00000_00000_00000_000000; // nop 
		instruction_memory[2][31:0] <= 32'b000000_00000_00000_00000_00000_000000; // nop 
		instruction_memory[3][31:0] <= 32'b000000_00000_00000_00000_00000_000000; // nop 
		instruction_memory[4][31:0] <= 32'b101011_00000_00001_0000000000000100;   // sw $r1, 4($r0)
		instruction_memory[5][31:0] <= 32'b100011_00000_00010_0000000000000100;   // lw $r2, 4($r0)
		instruction_memory[6][31:0] <= 32'b000000_00000_00000_00000_00000_000000; // nop 
		instruction_memory[7][31:0] <= 32'b000000_00000_00000_00000_00000_000000; // nop 
		instruction_memory[8][31:0] <= 32'b001000_00010_01000_1111111111111000;   // addi $r8, $r2,-8
		instruction_memory[9][31:0] <= 32'b001100_00010_00010_0000000000010110;  // andi $r2, $r2, 23
		//instruction_memory[10][31:0] <= 32'b000000_00010_00000_00000_00000_001000;// jr $r2
		instruction_memory[10][31:0] <= 32'b000100_00000_00000_1111111111111111; // beq $r0, $r0, -1
		instruction_memory[11][31:0] <= 32'b000000_00000_00000_00000_00000_000000; // branch delay slot: nop 
	end

	always @(posedge clock) begin
		data <= instruction_memory[address[8:2]][31:0];
	end

endmodule
