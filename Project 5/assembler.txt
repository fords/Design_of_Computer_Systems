#!/usr/bin/python
#

#
# print a message
#

#print "Hello, World!";
from argparse import ArgumentParser
import re
import sys
import getopt
from array import *
Opcode = {
        'add': '0000','sub':'0001' ,'addc':'0010', 'subc':'0011', 'not':'0100',
	'and': '0101', 'or':'0110', 'shra' :'0111', 'rotr':'1000', 'st':'1001',
	'ld':'1010'   , 'jmp':'1011', 'cpy':'1100', 'swap':'1101'}
R_dic = { 'R0':'00000','R1':'00001','R2':'00010', 'R3':'00011', 'R4': '00100', 'R5':'00101', 'R6':'00110', 'R7':'00111', 'R8':'01000', 'R9':'01001', 
		'R10':'01010','R11':'01011','R12':'01100', 'R13':'01101', 'R14': '01110', 'R15':'01111', 'R16':'10000', 'R17':'10001', 'R18':'10010', 'R19':'10011', 
	        'R20':'10100','R21':'10101','R22':'10110', 'R23':'10111', 'R24': '11000', 'R25':'11001', 'R26':'11010', 'R27':'11011', 'R28':'11100', 'R29':'11101', 
  		'R30':'11110','R31':'11111'}
Rj_dic = None 

label_dict_hex ={} 
label_dict_bin ={}
comment_dict ={}
double_count =[]
#re_label = re.compile(r'^(?P<label>:\w+)\s*(?:(?P)<instr>[A-Za-z]{3})|$') 
jmp_array = ['JU','JC1','JN1','JV1','JZ1','JC0','JN0','JV0','JZ0','ju','jc0','jn0','jv0','jz0','jc1','jn1','jv1','jz1']   
#jmp_array1 = [J0,JN0,JC,JNC,JS,JNS,JZ,JNZ,j0,jn0,jc,jnc,js,jns,jz,jnz]  
jmpcond_dict = { 'JU':'00000', 'JC1':'10000', 'JN1':'01000' , 'JV1':'00100', 'JZ1' : '00010',
		'JC0':'01110', 'JN0':'10110', 'JV0':'11010' , 'JZ0':'11100',
  }
def usage():
    print ' Help Message\n '
    print sys.exit(__doc__)

def first_pass():
	filename = "testjmp.txt"
	line_count = 0
        with open(filename) as f:
		for line in f:
			line = line.lstrip() # remove whitespace @ the beginning	
			line2 =line.rstrip()
			t = line2.partition(" ")   # first word before space
			
			if (t[0] in jmp_array and 'label' in line2): 				
				line_count +=1
				
			elif (':' in line2 and t[0] not in jmp_array):
				#print line_count     # put the label into dictionary as key and line_count as value
				t  = line2.split(':')
				label = t[0]
				#print label
				label_dict_hex[label]= hex(line_count).split('x')[1]
				label_dict_bin[t[0]]=  bin(line_count)[2:].zfill(14)
				
				print label_dict_bin[t[0]]
			elif ( 'st' in t[0]):
				line_count +=1
				#print 'store'
				#print line_count
			elif ( 'ld' in t[0]):
				line_count +=1
				#print 'load'
				#print line_count	
			
			line_count += 1
	
def parse_arguments():
    #filename = "assembly.txt"
    filename = "testjmp.txt"
    outfile = "cpu.mif"
    Opcode = {
        'add': '0000','sub':'0001' ,'addc':'0010', 'subc':'0011', 'not':'0100',
	'and': '0101', 'or':'0110', 'shra' :'0111', 'rotr':'1000', 'st':'1001',
	'ld':'1010'   , 'jmp':'1011', 'cpy':'1100', 'swap':'1101'}
    R_dic = { 'R0':'00000','R1':'00001','R2':'00010', 'R3':'00011', 'R4': '00100', 'R5':'00101', 'R6':'00110', 'R7':'00111', 'R8':'01000', 'R9':'01001', 
		'R10':'01010','R11':'01011','R12':'01100', 'R13':'01101', 'R14': '01110', 'R15':'01111', 'R16':'10000', 'R17':'10001', 'R18':'10010', 'R19':'10011', 
	        'R20':'10100','R21':'10101','R22':'10110', 'R23':'10111', 'R24': '11000', 'R25':'11001', 'R26':'11010', 'R27':'11011', 'R28':'11100', 'R29':'11101', 
  		'R30':'11110','R31':'11111'}
    Rj_dic = None 
    #R_dic = { '0x0':'00000','0x1':'00001','0x2':'00010', '0x3':'00011', '0x4': '00100', '0x5':'00101', '0x6':'00110', '0x7':'00111', '0x8':'01000', '0x9':'01001', 
	#	'0x0a':'01010','0x0b':'01011','0x0c':'01100', '0x0d':'01101', '0x0e': '01110', '0x0f':'01111', '0x10':'10000', '0x11':'10001', '0x12':'10010', '0x13':'10011', 
	#        'R20':'10100','R21':'10101','R22':'10110', 'R23':'10111', 'R24': '11000', 'R25':'11001', 'R26':'11010', 'R27':'11011', 'R28':'11100', 'R29':'11101', 
  	#	'R30':'11110','R31':'11111'}
    arra =[]
    f3 = open(outfile, 'w') 
    line_count = 0
    with open(filename) as f:
		
		
			
    		for lines in f:	
			
                     	line1 = lines.lstrip() # remove whitespace @ the beginning	
			line2 =line1.rstrip()
			filelines.append(line2)		
 			t = line2.partition(" ")
			code_str   = t[0]
			reg = t[2]
			#print code_str
			#print reg
			#for v in t:
			#	print v
			if (t[0] in jmp_array ): 
				if ('label' not in line2):
					sys.exit('Label not provided!!')

			if (t[0] in jmp_array and 'label' in line2): 
				
				a = hex(line_count).split('x')[1]
				a = str(a)
				a += ("\t:   ")
				a += str(Opcode['jmp'])
				t = line2.partition(" ")
				jmp_con = t[0]
				t = t[2]
				b = t.partition(" ") # there are more white spaces
				register = b[0]
				address_tojump= b[2] 
				a += str(R_dic[register])
				
				a += str(jmpcond_dict[jmp_con])
				a += "\t %   "
				a += lines.rstrip()
				a += "\t %   \n"
				arra.append(a)
				
				line_count +=1 
				#print filelines[line_count]
				a = hex(line_count).split('x')[1]
				#print a
				a = str(a)
				a += ("\t:   ")
				a += str(label_dict_bin[address_tojump])
				
				
			elif ( 'label' in line2 and ':' in line2):
				#print 'label :'
				
				a = hex(line_count).split('x')[1]
				a = str(a)
				#print a
				a += ("\t:   ")
				t  = line2.split(':')
				label_notuse = t[0]
				line = t[1]
				line = line.lstrip() # remove whitespace @ the beginning	
				line2 =line.rstrip()
				t = line2.partition(" ")
				code_str   = t[0]
				reg = t[2]
				pattern = re.compile("^\s+|\s*,\s*|\s+$")
				Registers = [x for x in pattern.split(reg) if x]
				a += str(Opcode[code_str])
				Ri = Registers[0]
				a += str(R_dic[Ri])
		                Rj = Registers[1]
				if "#" in Rj:
					line1 = Rj.split('#')[1]
				
					if (len(line1)>5 or len(line1)<1):
						sys.exit('Invalid Rj values')
					else:
						a += str(line1)
				else:	
					a += str(R_dic[Rj])
			elif ( 'st' in line2):
				a = hex(line_count).split('x')[1]
				a = str(a)
				a += ("\t:   ")
				t = line2.partition(" ")
				code_str = t[0]
				list_str = t[2]
				list_str = list_str.split(',')
				Ri  = list_str[0]
				Rj  = list_str[1]
				MAB = list_str[2]					
				if '#' in MAB:
					MAB1 = MAB.split('#')[1]
				a += str(Opcode[code_str])
				a += R_dic[Ri]
				a += R_dic[Rj]
				a += "\t %   "
				a += lines.rstrip()
				a += "\t %   \n"
				arra.append(a)
				
				line_count +=1 

				a = hex(line_count).split('x')[1]
				a = str(a)
				a += ("\t:   ")
				a += MAB1.zfill(14)
				#a += "\t %   "
				#a += lines.rstrip()
				#a += "\t %   \n"
				#arra.append(a)

			elif ('ld' in line2):			
				#print a
				a = hex(line_count).split('x')[1]
				a = str(a)
				a += ("\t:   ")
				t = line2.partition(" ")
				code_str = t[0]
				list_str = t[2]
				list_str = list_str.split(',')
				Ri  = list_str[0]
				Rj  = list_str[1]
				MAB = list_str[2]					
				if '#' in MAB:
					MAB1 = MAB.split('#')[1]
				a += str(Opcode[code_str])
				a += R_dic[Ri]
				a += R_dic[Rj]
				a += "\t %   "
				a += lines.rstrip()
				a += "\t %   \n"
				arra.append(a)
				
				line_count +=1 

				a = hex(line_count).split('x')[1]
				a = str(a)
				a += ("\t:   ")
				a +=MAB1.zfill(14)
				
			else:		
				#print code_str
				
				if (search(Opcode,code_str)): #check opcode is valid
					#pass
					#print Opcode[code_str]
					#a = (str(line_count))
					
					#a = hex(line_count).split('x')[1]
					#a = str(a)
					#a += ("\t:   ")
					#a += str(Opcode[code_str])
					

				#else:

					a = hex(line_count).split('x')[1]
					a = str(a)
					#print a
					a += ("\t:   ")
					a += str(Opcode[code_str])
					pattern = re.compile("^\s+|\s*,\s*|\s+$")  # remove whitespace btw commas
					Registers = [x for x in pattern.split(reg) if x]
					#print Registers
					Ri = Registers[0]
			
					a += str(R_dic[Ri])
				        Rj = Registers[1]
					if "#" in Rj:
						line1 = Rj.split('#')[1]
				
						if (len(line1)>5 or len(line1)<1):
							sys.exit('Invalide Rj values')
						else:
							a += str(line1)
					else:	
						a += str(R_dic[Rj])
					
					
			line_count = line_count+1
			#a += ";\n"
			a += "\t %   "
			a += lines.rstrip()
			a += "\t% \n"
    			arra.append(a)
			
    return arra

def search(values, searchFor):
    for k in values:      
            if searchFor in k:
                return 1
    return None
    


if __name__ == "__main__":
	arra = []
	#a=''
	filelines=[]
	print ' Help Message\n '
	outfile = "cpu.mif"
	f2 = open(outfile, 'w') 
	template ="""WIDTH = 14;
DEPTH = 1024;
ADDRESS_RADIX = HEX;
DATA_RADIX = BIN;
        
CONTENT BEGIN
"""
        f2.write(template)
	#a =bin(1)[2:].zfill(8)
	#print a
	#line2 = 'label1: addc R10,#00001'
	
	first_pass()  
	#t= 'st R5,R6,#0011\n '
	#t= 'JC0 R2 label1\n'
    	#t = t.partition(" ")
	#t = t.split(':')
	#a = t[0]
	#b = t[2]
	#d = b.split(",")
	#print d[2]
	#c = t[2].partition(" ")
        #c = c[0]
	#print 'a'+a
	#print 'b'+b
	#print 'c'+c
	
	arra =parse_arguments()
	count =0
	d_count =0
	for p in arra:
    		print(p)
		#if (count < len(arra)):
		f2.write(p) 
		#f2.write("\t  % \n")  
		#	f2.write("\t %   ")
		
			#if count in double_count:
		#	f2.write("\t %   ")
			#	print 'double counted'
			 	
				#if (count < (len(arra)-2)):
			#f2.write(filelines[count])
		#	count = count +1 	
				
		#	f2.write("\t  % \n")  
	 		#else:
				#f2.write("\t %   ")
				#f2.write(filelines[d_count])
				#d_count = d_count+1	
				#f2.write("\t  % \n")  	
			#count = count+1
			

		
	f2.write("END;")
        f2.close
  	
