module alu_test;
	parameter BUS_WIDTH = 32;
	parameter len = 100;
	reg [BUS_WIDTH-1:0] a;
	reg [BUS_WIDTH-1:0] b;
	wire [BUS_WIDTH-1:0] out_;
	reg [2:0] md;
	wire cin;
	wire cout;
	wire zero;
	reg en;

	ALU alu1(a,b,md,out_,cin,cout,en,zero);

	initial begin
		md = 0;		//AND
		en = 0;
		for(a = 0; a<len; a = a+1) begin
			for(b = 0; b<len; b = b+1) begin
				#10;
				if(out_ != (a&b)) begin
					$monitor("ERROR IN ALU\n");
					$finish;
				end
			end
		end
		md = 1; 	//OR
		for(a = 0; a<len; a = a+1) begin
			for(b = 0; b<len; b = b+1) begin
				#10;
				if(out_ != (a|b)) begin
					$monitor("ERROR IN ALU\n");
					$finish;
				end
			end
		end
		md = 2;		//XOR
		for(a = 0; a<len; a = a+1) begin
			for(b = 0; b<len; b = b+1) begin
				#10;
				if(out_ != (a^b)) begin
					$monitor("ERROR IN ALU\n");
					$finish;
				end
			end
		end
	end
	
endmodule