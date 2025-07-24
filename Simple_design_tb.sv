// CONDITION : Signal A and Signal B cannot be high at the same instant of time .

module simple_design_tb ;
  //testbench signals
  logic clk;
  logic  a;
  logic  b;
  
  //instantitation
  simple_design uut (.clk(clk), .a(a), .b(b));
  
  // clocking block
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // assertion
  always@(posedge clk) begin 
  if ( a & b )
    begin
      $display("ERROR : Mutually asserted check failed at time : 0t ", $time);
    end
  end
  
  //stimulus
  initial begin
    #100;
    $finish;
  end
    
    //monitor block
   initial begin 
      $monitor ( " TIME : %0t ---- a = %b ----- b = %b", $time , a,b);
    end
  
  
endmodule
