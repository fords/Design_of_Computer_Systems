module zxw_crom_v ( Resetn, PM_address, Clock, PM_out,stall_flg);

input [13:0] PM_address;
input Resetn , Clock;
output [13:0] PM_out;
output reg stall_flg;
wire [15:0] mbits, grp;
wire [13:0] PMM_out;
wire c0, c1, c2;
wire [5:0] dout;

reg we_n, rd_n;
reg miss, wren;

// PMC_address is the cache memory address
reg [7:0] PMC_address; // direct mapped
//    PMM is only 14-bits wide 2^8
reg [13:0] PMM_address;
reg [5:0] din;
reg [3:0] cam_addrs;
reg [4:0] transfer_count;
// i is used to capture the group address field
//integer i;

zxw_pll_3_v my_pll ( Clock, c0, c1, c2);

zxw_CAM_v my_cam0  ( we_n , rd_n , din, PM_address[13:8] , cam_addrs, dout, mbits);
// argin to check read hit
zxw_rom my_rom ( PMM_address , c1, PMM_out); // 14 bits need to CHANGE ROM SIZE
// actual cache memory and it is using c2 phase of the clock.
zxw_cache_v2 my_rom_cache ( PMC_address , c2, PMM_out, wren, PM_out);

zxw_4to16_dec my_dec (PM_address[7:4], grp);
always @ (posedge c0) begin
	if (Resetn == 0) begin
		miss = 1'b1; transfer_count = 5'b0000;
		we_n = 1'b1 ; rd_n =1'b1;
		
		din = 1'b0; transfer_count = 1'b0; 
		stall_flg = 1'b1;
		end
	else begin
		//i = PM_address[7:4];
			if ( miss == 0 ) begin
				we_n =1 ; 
				stall_flg = 1'b0;
				if (|(mbits & grp)) begin
					PMC_address = PM_address[7:0];
				end
			   else begin miss =1'b1; transfer_count = 5'b00000; end
				
			end
			
			if ( miss == 1 ) begin
				stall_flg = 1'b1;
				PMC_address = { PM_address[7:4], transfer_count[3:0]};
				PMM_address = { PM_address[7:4], transfer_count[3:0]};
				wren  = 1'b1;
				transfer_count = transfer_count + 1'b1; end
			if (transfer_count == 5'b10001) begin
				miss = 0; wren = 1'b0; transfer_count = 5'b00000;
				din  = PM_address[13:8]; 
				cam_addrs = PM_address[7:4];
				we_n = 0; stall_flg = 1'b0;
			end
	end
end
endmodule 