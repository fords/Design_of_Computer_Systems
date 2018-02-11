module zxw_lab3(Resetn_pin, Clock_pin, SW_pin, Display_pin);

		input Resetn_pin, Clock_pin;
		input [4:0] SW_pin;
		output [7:0] Display_pin;
		
		parameter [1:0] MC0=2'b00, MC1=2'b01, MC2=2'b10,MC3 = 2'b11;
		parameter [3:0] ADD_IC = 4'b0000, SUB_IC = 4'b0001, ADDC_IC = 4'b0010,
		SUBC_IC = 4'b0011 , NOT_IC = 4'b0100, AND_IC = 4'b0101, OR_IC = 4'b0110,
		SHRA_IC = 4'b0111 , ROTR_IC = 4'b1000, ST_IC= 4'b1001, LD_IC = 4'b1010, JMP_IC= 4'b1011,
		CPY_IC = 4'b1100, SWAP_IC = 4'b1101;
		parameter [3:0] JU=4'b0000, JC1=4'b1000, JN1 = 4'b0100, JV1= 4'b0010,
		JZ1 = 4'b0001, JC0 = 4'b0111, JN0 = 4'b1011, JV0 = 4'b1101, JZ0 = 4'b1110;
		
		reg [13:0] R [31:0];
		reg WR_DM;
		reg [1:0] MC;
		reg [13:0] PC, IR, MAB, MAX, MAeff, SP, DM_in, IPDR;
		reg [13:0] TA, TB, TALUH, TALUL;
		reg [7:0] TSR, SR;
		reg [7:0] Display_pin;
		reg [14:0] TALUout;
		wire [13:0] result1,result2;
		wire [13:0] PM_out, DM_out;
		wire C, Clock_not;
		wire AddC,AddV,SubC,SubV;
		wire [13:0] Shiftout;
		wire [14:0] Rotateout;
		integer Ri,Rj; 
		
		assign Clock_not = ~Clock_pin;
		
		//zxw_shift my_shift ( TA, TB, Shiftout);
		//zxw_rotate1 my_rotate ( {TA,TSR[7]},TB, Rotateout);  
		
		zxw_rom my_rom (PC[9:0], Clock_not, PM_out);
		zxw_ram my_ram (MAeff[9:0], Clock_not, DM_in, WR_DM, DM_out);
		zxw_addsub myadd (1'b1, TA,TB, AddC,AddV,result1);
		zxw_addsub mysub (1'b0, TA,TB, SubC,SubV,result2);
		always@(posedge Clock_pin)
		
						if (Resetn_pin == 0)
								begin 
								PC = 14'b00000000000000;
								R[0]=0; R[1]= 0; R[2]=0; R[3]=0; R[4] =2'b10;
								R[5]=0; R[6]=0; R[7]=0; R[8]=0; R[9]=0; R[10]=0;
								R[11]= 0; R[12]=0; R[13]=0; R[14] =0;R[15]=0; R[16]=0; R[17]=0; R[18]=0; R[19]=0; R[20]=0;
								R[21]= 0; R[22]=0; R[23]=0; R[24] =0;R[25]=0; R[26]=0; R[27]=0; R[28]=0; R[29]=0; R[30]=0;
								R[31]=0;
								MC = MC0;
								MAeff = 0;
								MAB=0; MAX=0; DM_in=0; 
								TALUL = 0; TALUH = 0;
								TSR = 0; SR = 0;
								SP = 0; 
								Display_pin = 0; TALUout = 0;IPDR =0; 
								end
								
						else
								begin
								
								case(MC)
										MC0:
												
												begin
														IR = PM_out;
														Ri = PM_out[9:5];
														Rj = PM_out[4:0];
														PC = PC + 1'b1;
														WR_DM = 1'b0;
														MC = MC1;
												end
												
												
										MC1: 
										begin
												case (IR[13:10])
												
													ADDC_IC,SUBC_IC:
														begin
																TA = R[Ri];
																TB = {9'b 000000000, IR[4:0]};														
														end
													NOT_IC, SHRA_IC, ROTR_IC:
														begin
																TA = R[Ri];
														end
													LD_IC,ST_IC:   
														begin
																MAB = PM_out;
																if (Ri == 0)
																	MAX = 0;
																else
																	MAX = R[Ri];
																PC = PC + 1'b1;
														end
														
													
													JMP_IC:
														begin
																MAB = PM_out;
																if (Ri == 0)
																	MAX = 0;
																	
																else
																	MAX = R[Ri];
																PC = PC + 1'b1;
														end
													CPY_IC:
														begin
																TB = R[Rj];
														end
													
															
												default: 
						//  ADD_IC, SUB_IC, AND_IC, OR_IC, SWAP_IC
														begin
																TA = R[Ri];
																TB = R[Rj];
														end
												endcase
										MC = MC2;	
										end
										
									MC2: 
										begin
												case (IR[13:10])
													
													ADD_IC, ADDC_IC:
														begin
															TSR[7]= AddC;
															TSR[5]  = AddV;
															TSR[6] = result1[13];  //Negative
//															
															if (result1[13:0] == 14'b 00000000000000)
																TSR[4] = 1;				// Zero
															else
																TSR[4] = 0;
															TALUH = result1[13:0];
														end
													SUB_IC, SUBC_IC:
														begin
															TSR[7]= SubC;
															TSR[5]  = SubV;
															TSR[6] = result2[13];  //Negative
//									
															if (result2[13:0] == 14'b 00000000000000)
																TSR[4] = 1;				// Zero
															else
																TSR[4] = 0;
															TALUH = result2[13:0];
														end	
														
													NOT_IC:
														begin
															TALUH = ~TA;
														end
													AND_IC:
														begin
															TALUH = TA & TB;
															TSR[6] = TALUH[13]; // Negative
															if (TALUH[13:0] == 14'b 00000000000000)
																TSR[4] = 1;			// Zero
																else
																TSR[4] = 0;
														end	
														
													OR_IC:
														begin
															TALUH = TA | TB;
															TSR[6] = TALUH[13]; // Negative
															if (TALUH[13:0] == 14'b 00000000000000)
																TSR[4] = 1;			// Zero
																else
																TSR[4] = 0;
														end
														
													SHRA_IC:
															begin
																case (IR[1:0])
																	2'b00:
																		begin
																			TALUH = TA;
																		end
																	2'b01:
																		begin
																			TALUH[13]=TA[13]; TALUH[12:0]=TA[13:1]; 
																		end
																	2'b10:
																		begin
																			TALUH[13]=TA[13]; TALUH[12]=TA[13]; TALUH[11:0]=TA[13:2]; 
																		end
																	2'b11:
																		begin
																			TALUH[13]=TA[13]; TALUH[12]=TA[13]; TALUH[11]=TA[13]; TALUH[10:0]=TA[13:3]; 
																		end
																	endcase
															end
														 ROTR_IC:
															begin
																case (IR[1:0])
																	2'b00:
																		begin
																			TALUH = TA;
																		end
																	2'b01:
																		begin
																			TALUH[13]=TSR[7]; TALUH[12:0]=TA[13:1]; TSR[7] = TA[0];
																		end
																	2'b10:
																		begin
																			TALUH[13]=TA[0]; TALUH[12]=TSR[7]; TALUH[11:0]=TA[13:2]; TSR[7] = TA[1];
																		end
																	2'b11:
																		begin
																			TALUH[13]=TA[1]; TALUH[12]=TA[0]; TALUH[11]=TSR[7]; 
																			TALUH[10:0]=TA[13:3]; TSR[7] = TA[2];
																		end
											endcase
									end
													LD_IC,JMP_IC:
														begin
																MAeff = MAB + MAX;
																WR_DM = 1'b0;
														end
														
													ST_IC:
														begin
																MAeff = MAB + MAX;
																WR_DM = 1'b1;
																DM_in = R[Rj];
														end
													
													CPY_IC:
														begin
															TALUL = TB;
														end
													SWAP_IC:
														begin
															TALUH = TA;
															TALUL = TB;
														end
													default:
															MC = MC0;
												endcase
												MC = MC3;
								end
								MC3: 
										begin
												case (IR[13:10])					
												
													ADD_IC, SUB_IC, ADDC_IC, SUBC_IC, NOT_IC, AND_IC, OR_IC, SHRA_IC, ROTR_IC:
														begin 
															R[Ri] = TALUH;
															SR = TSR;
														end
													LD_IC:
														begin
															
															if (MAeff < 14'h3FFF && MAeff > 14'h3F00)
																R[Rj] = {9'b000000000,SW_pin} ;	
																
															else
																R[Rj] = DM_out;
														end
														
													ST_IC:
														begin
															WR_DM = 1'b0;
															if (MAeff < 14'h3FFF && MAeff > 14'h3F00)
																Display_pin = R[Rj][7:0];
															else
																DM_in = R[Rj];
																
														end
													JMP_IC:
														begin
															case (IR[4:1])
															JU:
																begin
																	PC = MAeff;
																end
															JC1:
																begin
																	if (SR[7] == 1)
																	PC = MAeff;
																	else
																	PC = PC;
																end
															JN1:
																begin
																	if (SR[6] == 1)
																	PC = MAeff;
																	else
																	PC = PC;
																end	
															JV1:
																begin
																	if (SR[5] == 1)
																	PC = MAeff;
																	else
																	PC = PC;
																end	
															JZ1:
																begin
																	if (SR[4] == 1)
																	PC = MAeff;
																	else
																	PC = PC;
																end	
															JC0:
																begin
																	if (SR[7] == 0)
																	PC = MAeff;
																	else
																	PC = PC;
																end
															JN0:
																begin
																	if (SR[6] == 0)
																	PC = MAeff;
																	else
																	PC = PC;
																end	
															JV0:
																begin
																	if (SR[5] == 0)
																	PC = MAeff;
																	else
																	PC = PC;
																end	
															JZ0:
																begin
																	if (SR[4] == 0)
																	PC = MAeff;
																	else
																	PC = PC;
																end
														   default:
																	PC = PC;
															endcase
														end
													CPY_IC:
														begin
															R[IR[9:5]]= TALUL;
														end
													SWAP_IC:
														begin
															R[IR[9:5]] = TALUL;
															R[IR[4:0]] = TALUH;
														end
													 default:
														MC = MC0;
												endcase
												MC = MC0;
											 end
											 default:
												MC = MC0;
										endcase
								end
					endmodule