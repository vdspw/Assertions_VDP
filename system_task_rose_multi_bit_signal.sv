/* System tasks -- Sampled */
/* The system task Sampled is used to access the value of a variable in a preponed region.

In case of Concurrent assertions we need not use this task as the varaible is already evaulated
in the preponed regions. */

/* System task --- rose */
/* this detects the rising edge of the signal -- returns one on [ 0-> 1] or [X -> 1] transitions*/
/* usually requires 2 ticks to prove the transtion 0 -> 1 if in case of a signle clk tick then the case X->1 returns a one on the rose */

/* rose on multibit signal */

module tb;
 
  reg [3:0] b;
 reg clk = 0;
 
 
 always #5 clk = ~clk;
 
 
 initial begin
 b = 4'b0100;
   #10;
   b = 4'b0101;
   #10;
   b = 4'b0100;
   #10;
   b = 4'b0101;
   #10;
   b = 4'b0100;
   #10;
   b =4'b0101;
   #10;
   b =4'b0000;
 end
 
 always@(posedge clk)
 begin
   $info("Value of b :%0b and $rose(b) : %0b", $sampled(b), $rose(b));
 end 
 /* even in case of multi bit value the rose function only considers the LSB */
 
 initial begin
 $dumpfile("dump.vcd"); 
 $dumpvars;
 #120;
 $finish();
 end
 
 
       endmodule
