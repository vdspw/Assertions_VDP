/* Checking the design intent for 4 bit AND gate using SVA Assertions */
/*

        +-------+     
    A0 --|       ||--- Y0
    B0 --|       |    
        +-------+     
*/

module and2
 
(
 
input [3:0] a,b,
 
output [3:0] y
 
);
 
assign y = a && b;
 
 
 
///////////Add your code here
always@(*) begin

  assert (y == a & b) $info("ASSERTION PASSED: y is the AND of a and b at time %0t", $time); else 
    $error("ASSERTION FAILED: y is not the AND of a and b at time %0t", $time);

end
 
 
 
 
 
 
/////////End your code here
 
 
 
endmodule
