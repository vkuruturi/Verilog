module test;

  /* Make a reset that pulses once. */
  reg reset = 0;
  initial begin
     # 1 reset = 1;
     # 3 reset = 0;
     # 200 $stop;
  end

  /* Make a regular pulsing clock. */
  reg clk = 0;
  always #5 clk = !clk;

  wire [7:0] value;
  counter c1 (value, clk, reset);

  initial
     begin
     	$monitor("At time %t, value = %h (%0d)",
              $time, value, value);
     //	$finish;
     end

endmodule // test