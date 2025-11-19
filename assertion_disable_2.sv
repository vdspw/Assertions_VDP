/* Simple immediate assertion doesnt support the disable feature */
/* Observed Deffered immdeate assertion and final deffered immediate assertion supports disable 
feature */


/* the assertion should be diabled whener rst is high */
module tb;
  
  reg a;
  reg rst; // since no initialziation its unknow in the start of sim-- X
  
  initial begin
    rst  = 1;
    #50;
    rst = 0;
  end
  
  initial begin
    a = 0;
    #50;
    a = 1;
  end
  
  //simple immidiate assertion works only after 50 time units as rst is high for the first 50 units.
/*  always@(*)
	begin
      if(rst == 1'b0)begin
        A1: assert(a==1) $info("Success at %0t", $time);else
          $error("Failure at %0t",$time);
      end
      
    end 
    */
  
  /* final deffered immediate assertion */
  always@(*)
    begin
      A1:assert final (a==1) $info("Success at %0t",$time); else $error("Failure at %0t",$time);
      if(rst == 1'b1)
        disable A1;
    end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
	#100;
	$finish;
  end
endmodule
