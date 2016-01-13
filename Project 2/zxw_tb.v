`timescale 1 ps / 1 ps
module zxw_tb;
	reg	Resetn_tb, Clock_tb;
	reg	[4:0] SW_in_tb;
	wire [7:0] Display_out_tb;
	integer i;

zxw_lab2	dut	(Resetn_tb, Clock_tb, SW_in_tb, Display_out_tb);
	
initial	begin	
//----------------------------------------------------------------------------
//	Resetn_tb, Clock_tb, SW_in_tb, Display_out_tb
//----------------------------------------------------------------------------
//-- Test Vector 1 (40ns): Reset
//----------------------------------------------------------------------------
	apply_test_vector(0, 0, 5'b00000);
//----------------------------------------------------------------------------
//-- All other test vectors
//----------------------------------------------------------------------------
	for (i=0; i<80; i=i+1)
		apply_test_vector(1, 0, 5'b00000);
end

task apply_test_vector;
	input	Resetn_int, Clock_int;
	input	[4:0] SW_in_int;
	
	begin
		Resetn_tb = Resetn_int; Clock_tb = Clock_int; 
		SW_in_tb = SW_in_int;
		#20000;
		Clock_tb = 1;
		#20000;
	end
endtask
endmodule
