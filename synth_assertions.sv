/* For Assertions & design to be synthesized correctly the logic and Assertions must be in 
seperate always block */

module synth(
  input a, b, sel,
  output reg y );
  
//behaviour check 
  
always_comb
begin
  if(sel == 1'b1)
    assert(y==a)else $error("Y is not equal to A");
  else
    assert(y==b)else $error("Y is not equal to B");
end
 
//actual RTL
  always_comb
    begin
      if(sel == 1'b1)
        y = a;
      else
        y = b;
    end
endmodule
