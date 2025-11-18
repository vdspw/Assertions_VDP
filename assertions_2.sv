/*--- System verilog assertions ---*/
/* wrtie an assertion to verify this behaviour of the signals

    clk ___/  \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/
    start _________________/ \_________________________________

    the start bit should go high within 20 clk pulese */

module tb;

    reg clk = 0;
    reg start = 0;
    integer i;
    integer count = 0;

    //for the start bit generation
    initial begin
        #80;
        start = 0;
        #10;
        start = 1;
    end
    
    //clock generation
    always #5 clk = ~clk;

    //counting the clock pulses
    task check();
        for(i=0;i<20;i++)begin
            @(posedge clk);
            if(start == 1'b1)
                count++;
            end
        
    endtask

    //Assertion in verilog
    initial begin
        check();
        if(count > 0) begin
            $display("VERILOG ASSERTION PASSED AT%0t", $time);
        end else begin
            $error("VERILOG ASSERTION FAILED AT  %0t", $time);
        end
    end

    //Assertion in SVA
    initial assert property ( @(posedge clk) s_eventually start) 
        $info("SVA ASSERTION PASSED AT %0t", $time);
       
    
    initial begin
        $dumpfile("assertion_2.vcd");
        $dumpvars();
        $assertvacuousoff(0) ;
        #200;
        $finish;
    end

endmodule
