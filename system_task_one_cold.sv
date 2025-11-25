/* system task onecold -> returns 1 when the multibit signal includes only one 0 */

module tb;
 reg [3:0] a = 4'b0000;
 reg clk = 0;
 
 always #5 clk = ~clk;
 
 
 
 //////////////onecold 
 initial begin
 for(int i = 0; i< 20 ; i++) begin
 a = $urandom_range(0,15);
 $display("a:%4b $onecold:%0d @ %0t",a,$onehot(~a),$time);
 $display("-----------------------------");
 @(negedge clk);
 end
 end
 
 
 
 initial begin
 $dumpfile("dump.vcd"); 
 $dumpvars;
 #120;
 $finish();
 end
 
 
endmodule
