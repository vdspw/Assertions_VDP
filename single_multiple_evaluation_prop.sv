/*Single or multiple evaluation property */
/* A should be high at a posedge clk anytime in the simulation */

module tb;
  
  reg clk = 0;
  
  reg temp = 0;
  reg a = 0;
  
  initial begin
    temp = 1; // when the simulation starts temp will have the value 1
    @(posedge clk); // after the first clk edge temp goes to 0.
    temp = 0;
  end
  
  always #10 clk = ~clk;
  always #40 a = ~a;
  
  
  // the multiple evaluation -- the conditin a == 1 is evaluated at every clk edge.
 A1: assert property (@(posedge clk) (a == 1'b1) ) $info("A1 Suc @ %0t", $time); else  $error("A1 fail @ %0t",$time);
  
 // the single evaluation -- the condition a==1 is evaluated at the first clk pulse.   
 initial A2 : assert property (@(posedge clk) (a == 1'b1) ) $info("A2 Suc @ %0t", $time); else  $error("A2 Fail @ %0t",$time);  
  
   
 A3: assert property (@(posedge clk) $rose(temp) |-> (a == 1'b1) ) $info("A3 Suc @ %0t", $time); else  $error("A3 Fail @ %0t",$time);  
  
     
  initial 
  begin
       repeat(10) @(posedge clk);
       $finish;
  end
  
        
    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $assertvacuousoff(0);
    #100;
    $finish;
  end
  
  
endmodule
