/* Assertion in a D flip-flop -- here the assertion is written in a sequential block */
/* the structure of the D -f/f 

          +-------+
    D ----|       |---- Q
rstn   ----|  DFF  |
   clk ---|       |---- Q_bar
          +-------+      
          
          */

module dff (
    input logic d,
    input logic clk,
    input logic rstn,
    output logic q,
    output logic q_bar
);


reg temp_q;
reg temp_q_bar;

    // RTL logic
always@(posedge clk)begin
    if(!rstn)begin
        temp_q <= 1'b0;
        temp_q_bar <= 1'b1;
    end 
    else begin
        temp_q <= d;
        temp_q_bar <= ~d;
    end

end

// SVA Assertions
// Adding the assertions in the sequential block
  always@(posedge clk)begin
  A1: assert (temp_q_bar == ~temp_q) $info ("SUCCES at time %0t",$time); else 
        $error("Assertion Failed: Q_bar is not complement of Q at time %0t", $time);

end

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
module tb();
  
 reg d =0;
  reg clk =0;
  reg rstn = 0;
  wire q, q_bar;
  
  dff dut(d,rstn,clk,q,qbar);
  
  always #5 clk = ~clk;
  
  always #13 d = ~d;
  
  initial begin
    rstn = 0;
    #30;
    rstn =1;
  end
  
  initial begin
    #200;
    $finish();
  end
  
endmodule
