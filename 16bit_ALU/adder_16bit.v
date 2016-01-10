module adder_16bit_ripple (a, b, cin, sum, cout);
	
	input [15:0] a;
	input [15:0] b;
	input cin;

	output [15:0] sum;
	output cout;

	wire carry[4:0];
	assign carry[0] = cin;
	generate
		genvar i;
		for(i = 0;i <3; i = i+1) begin
			adder_4bit add(a[i+3:i],b[i+3:i],carry[i],sum[i+3:i], carry[i+1]);
		end
	endgenerate
	assign cout = carry[4];

endmodule

module adder_16bit_2carrysel (a,b,cin,sum,cout);

	input [15:0] a;
	input [15:0] b;
	input cin;

	output [15:0] sum;
	output cout;
	
	wire carry1[4:0];
	wire carry0[4:0];
	wire temp_sum0[15:0];
	wire temp_sum1[15:0];
	wire cout1;

	assign carry0[0] = 0;
	assign carry1[0] = 1;

	generate
		genvar i;
		for(i = 0; i <= 2; i=i+2) begin
			adder_4bit add_0_0(a[(i*4)+3:(i*4)],b[(i*4)+3:(i*4)],carry0[i],temp_sum0[(i*4)+3:(i*4)],carry0[i+1]);
			adder_4bit add_0_1(a[(i*4)+7:(i*4)+4],b[(i*4)+7:(i*4)+4],carry0[i+1],temp_sum0[(i*4)+7:(i*4)+4],carry0[i+2]);
			adder_4bit add_1_0(a[(i*4)+3:(i*4)],b[(i*4)+3:(i*4)],carry1[i],temp_sum1[(i*4)+3:(i*4)],carry1[i+1]);
			adder_4bit add_1_1(a[(i*4)+7:(i*4)+4],b[(i*4)+7:(i*4)+4],carry1[i+1],temp_sum1[(i*4)+7:(i*4)+4],carry1[i+2]);		
		end
	endgenerate
	
	assign sum[7:0] = (cin) ? temp_sum0[7:0] : temp_sum1[7:0];
	assign cout1 = (cin) ? carry0[2] : carry1[2];
	assign sum[15:8] = (cout1) ? temp_sum0[15:8] : temp_sum1[15:8];
	assign cout = (cout1) ? carry0[4] :carry1[4];

endmodule

module adder_16bit_4carrysel (a,b,cin,sum,cout);

	input [15:0] a;
	input [15:0] b;
	input cin;

	output [15:0] sum;
	output cout;

	wire carry1[4:0];
	wire carry0[4:0];
	wire carry[4:0];
	wire temp_sum0[15:0];
	wire temp_sum1[15:0];
	wire cout1;
	
	assign carry0[0] = 0;
	assign carry1[0] = 1;
	assign carry[0] = cin;
	generate
		genvar i;
		for(i = 0; i <4; i=i+1) begin
			adder_4bit add_0(a[(i*4)+3:(i*4)],b[(i*4)+3:(i*4)],carry0[i],temp_sum0[(i*4)+3:(i*4)],carry0[i+1]);
			adder_4bit add_1(a[(i*4)+3:(i*4)],b[(i*4)+3:(i*4)],carry1[i],temp_sum1[(i*4)+3:(i*4)],carry1[i+1]);
		end
	endgenerate

	generate
		genvar i;
		for(i = 0; i < 4; i=i+1) begin
			sum[(i*4)+3:(i*4)] = (carry[i]) ? temp_sum0[(i*4)+3:(i*4)] : temp_sum1[(i*4)+3:(i*4)];
			carry[i+1] = (carry[i]) ? carry0[i+1] : carry1[i+1];
		end
	endgenerate

	cout = carry[4];
endmodule


