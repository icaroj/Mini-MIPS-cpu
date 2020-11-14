# |.rootfolder/
# |Makefile
# |__src/
# |__tests/
# |__out/
#    |__simulations

CC=iverilog
VVP=vvp
FLAGS=-Wall -Winfloop

TARGET=out/minimips

MODULES=src/adder.v \
	src/alu.v \
	src/bit_shift_left.v \
	src/control_unit.v \
	src/core.v \
	src/cpu.v \
	src/data_memory.v \
	src/instruction_memory.v \
	src/mux_two_inputs.v \
	src/program_counter.v \
	src/pipeline_register_IF_ID.v \
	src/pipeline_register_ID_EX.v \
	src/pipeline_register_EX_MEM.v \
	src/pipeline_register_MEM_WB.v \
	src/registers_memory.v \
	src/sign_ext.v \

TESTDIR=tests

TESTS=registers_memory_tb.v \
	alu_tb.v \
	data_memory_tb.v \
	program_counter_tb.v \
	cpu_tb.v \

clean:
	rm -f $(TARGET)

all: $(TESTS)

%.v:
	$(CC) $(FLAGS) -o $(TARGET) $(MODULES) $(TESTDIR)/$@
	$(VVP) $(TARGET)
#
# iverilog  -o ./output/mini_mips_cpu ./src/ALU/half_adder.v ./tests/ALU_tb.v
# gtkwave ./simulations/alu_tb.vcd ./waveforms/half_adder.gtkw
#




