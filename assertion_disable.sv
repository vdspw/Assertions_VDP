/* Assertion disable */

module tb;
  
  reg a ; // not initialized --carries unknown value"X".
  
  initial begin
    $assertoff();
    a = 0;
    #50;
    $asserton();
    a = 1;
    
  end
  
  always@(*)
    begin
      A1:assert(a==1) $info("SUCCESS at %ot", $time);else $error("FIALURE at %0t",$time);
    end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #100;
    $finish;
  end
  
endmodule
