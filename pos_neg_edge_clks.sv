/* checking the conditions on different clk edges */
/* checking instnaces where reset and enalbe both are HIGH */

module tb;
 
reg rst = 0, en = 1;
reg clk = 0;
 
always #5 clk = ~clk;
 
 
initial begin
rst = 1;
#7;
rst = 0;
#5;
rst = 1;
end
 
 
 
/* checks on the positive edge clk */
CHECK_POSEDGE: assert property (@(posedge clk) en |-> rst) $info("POSEDGE SUC @ %0t",$time); else $error("POSEDGE Fail @ %0t", $time);
 
/* checks on th negative edge */
CHECK_NEGEDGE: assert property (@(negedge clk) en |-> rst) $info("NEGEDGE SUC @ %0t",$time); else $error("NEGEDGE Fail @ %0t", $time);

/* checks on both edges */
CHECK_BOTHEDGE: assert property (@(edge clk) en |-> rst) $info("EDGE SUC @ %0t",$time); else $error("EDGE Fail @ %0t", $time);
 
 
initial begin
$dumpfile("dump.vcd");
$dumpvars;
#20;
$finish();
end
 
 
 
 
endmodule
