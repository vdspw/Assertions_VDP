/* if signal a asserts, then signal c should assert within 1 to 5 clock cycles, followed by signal b becoming high. signal ce should remain high for entire duration of this sequence. */

module tb;
  reg a = 0, b = 0, c = 0, ce = 0;
  reg clk = 0;

  always #5 clk = ~clk;

  initial begin
    #20 a = 1;
    #10 a = 0;
  end

  initial begin
    #49 b = 1;
    #10 b = 0;
  end

  initial begin
    #40 c = 1;
    #10 c = 0;
  end

  initial begin
    #15 ce = 1;
    #60 ce = 0;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $assertvacuousoff(0);
    #100 $finish();
  end

  // Named sequences
  sequence trigger_a;
    @(posedge clk) $rose(a);
  endsequence

  sequence c_b;
    ##[1:5] $rose(c) ##1 $rose(b);  
  endsequence

  // Assertion 1: Timing requirement
  assert property (
    @(posedge clk) 
    trigger_a |-> c_b
  ) $info("PASS: Timing assertion succeeded at %0t", $time);
  else $error("FAIL: Timing violation at %0t", $time);

  // Assertion 2: ce must stay high throughout the entire sequence
  assert property (
    @(posedge clk) 
    trigger_a |-> (ce == 1'b1) throughout c_b
  ) $info("PASS: ce stable high throughout sequence at %0t", $time);
  else $error("FAIL: ce went low during sequence at %0t", $time);

endmodule

/* better way --- 
sequence seq1;
($rose(a) |-> ##[1:5] c ##1 b);
endsequence

assert property(@(posedge clk) $rose(ce) |-> seq1 within ce);
