/* If a assert then a must remain true until en remains true. */

module tb;
  reg a = 0, b = 0,en = 0;
  reg clk = 0;
  
  always #5 clk = ~clk;
 
  
  initial begin
    en = 1;
    a = 1;
    #20;
    a = 0;
    b = 1;
    #30;
    b = 0;
    en = 0;
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    $assertvacuousoff(0);
    #100;
    $finish();
  end
 
  /// Add your code here
  assert property (@(posedge clk) $rose(a)|-> (a[*1:$] ##1 !a)intersect(en[*1:$] ##1 !en)) $info("PASS @ %0t",$time);
    
endmodule

    /* eralier solution: $rose(a) |-> a unitl en ); */
