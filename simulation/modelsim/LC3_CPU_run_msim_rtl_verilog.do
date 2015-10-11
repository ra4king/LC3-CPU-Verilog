transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/LC3_CPU.v}
vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/MemoryController.v}
vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/Register.v}
vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/SEXT.v}
vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/RegFile.v}
vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/ALU.v}
vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/ConditionCode.v}
vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/Microcontroller.v}

vlog -vlog01compat -work work +incdir+E:/Roi\ Atalla/Documents/Programming/Verilog/LC3_CPU {E:/Roi Atalla/Documents/Programming/Verilog/LC3_CPU/LC3_CPU_Test.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  LC3_CPU_Test

add wave *
view structure
view signals
run -all
