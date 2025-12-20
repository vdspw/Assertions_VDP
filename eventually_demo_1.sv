/* eventually illustration */
/* checking if the RESET de asserts after a positive edge of the clk , within 2 to 3 clk's */

module tb;
  
    
  reg clk = 0, rst = 1,  ce = 0;
  always #5 clk = ~clk;
  
  
  initial begin
    #20;
    rst = 1;
  #40;
    rst = 1;
    ce = 1;
    #50;
    rst = 1;
    #10;
    ce = 0;
    
    
  end
  
  
  
  
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    $assertvacuousoff(0);
    #120;
    $finish();
  end 
 
 
  
  initial A4: assert property (@(posedge clk) eventually [2:3] !rst) $info("Suc at %0t",$time);
    
endmodule
