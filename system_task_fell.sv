/* System tasks -- Sampled */
/* The system task Sampled is used to access the value of a variable in a preponed region.

In case of Concurrent assertions we need not use this task as the varaible is already evaulated
in the preponed regions. */

/* System task --- fell */
/* this detects the falling edge of the signal -- returns one on [ 1-> 0] or [X -> 0] transitions*/
/* usually requires 2 ticks to prove the transtion 1 -> 0 if in case of a signle clk tick then the case X->0 returns a one on the rose */


module tb;
 
 
 reg a = 1;
 
 reg clk = 0;
 
 
 always #5 clk = ~clk;
 
 
 initial begin
 
 for (int i = 0; i < 10; i++)
 
 begin
 
 a = $urandom_range(0,1);
 
 #10;
 
 end
 
 end
 
 
 
 always@(posedge clk)
 
 begin
 
 $info("Value of a :%0b and $fell(a) : %0b", $sampled(a), $fell(a));
 
 end 
 
 
 
 
 
 initial begin
 
 $dumpfile("dump.vcd"); 
 
 $dumpvars;
 
 #120;
 
 $finish();
 
 end
 
 
 
endmodule
