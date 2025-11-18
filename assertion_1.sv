/* System verilog assertions */
/* write an assertion to verify this behaviour of the signals

    clk --/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/
    a  ---/ \-----------------------------------------------------
    b  -----------------------/  \--------------------------------

    the signal A goes high on the first clk tick .
    the signal b should go high after 4 clk ticks after a goes high.. */

`timescale 1ns/1ps
module tb;

    reg clk= 0;
    reg a =0;
    reg b =0;

    task a_b();  //task to run the sequence
        #10;
        a =1;
        #10;
        a =0;
        #30;
        b =1;
        #10;
        b =0;
        #50;
        a =1;
        #10;
        a =0;
        #30;
        b =1;
        #10;
        b =0;
    endtask

    always #5 clk = ~clk; //clock generation

    initial begin
        a_b(); //call the task
    end

    /// implementation of the verilog
    always@(posedge clk) begin
        if(a == 1'b1) begin
            repeat(4) @(posedge clk);
            if(b == 1'b1)begin
              $display("VERILOG ASSERTION PASSED %0t", $time);
            end else begin
              $error("VERILOG ASSERTION FAILED at %0t", $time);
            end
    end
    end

    // implementation of the SVA
  A1 : assert property( @(posedge clk) a |-> ##4 b) $info("SVA ASSETION PASSED %0t", $time);
    else $error("SVA ASSERTION FAILED at %0t", $time);
        
    

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $assertvacuousoff(0);
    #200;
    $finish;
end
endmodule
