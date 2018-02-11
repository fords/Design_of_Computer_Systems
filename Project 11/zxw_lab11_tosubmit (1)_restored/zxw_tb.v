`timescale 1 ps / 1 ps
module zxw_tb;
	reg	Resetn_tb, Clock_tb;
	reg	[4:0] SW_in_tb;
	wire [7:0] Display_out_tb;
	integer i;

zxw_lab9	dut	(Resetn_tb, Clock_tb, SW_in_tb, Display_out_tb);
	
initial	begin	
//----------------------------------------------------------------------------
//	Resetn_tb, Clock_tb, SW_in_tb, Display_out_tb
//----------------------------------------------------------------------------
//-- Test Vector 1 (80ns): Reset
//----------------------------------------------------------------------------
	for (i = 0; i<10; i = i+1)
	apply_test_vector(0, 0, 5'b00001);
	
	for (i = 0; i<10; i = i+1)
	apply_test_vector(0, 0, 5'b00001);
//----------------------------------------------------------------------------
//-- All other test vectors
//----------------------------------------------------------------------------
	//for (i=0; i<150; i=i+1)
	//	apply_test_vector(1, 0, 5'b00001);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00001);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00011);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00101);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00111);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01001);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01011);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01101);	
	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01111);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10001);	
	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10011);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10101);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10111);

	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11001);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11011);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11101);		
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11111);	
		
//----------------------------------------------------------------------------		
// start testing another matrix
//----------------------------------------------------------------------------
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00001);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00011);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00101);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00111);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01001);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01011);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01101);	
	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01111);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10001);	
	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10011);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10101);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10111);

	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11001);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11011);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11101);		
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11111);	
				
	for (i=0; i<1000; i=i+1)
		apply_test_vector(1, 0, 5'b11110);	
	//for (i=0; i<2500; i=i+1)
	//	apply_test_vector(1, 0, 5'b11110);	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00001);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00011);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00101);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b00111);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01001);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01011);
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01101);	
	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b01111);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10001);	
	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10011);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10101);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b10111);

	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11001);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11011);	
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11101);		
		
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11111);	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11111);	
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<150; i=i+1)
		apply_test_vector(1, 0, 5'b11111);
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
