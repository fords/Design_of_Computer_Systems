module zxw_cram_v ( Resetn,  DM_address, datain, ram_wr, Clock,stall_flg,DM_out);//
	
input [13:0] DM_address;
input Resetn , Clock;
input ram_wr;
input [13:0] datain;
output [13:0] DM_out;
output reg stall_flg;
wire [15:0] mbits, grp;
wire [13:0] DMM_out;
wire [13:0] DMM_out_val;
reg [13:0] MMM_address;
wire c0, c1, c2;
wire [5:0] dout;

reg we_n, rd_n;
reg miss, wren ;
//reg write_back;
reg MM_wr;
reg write_miss; 
reg [1:0] count;
reg start_write;
// DMC_address is the cache memory address
reg [7:0] DMC_address; // direct mapped
//    DMM is only 14-bits wide 2^8
reg [13:0] DMM_address;//,data;
reg [5:0] din;
reg [3:0] cam_addrs;
reg [4:0] transfer_count,write_count;
//wire clock_cache, clock_mm;

zxw_pll_3_v my_pll2 ( Clock, c0, c1, c2);
assign DMM_out_val = (write_miss| miss) ? DMM_out : datain;
//assign clock_cache = MM_wr ? c1:c2;
//assign clock_mm    = MM_wr ? c2:c1;
//assign MMM_address = start_write ? DM_address: DMM_address;
zxw_CAM_v my_cam2  ( we_n , rd_n , din, DM_address[13:8] , cam_addrs, dout, mbits);
zxw_ram my_ram ( MMM_address , c1, datain, MM_wr , DMM_out);
zxw_cache_v2 my_ram_cache2 ( DMC_address , c2, DMM_out_val, wren, DM_out);
zxw_4to16_dec my_dec2 (DM_address[7:4], grp);
always @ (posedge c0) begin
	if (Resetn == 0) begin
		miss = 1'b1; transfer_count = 5'b0000;
		we_n = 1'b1 ; rd_n =1'b1; start_write= 1; //write_back = 0;
		MM_wr = 1'b0; MMM_address =0;
		din = 1'b0; transfer_count = 1'b0; wren = 1'b0;
		DMC_address = 8'b00000000; write_miss= 1'b1;  cam_addrs=0; write_count = 0;
		stall_flg = 1'b1; count = 0;
		end
	else begin

		if (ram_wr == 1'b0) // read starts here
			begin
				MM_wr  = 1'b0; wren = 1'b0; start_write = 1;
				if ( miss == 0 ) begin
					we_n =1 ; 
					stall_flg = 1'b0;
					if (|(mbits & grp)) begin
						DMC_address = DM_address[7:0];
					end
					else begin miss =1'b1; transfer_count = 5'b00000; end
					 
				end
				
				if ( miss == 1 ) begin
					stall_flg = 1'b1;
					DMC_address = { DM_address[7:4], transfer_count[3:0]};
					DMM_address = { DM_address[7:4], transfer_count[3:0]};
					MMM_address = DMM_address;
					wren  = 1'b1;
					transfer_count = transfer_count + 1'b1;
					
				
				if (transfer_count == 5'b10001) begin
					miss = 0; wren = 1'b0; transfer_count = 5'b00000;
					din  = DM_address[13:8]; 
					cam_addrs = DM_address[7:4];
					we_n = 0; stall_flg = 1'b0;
					MMM_address = DM_address;
				end
	
				end
			end
			
		
	//	if (ram_wr == 1'b1);  // write starts here
		else
			begin
				if ( write_miss == 0) begin
					// write into the tag group 
					if ( start_write == 1)
						begin
							MMM_address = DM_address;
							MM_wr = ram_wr; 
							stall_flg = 1'b1;
							count = count+1'b1;
							if (count == 2'b10)
							begin
								start_write = 0;
							end
						end
					if ( start_write ==0)
						begin
							MM_wr = 0; 
							we_n =1 ;  wren = ram_wr; 
							stall_flg = 1'b0;
							if (|(mbits & grp)) begin
								DMC_address = DM_address[7:0];
							end
							else begin 
								write_miss =1'b1; write_count = 5'b00000; 
							end
							start_write =1;count=0;
						end
					
				end
				
				if ( write_miss == 1'b1) begin
					//DMM_out_val = DMM_out;
					//if (dirtybit[DM_address[7:4]] != 1'b0) begin
					//	if (write_count == 5'b00000) begin
					//		MM_wr = ram_wr;
					//	end
						if ( start_write == 1)
						begin
							MMM_address = DM_address;
							MM_wr = ram_wr; 
							stall_flg = 1'b1;
							count = count+1'b1;
							if (count == 2'b10)
							begin
								start_write = 0;
							end
						end
						if ( start_write ==0)
						begin
							MM_wr = 1'b0; 
							//start_write = 0;
							stall_flg = 1'b1;
										
							DMC_address = { DM_address[7:4], write_count[3:0]};
							DMM_address = { DM_address[7:4], write_count[3:0]};
							MMM_address = DMM_address;
							wren = 1'b1;//write into cache
							
							write_count = write_count+ 1'b1;
							//write_back = 1'b1;	
							
							if (write_count == 5'b10001) begin
								write_miss = 1'b0; wren = 1'b0; write_count = 5'b00000;
								din  = DM_address[13:8]; 
								cam_addrs = DM_address[7:4];
								we_n = 0; //reset write into cache (to do
								//MM_wr = 0;
								stall_flg =1'b0;start_write =1;count=0;
								MMM_address = DM_address;// write_back = 1'b0; 
							end
							
						end
//					else begin // dirty bit low
//						
//						stall_flg = 1'b1;
//						DMC_address = { DM_address[7:4], write_count[3:0]};
//						DMM_address = { DM_address[7:4], write_count[3:0]};
//						wren = 1'b1;  //write into cache
//						
//						write_count = write_count+ 1'b1;
//					
//						if (write_count == 5'b10001) begin
//							write_miss = 0;
//							wren = 1'b0; write_count = 5'b00000;
//							din  = DM_address[13:8]; 
//							cam_addrs = DM_address[7:4];
//							we_n = 0; stall_flg = 1'b0; 
//							//dirtybit[DM_address[7:4]]=1'b1;
//							//write_back = 1'b0;//reset write into cache 
//						end
					//end
					//end
					
				end
				
				
			end
		end
	end
endmodule 