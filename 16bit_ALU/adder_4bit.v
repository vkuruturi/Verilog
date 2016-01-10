module adder_4bit (in_a, in_b, cin, sum, cout);
//structural representation of 4 bit adder
	input [3:0] in_a;		//input a
	input [3:0] in_b;		//input b
	input cin;				//carry in

	output cout;			//carry out
	output [3:0] sum;		//output of adder
	wire [2:0] carry;
	fulladder fa0(in_a[0],in_b[0],cin,sum[0],carry[0]);
	fulladder fa1(in_a[1],in_b[1],carry[0],sum[1],carry[1]);
	fulladder fa2(in_a[2],in_b[2],carry[1],sum[2],carry[2]);
	fulladder fa3(in_a[3],in_b[3],carry[2],sum[3],cout);
endmodule

module fulladder (in_a, in_b, cin, sum, cout);
	input in_a;
	input in_b;
	input cin;

	output sum;
	output cout;
	wire sum_ab;
	wire carry_ab;
	wire carry_cin_ab;

	halfadder ha1(in_a,in_b,sum_ab,carry_ab);
	halfadder ha2(cin,sum_ab,sum,carry_cin_ab);
	assign cout = carry_cin_ab | carry_ab;
endmodule

module halfadder (in_a, in_b, sum, cout);
	input in_a;
	input in_b;

	output sum;
	output cout;

	assign sum = in_a ^ in_b;
	assign cout = in_a & in_b;
endmodule