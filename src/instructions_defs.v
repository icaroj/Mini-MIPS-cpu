`ifndef _INSTRUCTIONS_DEFS
`define _INSTRUCTIONS_DEFS

/* Define the Instructions and Operand Sources */
`define NOT_A_INSTRUCTION 2'b00
`define R_TYPE_INSTRUCTION 2'b01
`define I_TYPE_INSTRUCTION 2'b10
`define J_TYPE_INSTRUCTION 2'b11

/* Define writeback data source (alu or data memory) */
`define ALU 1'b0
`define DATA_MEMORY 1'b1

/* OPCODES */

`define OPCODE_R_TYPE_INST 6'h0

`define OPCODE_ADD OPCODE_R_TYPE_INST
`define OPCODE_AND OPCODE_R_TYPE_INST
`define OPCODE_JR OPCODE_R_TYPE_INST
`define OPCODE_SUB OPCODE_R_TYPE_INST
`define OPCODE_XOR OPCODE_R_TYPE_INST
`define OPCODE_ADDI 6'b001000
`define OPCODE_ANDI 6'b001100
`define OPCODE_BEQ  6'b000100
`define OPCODE_LW   6'b100011
`define OPCODE_SW   6'b101011

/* Func of R-Type Instructions */

`define FUNC_ADD 6'b100000
`define FUNC_AND 6'b100100
`define FUNC_JR  6'b001000
`define FUNC_NOP 6'b000000
`define FUNC_SUB 6'b100010
`define FUNC_XOR 6'b100110

`endif
