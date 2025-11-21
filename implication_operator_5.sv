/*Write assertion to verify following behavior "read and write request must not occur at same time"*/

module tb;

  reg clk = 0;
  reg rd = 0;
  reg wr = 0;

  always #5 clk = ~clk;

  initial begin
    #10;
    rd = 1;  // read request
    #10;
    rd = 0;
    wr = 1;  // write request
    #10;
    rd = 1;
    wr = 1;  // both at same time - should FAIL
    #10;
    rd = 0;
    wr = 0;
    #10;
  end

  // Assertion: read and write must not occur at same time
 A1 : assert property (@(posedge clk) rd |-> !wr) 
     $info("SUCCESS at %0t", $time); 
     else $error("FAILURE at %0t", $time);
   
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars;
    #60;
    $finish();
  end

endmodule
