module zxw_4to16_dec (data_in, eq);

input [3:0] data_in;
output reg	[15:0] eq;

always @ (data_in)
	case (data_in)
		4'h0: eq = 16'h0001;
		4'h1: eq = 16'h0002;
		4'h2: eq = 16'h0004;
		4'h3: eq = 16'h0008;
		4'h4: eq = 16'h0010;
		4'h5: eq = 16'h0020;
		4'h6: eq = 16'h0040;
		4'h7: eq = 16'h0080;
		4'h8: eq = 16'h0100;
		4'h9: eq = 16'h0200;
		4'ha: eq = 16'h0400;
		4'hb: eq = 16'h0800;
		4'hc: eq = 16'h1000;
		4'hd: eq = 16'h2000;
		4'he: eq = 16'h4000;
		4'hf: eq = 16'h8000;
		default: eq = 16'h0000;
	endcase
endmodule
