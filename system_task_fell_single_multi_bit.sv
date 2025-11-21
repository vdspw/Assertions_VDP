/* System tasks -- Sampled */
/* The system task Sampled is used to access the value of a variable in a preponed region.

In case of Concurrent assertions we need not use this task as the varaible is already evaulated
in the preponed regions. */

/* System task --- fell */
/* this detects the falling edge of the signal -- returns one on [ 1-> 0] or [X -> 0] transitions*/
/* usually requires 2 ticks to prove the transtion 1 -> 0 if in case of a signle clk tick then the case X->0 returns a one on the rose */


module tb;
 
  reg [3:0] b;////xxxx- unknown
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
 b = 4'b0101;
 #10;
 b = 4'b0000;
 
 
 end
 
 always@(posedge clk)
 begin
 $info("Value of b :%0b and $fell(b) : %0b", $sampled(b), $fell(b));
 end 
 
 
 initial begin
 $dumpfile("dump.vcd"); 
 $dumpvars;
 #60;
 $finish();
 end
 
 
endmodule
