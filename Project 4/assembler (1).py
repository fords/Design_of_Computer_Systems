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
    
def usage():
    print ' Help Message\n '
    print sys.exit(__doc__)


def parse_arguments():
    filename = "assembly.txt"
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
    with open(filename) as f:
		line_count = 0
    		for line in f:	
			
                     	line = line.lstrip() # remove whitespace @ the beginning	
			line2 =line.rstrip()
			filelines.append(line2)		
 			t = line2.partition(" ")
			code_str   = t[0]
			reg = t[2]
			#print code_str
			if (search(Opcode,code_str)): #check opcode is valid
				#pass
				#print Opcode[code_str]
				a = (str(line_count))
				a += ("\t:   ")
				a += str(Opcode[code_str])
				
			else:
				sys.exit('Undefined opcode'+str( line_count))
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
ADDRESS_RADIX = BIN;
DATA_RADIX = BIN;
        
CONTENT BEGIN
"""
        f2.write(template)
	  
    	arra =parse_arguments()
	count =0
	for p in arra:
    		print(p)
		f2.write(p) 
		f2.write("\t %   ")
		f2.write(filelines[count])
		f2.write("\t  % \n")  
		count = count+1
	f2.write("END;")
        f2.close
  	
