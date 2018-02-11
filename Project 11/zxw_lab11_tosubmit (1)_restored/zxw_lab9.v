module zxw_lab9(Resetn_pin, Clock_pin, SW_pin, Display_pin);

		input Resetn_pin, Clock_pin;
		input [4:0] SW_pin;
		output [7:0] Display_pin;
		
		parameter [1:0] MC0=2'b00, MC1=2'b01, MC2=2'b10,MC3 = 2'b11;
		parameter [3:0] ADD_IC = 4'b0000, SUB_IC = 4'b0001, ADDC_IC = 4'b0010,
		SUBC_IC = 4'b0011 , NOT_IC = 4'b0100, AND_IC = 4'b0101, OR_IC = 4'b0110,
		SHRA_IC = 4'b0111 , ROTR_IC = 4'b1000, ST_IC= 4'b1001, LD_IC = 4'b1010, JMP_IC= 4'b1011,
		CPY_IC = 4'b1100, SWAP_IC = 4'b1101, CNT_IC = 4'b1110;
		parameter [3:0] JU=4'b0000, JC1=4'b1000, JN1 = 4'b0100, JV1= 4'b0010,
		JZ1 = 4'b0001, JC0 = 4'b0111, JN0 = 4'b1011, JV0 = 4'b1101, JZ0 = 4'b1110;
		
		reg [13:0] R [31:0];
		reg WR_DM, stall_mc0, stall_mc1, stall_mc2, stall_mc3;
		//reg [1:0] MC;
		reg [13:0] PC, IR3, IR2, IR1, MAB, MAX, MAeff, SP, DM_in, IPDR;
		reg [13:0] TA, TB, TALUH, TALUL;
		reg [7:0] TSR, SR;
		reg [7:0] Display_pin;
		reg [14:0] TALUout;
		//reg counter;
		wire [13:0] result1,result2;
		wire [13:0] PM_out, DM_out;
		wire C, Clock_not;
		//wire AddC,AddV,SubC,SubV;
		//wire [13:0] Shiftout;
		//wire [14:0] Rotateout;
		//integer Ri,Rj; 
		integer Ri1, Rj1, Ri2, Rj2, Ri3, Rj3;
		integer counter;
		reg counter_flag;
		wire q;
		wire stall_flg,stall_flg2;
		assign Clock_not = ~Clock_pin;
		
		//zxw_shift my_shift ( TA, TB, Shiftout);
		//zxw_rotate1 my_rotate ( {TA,TSR[7]},TB, Rotateout);  
		zxw_crom_v my_crom( Resetn_pin, PC[13:0], Clock_not, PM_out,stall_flg);
		//zxw_rom my_rom (PC[9:0], Clock_not, PM_out);
		zxw_cram_v my_cram( Resetn_pin, MAeff[13:0], DM_in, WR_DM, Clock_not, stall_flg2,DM_out);
		//zxw_ram my_ram (MAeff[9:0], Clock_not, DM_in, WR_DM, DM_out);
		
		//zxw_counter mycounter (Clock_not, counter,q);
	
		
		always@(posedge Clock_pin)
		
						if (Resetn_pin == 0)
								begin 
								PC = 14'b00000000000000;
								IR3 = 14'h3fff; IR2 = 14'h3fff; IR1 = 14'h3fff;
								R[0]=0; R[1]= 0; R[2]=0; R[3]=0; R[4] =0;
								R[5]=0; R[6]=0; R[7]=0; R[8]=0; R[9]=0; R[10]=0;
								R[11]= 0; R[12]=0; R[13]=0; R[14] =0;R[15]=0; R[16]=0; R[17]=0; R[18]=0; R[19]=0; R[20]=0;
								R[21]= 0; R[22]=0; R[23]=0; R[24] =0;R[25]=0; R[26]=0; R[27]=0; R[28]=0; R[29]=0; R[30]=0;
								R[31]=0;
								stall_mc0 = 0; stall_mc1 =0 ;stall_mc2 = 0; stall_mc3 = 0;
								//MC = MC0;
								MAeff = 0;
								MAB=0; MAX=0; DM_in=0; 
								TALUL = 0; TALUH = 0;
								TA =  1'b0 ; TB = 1'b0;
								TSR = 0; SR = 0;
								SP = 0; WR_DM = 1'b0;
								Display_pin = 0;IPDR =0; // TALUout = 0;
								counter = 0;counter_flag=0;
								end
								
						else
								begin
								
								if ( counter_flag == 1)
								begin
									counter = counter +1;
								end
								
								if (stall_flg == 1 || stall_flg2 ==1)
									PC = PC;
								else
								begin
												
								if ( stall_mc3 == 0 )
										
												
								begin
												case (IR3[13:10])					
												
													ADD_IC, SUB_IC, ADDC_IC, SUBC_IC, NOT_IC, AND_IC, OR_IC, SHRA_IC, ROTR_IC:
														begin 
															R[Ri3] = TALUH;
															SR = TSR;
														end
													LD_IC:
														begin
																
															if (MAeff < 14'h3FFF && MAeff > 14'h3F00)
																begin
																		if ( MAeff == 14'h3FF8)
																			counter_flag = 1'b1;
																		else
																			R[Rj3] = {10'b0000000000,SW_pin} ;	
																end	
															else
																R[Rj3] = DM_out;
														end
														
													ST_IC:
														begin
															
															if (MAeff < 14'h3FFF && MAeff > 14'h3F00)
																begin
																	if ( MAeff == 14'h3FF8)
																	begin
																		Display_pin = counter;
																		counter_flag = 1'b0;
																	end
																	else if (MAeff == 14'h3FF9)
																		counter_flag = 1'b0;
												
																	else
																		Display_pin = R[Rj3][7:0];
																end
															else
																DM_in = R[Rj3];
															WR_DM = 1'b0;
														end
													JMP_IC:
														begin
															case (IR3[4:1])
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
															R[IR3[9:5]]= TALUL;
														end
													SWAP_IC:
														begin
															R[IR3[9:5]] = TALUL;
															R[IR3[4:0]] = TALUH;
														end
													
													 default:  ;
														
												endcase
												
											 end				
												
				// MC 2 				
								if ( stall_mc2 == 0 )									
										begin
												case (IR2[13:10])
													
													ADD_IC, ADDC_IC:
														begin

															TALUout = TA +TB ; 
															
															TSR[7]= TALUout[14];
															
															TSR[6] = TALUout[13] ;
															
															TSR[5] = ((TA[13] ~^ TB[13]) & TA[13]) ^ (TALUout[13] & (TA[13] ~^ TB[13])); // V Overflow
															if ( TALUout[13:0] ==14'b 00000000000000) 
																TSR[4] =1;
															else 
																TSR[4] =0;
															TSR[3:0] = 0;
															TALUH  = TALUout[13:0];
														end
													SUB_IC, SUBC_IC:
														begin

															TALUout = TA - TB ; 
															
															TSR[7]= TALUout[14];
															
															TSR[6] = TALUout[13] ;
															
															TSR[5] = ((TA[13] ~^ TB[13]) & TA[13]) ^ (TALUout[13] & (TA[13] ~^ TB[13])); // V Overflow
															if ( TALUout[13:0] ==14'b 00000000000000) 
																TSR[4] =1;
															else 
																TSR[4] =0;
															TSR[3:0] = 0;
															TALUH  = TALUout[13:0];
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
																case (IR2[1:0])
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
															case (IR2[1:0])
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
    												LD_IC, JMP_IC:
														begin
																MAeff = MAB + MAX;
																WR_DM = 1'b0;
														end
														
													ST_IC:
														begin
																MAeff = MAB + MAX;
																WR_DM = 1'b1;
																DM_in = R[Rj2];
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
															;
												endcase
												
								end
								 
												
								//MC 1 
								if (stall_mc1 == 0)
								begin
												case (IR1[13:10])				
													ADDC_IC,SUBC_IC:
														begin
																if ( Ri2 == Ri1) TA = TALUH;	
																else TA = R[Ri1]; TB = {9'b 000000000, IR1[4:0]};														
														end
													NOT_IC, SHRA_IC, ROTR_IC:
														begin
																if ( Ri2 == Ri1) TA = TALUH;
																else TA = R[Ri1];
														end
													LD_IC,ST_IC:   
														begin 
																//if ( Ri2 == Ri1) TA = TALUH;
																//else TA = R[Ri];
																
																
																	MAB = PM_out;
																	if (Ri1 == 0)
																		begin
																			if(IR2[13:10] == ADDC_IC  )
																				begin 
																				if ( Ri2 == Ri1) 
																				MAX = TALUH;
																				end
																			else
																				MAX = 0;
																		end
																		
																	else
																		begin
																			if(IR2[13:10] == ADDC_IC )
																				begin 
																				if ( Ri2 == Ri1) 
																				MAX = TALUH;
																				end
																			else
																				MAX = R[Ri1];
																		end
																	PC = PC + 1'b1;
																
														end
														
													
													JMP_IC:
														begin
																MAB = PM_out;
																if (Ri1 == 0)
																	MAX = 0;
																	
																else
																	MAX = R[Ri1];
																PC = PC + 1'b1;
														end
													CPY_IC:
														begin
																if ( Rj1 == Ri2) TB = TALUH;
																else
																	TB = R[Rj1];
														end
													SWAP_IC:
														begin
																if ( Ri1 == Ri2) TA = TALUH ; else TA = R[Ri1];
																if ( Rj1 == Ri2) TB = TALUL ; else TB = R[Rj1]; 
														end
													
												default: 
						//  ADD_IC, SUB_IC, AND_IC, OR_IC
						//  IF IR3 == load
														begin
																if ( IR2[13:10] == SWAP_IC )
																	begin
																		if ( Ri2 == Ri1 ) TA = TALUH;
																		else if (Ri2 == Rj1 ) TA = TALUL;
																		else TA = R[Ri1];
																		if ( Rj2 == Rj1)  TB = TALUL;
																		else if (Rj2 == Ri1 ) TA = TALUL;
																		else TB = R[Rj1];
																	end
																
																else
																	begin
																	if ( Ri2 == Ri1) TA = TALUH;	
																	else TA = R[Ri1];
																	if ( Ri2 == Rj1) TB = TALUH;
																	else TB = R[Rj1];
																	end
														end
												endcase
										//MC = MC2;	
										end
						
											
										
								
								
					if ( stall_mc2 == 0 && (IR3[13:10] != JMP_IC && IR3[13:10] != ST_IC && IR3[13:10] != LD_IC ))
						begin 
							IR3 = IR2 ; Ri3 = Ri2 ; Rj3 = Rj2; stall_mc3 = 0;
						end
					else if ( stall_mc2 == 0 &&IR3[13:10] == ST_IC)
						begin
							stall_mc2 = 1;  
							//stall_mc1 =0;stall_mc3 = 0;
							IR3 = 14'hfffc;
							//stall_mc0 = 0; stall_mc1 =0 ; stall_mc2 = 1;stall_mc3 = 0;
							Ri3 = Ri2 ; Rj3 = Rj2;
						end
					else if ( stall_mc2 == 0 &&IR3[13:10] == LD_IC)
						begin
							stall_mc2 = 1;  
							//stall_mc1 =0;stall_mc3 = 0;
							IR3 = 14'hfffc;
							Ri3 = Ri2 ; Rj3 = Rj2;
						end
//					else if ( stall_mc2 == 0 && IR3[13:10] == LD_IC)
//						begin
//							//stall_mc0 = 0; stall_mc3 = 0;
//							stall_mc1 =0 ; stall_mc2 = 1;
//							IR3 = IR2 ; Ri3 = Ri2 ; Rj3 = Rj2;
//						end
					else 
						begin
							stall_mc2 = 1; IR3 = 14'hffff;
						end
					
					if ( stall_mc1 == 0 && (IR2[13:10] != JMP_IC && IR2[13:10] != ST_IC && IR2[13:10] != LD_IC ) )
						begin
							IR2 = IR1 ; Ri2 = Ri1 ; Rj2 = Rj1; stall_mc2 = 0; 
						end 
					else if (stall_mc1 ==0 && IR2[13:10] == ST_IC)
						begin
							stall_mc1 =1 ;
							//stall_mc0 = 0; stall_mc2 = 0;  //stall_mc2 = 0; 
							Ri2 = Ri1 ; Rj2 = Rj1; 
							IR2 = 14'hfffd;
						end
					else if (stall_mc1 ==0 && IR2[13:10] == LD_IC)
						begin
							stall_mc1 =1 ;
							//stall_mc0 = 0;stall_mc2 = 0;
							Ri2 = Ri1 ; Rj2 = Rj1; 
							IR2 = 14'hfffd;
						end
//					else if ( stall_mc1 == 0 && IR2[13:10] == LD_IC)
//						begin
//							stall_mc0 = 0; stall_mc1 =1 ;stall_mc2 = 0; 
//							IR2 = IR1 ; Ri2 = Ri1 ; Rj2 = Rj1; 
//						end
					else 
						begin
							stall_mc1 = 1; IR2 = 14'hffff;
						end
					
					if ( stall_mc0 == 0 && (IR1[13:10] != JMP_IC && IR1[13:10] != ST_IC && IR1[13:10] != LD_IC ) )	
						begin
							IR1 = PM_out; Ri1 = PM_out[9:5];  Rj1 = PM_out[4:0];
							PC = PC + 1'b1; stall_mc1 = 0 ;
							//Ri = PM_out[9:5]; Rj = PM_out[4:0];
						end
					else if ( stall_mc0 ==0 && IR1[13:10] == ST_IC)
						begin
							stall_mc0 = 1; stall_mc1 = 0 ;
							//IR1 = PM_out;// 
							
							
							IR1 = 14'hfffe;
							Ri1 = PM_out[9:5];  Rj1 = PM_out[4:0];
						end
					else if ( stall_mc0 ==0 && IR1[13:10] == LD_IC)
						begin
							stall_mc0 = 1; stall_mc1 = 0 ;
							
							IR1 = 14'hfffe;
							Ri1 = PM_out[9:5];  Rj1 = PM_out[4:0];
							
						end
	
					else
						begin
							stall_mc0 = 1; IR1 = 14'hffff;
						end
					
				   if ( IR3 == 14'hffff) stall_mc0 = 0;	
					
					if ( IR2 == 14'hfffd) stall_mc0 = 0;
					
					if ( IR3 == 14'hfffc) stall_mc1 = 0;
					
					//if ( IR3 == 14'hfffc) stall_mc2 = 0; 
					end
				end
			endmodule