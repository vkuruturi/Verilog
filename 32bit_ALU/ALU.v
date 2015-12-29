//32-bit ALU
//Venkat Kuruturi
module ALU (in_A, in_B, alu_mode, out, carry_in, carry_out, enable,zero_flag);
	parameter WIDTH = 32;	//bus width
	
//INPUT PORTS
	input [WIDTH-1:0] in_A;	//input from register A
	input [WIDTH-1:0] in_B;	//input from register B
	input [2:0] alu_mode;	//ALU operation mode
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
	output carry_out;		//Carry out from ALU
	output [WIDTH-1:0] out;	//output of ALU
	output zero_flag;		//zero flag.  set if output = 0

	wire [WIDTH-1] temp;
//CODE
	if(~enable) begin
		//AND OPERATION
		if(mode == 0) begin
			assign carry_out = carry_in;
			assign out = in_A & in_B;
		end
		//OR OPERATION		
		else if(mode == 1) begin
			assign carry_out = carry_in;
			assign out = in_A | in_B;
		end
		//XOR OPERATION
		else if (mode == 2) begin
			assign carry_out = carry_in;
			assign out = in_A ^ in_B;
		end
		//SHCL OPERATION
		else if (mode == 3) begin
			assign carry_out = in_A[31];
			assign out = in_A << 1;
			assign out[0] = carry_in;
		end
		//SHCR OPERATION
		else if (mode == 4) begin
			assign carry_out <= in_A[0];
			assign out <= in_A >> 1;
			assign out[31] <= carry_in;
		end
		//NOT OPERATION
		else if (mode == 5) begin
			assign carry _out = carry_in;
			assign out = ~in_A;
		end
		//ADD/SUB OPERATION
		else begin
			//negate B if necessary
			if (mode == 6) begin
				negate neg(temp,in_B);
			end
			else begin
				assign temp = in_B;
			end
			//add A and temp, temp = B|-B
			adder_32bit add(in_A,temp,out,carry_out);
		end
	end

endmodule //32 bit ALU

