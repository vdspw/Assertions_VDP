/* Demo of simulatoin glitches in Assertions */
/* Summary : Immediate assertions are going to consider the values and priorities  based on which variable is assigned first.
considers some value before actual checking starts.

the soultion to this by using Observed immidiate assertions or Final immediate deffered assertions. */

module tb;
  
  reg am = 0;
  reg bm = 0;
  
  wire a, b;
  
  assign a =am;
  assign b =bm;
  
  initial begin
    am = 1;
    bm = 1;
    #10;
    am = 0;
    bm = 1;
    #10;
    am = 1;
    bm = 0;
    #10;
    
  end
  
  always_comb 
    begin
     // A1 : assert(a==b) $info(" A and B are equal at %0t",$time);//ERROR casuing immediate assertion
      A1 : assert final(a==b) $info(" A and B are equal at %0t",$time);
    end
  
endmodule
