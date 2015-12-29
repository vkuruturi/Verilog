

module adder_32bit(A, B, SUM, CO);  
parameter WIDTH =32;
 
input  [WIDTH-1:0] A;  
input  [WIDTH-1:0] B;  

output [WIDTH-1:0] SUM;  
output CO;  

wire [WIDTH:0] tmp;  

  assign tmp = A + B;  
  assign SUM = tmp [WIDTH-1:0];  
  assign CO  = tmp [WIDTH];  
endmodule //32 bit adder

module negate(minus_i,i);
   input [31:0] i;
   
   output [31:0] minus_i;

   assign        minus_i = -i;
endmodule
