/* If b deassert then a must also deassert in the next clock tick. Evaluate the property on positive edge of the clock. */

module tb;
  reg a = 0, b = 1;
  reg clk = 0;
  
  always #5 clk = ~clk;
  
  //always #2 en = ~en;
  
  initial begin
    a = 1;
    #7;
    a = 0;
    #30;
    a = 1; 
    #30;
    a = 1;
  end
  
    initial begin
    b = 1;
    #7;
    b = 0;
    #10;
    b = 1; 
    #30;
    b = 1;
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    $assertvacuousoff(0);
    #100;
    $finish();
  end
 
///Add your code here
  A1:assert property(@(posedge clk) !a |=> !b) $info("SUCCESS at %0t",$time);else
    $error("FAILURE at %0t",$time);
                              
endmodule
