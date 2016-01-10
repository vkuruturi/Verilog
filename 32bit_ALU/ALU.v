//32-bit ALU Behavioral design
//Venkat Kuruturi
module ALU (in_A, in_B, mode, out, carry_in, carry_out, enable,zero_flag);
	parameter WIDTH = 32;	//bus width
	
//INPUT PORTS
	input [WIDTH-1:0] in_A;	//input from register A
	input [WIDTH-1:0] in_B;	//input from register B
	input [2:0] mode;	//ALU operation mode
/*
	ALU MODE DESCRIPTION 	( Y = output, A = input A, B = input B, Cin = carry in, Cout = carry out)
	M2	M1	M0		Operation	Description
	0	0	0		AND	Y = A and B; Cout=Cin
	0	0	1		OR	Y = A or B; Cout=Cin
	0	1	0		XOR	Y = A xor B; Cout=Cin
	0	1	1		SHCL	Shift A (with carry) Left; Cout=A31; Y31 = A30 ...Y3=A2; Y2=A1; Y1=A0; Y0=Cin
	1	0	0		SHCR	Shift A (with carry) Right; Y31=Cin;... Y2=A3; Y1=A2; Y0=A1; Cout=A0
	1	0	1		NOT	Y = not A; Cout=Cin
	1	1	0		SUB	Y = A - B; Cout=Carry from msb of A + ((not B) + 1)
	1	1	1		ADD	Y = A + B; Cout=Carry from msb of A + B
*/
	input enable;			//Output enable.  Active low
	input carry_in;			//Carry in

//OUTPUT PORTS
	output reg carry_out;		//Carry out from ALU
	output reg [WIDTH-1:0] out;	//output of ALU
	output reg zero_flag;		//zero flag.  set if output = 0

	reg [WIDTH-1:0] temp;
	reg [WIDTH:0] add_tmp;
//CODE
	always @(*) begin
		if(enable == 0) begin
			//AND OPERATION
			case(mode)
				0: begin
					carry_out = carry_in;
					out = in_A & in_B;
				end
				//OR OPERATION		
				1: begin
					carry_out = carry_in;
					out = in_A | in_B;
				end
				//XOR OPERATION
				2: begin
					carry_out = carry_in;
					out = in_A ^ in_B;
				end
				//SHCL OPERATION
				3: begin
					 carry_out = in_A[31];
					 out = in_A << 1;
					 out[0] = carry_in;
				end
				//SHCR OPERATION
				4: begin
					 carry_out = in_A[0];
					 out = in_A >> 1;
					 out[31] = carry_in;
				end
				//NOT OPERATION
				5: begin
					 carry_out = carry_in;
					 out = ~in_A;
				end
				//ADD/SUB OPERATION
				default: begin
					//negate B if necessary
					if (mode == 6) begin
						temp = -in_B;
					end
					else begin
						 temp = in_B;
					end
					//add A and temp, temp = B|-B
					add_tmp = in_A + in_B;  
	  				out = add_tmp[WIDTH-1:0];  
	  				carry_out  = add_tmp[WIDTH]; 
				end
			endcase
		end
		if (out == 0) begin
			zero_flag = 1;
		end
		else begin zero_flag = 0; end
	end
endmodule //32 bit ALU

