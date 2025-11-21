/* System tasks -- Sampled */
/* The system task Sampled is used to access the value of a variable in a preponed region.

In case of Concurrent assertions we need not use this task as the varaible is already evaulated
in the preponed regions. */

module tb;
  
  reg a = 1;
  reg clk =0;
  
  always #5 clk = ~clk;
  
  always #5 a = ~a;
  
  always @(posedge clk)
    begin
      $info("Value of a : %b and $sampled(a) : %b",a,$sampled(a));
    end
 /* when the above alwys block is excuted at the posetive edge of the clk the value of a is considered and in sampled its before that clk edge */
  
  assert property (@(posedge clk) (a == $sampled(a))) $info("SUCCESS of %0t with a : %0b",$time,$smapled(a));
    /*In case of Concurrent assertions we need not use this task as the varaible is already evaulated
in the preponed regions, hence we get a succes in the first time unit */
  
  initial begin
    $dumpfile("dump.vcd"); 
 	$dumpvars;
	 $assertvacuousoff(0);
	 #50;
 	$finish();
 	end
endmodule
