module simple_design ( clk, a,b);
  input logic clk;
  output logic  a, b;
  
  always @(posedge clk) begin
    a <= $urandom %2;
    b <= $urandom %2;
  end
  
endmodule
