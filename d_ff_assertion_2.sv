/* Dout - should be 0 when rst is HIGH , if rst is LOW dout should be same as din */

module dff
(
input din, clk, rst,
output reg dout  
);
  
  always@(posedge clk)
    begin
      if(rst)
        dout <= 1'b0;
      else
        dout <= din;
    end
  
  //SVA
  always@(posedge clk)begin
    A1: assert((rst == 1 && dout == 0)||(rst == 0 && din == dout)) $info("SUCCESS at time %0t",$time); 
    else $error("FAILURE at time %0t",$time);
  end
endmodule
