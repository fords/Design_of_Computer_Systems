`timescale 1 ps / 1 ps
module zxw_tb_backup;
	reg [13:0] PM_address_tb;
	reg	Resetn_tb, Clock_tb;
	wire [15:0] PM_out_tb;
	integer i;

zxw_crom_v	dut	(Resetn_tb, PM_address_tb, Clock_tb, PM_out_tb);
	
initial	begin	
//----------------------------------------------------------------------------
//	Resetn_tb, PM_address, Clock_tb
//----------------------------------------------------------------------------
//-- Test Vector 1 (40ns): Reset
//----------------------------------------------------------------------------
	apply_test_vector(0, 14'h0000, 0);
//----------------------------------------------------------------------------
//-- These clock cycles are necessary to get the PLL going
//----------------------------------------------------------------------------
	for (i=0; i<5; i=i+1) begin
		Clock_tb = 0;
		#20000;
		Clock_tb = 1;
		#20000;
		end
//----------------------------------------------------------------------------
//-- All other test vectors test vectors how does 'i' work here concurrent or sequential
//----------------------------------------------------------------------------
	for (i=0; i<20; i=i+1) begin
		apply_test_vector(1, 14'h0000, 0);
	end
	apply_test_vector(1, 14'h000f, 0);
	for (i=0; i<20; i=i+1) begin
		apply_test_vector(1, 14'h0010, 0);
	end
end

task apply_test_vector;
	input	Resetn_int;
	input	[13:0] PM_address_int;
	input	Clock_int;
	
	begin
		Resetn_tb = Resetn_int; Clock_tb = Clock_int; 
		#20000;
		PM_address_tb = PM_address_int;
//PM_address is passed to the block on the rising edge of the clock
		Clock_tb = 1;
		#20000;
	end
endtask
endmodule
