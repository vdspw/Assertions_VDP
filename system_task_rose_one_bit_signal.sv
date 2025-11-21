/* System tasks -- Sampled */
/* The system task Sampled is used to access the value of a variable in a preponed region.

In case of Concurrent assertions we need not use this task as the varaible is already evaulated
in the preponed regions. */

/* System task --- rose */
/* this detects the rising edge of the signal -- returns one on [ 0-> 1] or [X -> 1] transitions*/
/* usually requires 2 ticks to prove the transtion 0 -> 1 if in case of a signle clk tick then the case X->1 returns a one on the rose */

module tb;
 
 reg a = 1;
 reg clk = 0;
 
 
 always #5 clk = ~clk;
 
 
 initial begin
 a = 1;
 #10;
 a = 0;
 #20;
 a = 1;
 #20;
 a = 0;
 end
 
 always@(posedge clk)
 begin
 $info("Value of a :%0b and $rose(a) : %0b", $sampled(a), $rose(a));
 end 
 
 
 initial begin
 $dumpfile("dump.vcd"); 
 $dumpvars;
 #120;
 $finish();
 end
 
 
endmodule
