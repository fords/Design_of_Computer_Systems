`timescale 1 ps / 1 ps
module zxw_tb;
	//----------------------------------------------------------------------------
//-- Declare input stimuli and expected outputs
//----------------------------------------------------------------------------
	reg	we_n_tb, rd_n_tb; //output enable
	reg	[5:0]	din_tb, argin_tb; //argument in
	reg	[3:0]	addrs_tb;
	wire	[5:0]	dout_tb;
	 wire [15:0]	mbits_tb;//mbits = match bits
	integer i;

zxw_CAM_v dut (we_n_tb, rd_n_tb, din_tb, argin_tb, addrs_tb, dout_tb, mbits_tb);

//----------------------------------------------------------------------------
// In the procedural block below, we write to all memory locations, we read 
// these out, and then load some argument values to see with which locations 
// these match - see match bits values.
//----------------------------------------------------------------------------

initial begin
		we_n_tb = 1;
		rd_n_tb = 1;
		din_tb = 6'b000000;
		argin_tb = 6'b000000;
		addrs_tb = 1'b0;
		#20000		
		for (i=0; i<=15; i=i+1) begin
			we_n_tb = 1;
			rd_n_tb = 1;
			din_tb = 6'b010101;
			argin_tb = 6'b000000;
			addrs_tb = i;
			#20000
			we_n_tb = 0;
			rd_n_tb = 1;
			din_tb = 6'b010101;
			argin_tb = 6'b000000;
			addrs_tb = i;
			#20000;
		end
		we_n_tb = 1;
		#20000
		for (i=0; i<=15; i=i+1) begin
			we_n_tb = 1;
			rd_n_tb = 1;
			din_tb = 6'b101010;
			argin_tb = 6'b000000;
			addrs_tb = i;
			#20000
			we_n_tb = 1;
			rd_n_tb = 0;
			din_tb = 6'b101010;
			argin_tb = 6'b000000;
			addrs_tb = i;
			#20000;
		end
		rd_n_tb = 1;
		#20000
		argin_tb = 6'b010101;
		#20000
		we_n_tb = 1;
		rd_n_tb = 1;
		din_tb = 6'b111111;
		argin_tb = 6'b000000;
		addrs_tb = 5;
		#20000
		we_n_tb = 0;
		rd_n_tb = 1;
		din_tb = 6'b111111;
		argin_tb = 6'b000000;
		addrs_tb = 5;
		#20000
		we_n_tb = 1;
		argin_tb = 6'b111111;
		#20000
		argin_tb = 6'b000000;
	end	
endmodule
