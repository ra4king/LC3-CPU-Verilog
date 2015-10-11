LC3 CPU in Verilog
==================
This is an initial implementation of the LC3 ISA in Verilog HDL.


Setup
-----
Simply open the project in Quartus and hit TRL Simulator button (purple arrow, red clock ricks, white register).
If that gives you an error, find documentation on setting a Verilog simulator with Quartus.


Missing
-------
RTI - There is no interrupt hardware yet

TRAP - All TRAPs are HALT for now (to have TRAP x25 working)
	   There is IO hardware yet.
