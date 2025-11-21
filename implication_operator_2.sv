/* Whenever a assert and b deassert then c must hold true in the next clock tick. Evaluate the property on positive edge of the clock. */

module tb;
  reg a = 0, b = 1, c = 0;
  reg clk = 0;
  
  always #5 clk = ~clk;
  
  //always #2 en = ~en;
  
  initial begin
    a = 1;
    #10;
    a = 0;
    #10;
    a = 1; 
    #10;
    a = 0;
    #10;
    a = 1;
  end
  
  initial begin
    b = 0;
    #10;
    b = 1;
    #10;
    b = 0; 
    #10;
    b = 1;
    #10;
    a = 0;
  end
  
    initial begin
    c = 0;
    #13;
    c = 1;
    #10;
    c = 0; 
    #11;
    c = 1;
    #10;
    c = 0;
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    $assertvacuousoff(0);
    #100;
    $finish();
  end
///add your code here
  
  A1: assert property( @(posedge clk) ( a && ~b) |=> c ) $info("SUCCESS at %0t",$time);else
    $error("FIALURE at %0t",$time);
endmodule
