/* Assertion 3: write an assertion to verify this behaviour of the signals

    clk ___/  \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/
    rst____/-------------\_________________________________________

    the clk signal gives 20 pulses , the reset must go high for first 3 clk pulses and must 
    go low for the remaining clk pulses */

module tb;

    reg clk =0;
    reg rst =0;

    //counter to couunt the reset high
    integer reset_counter;
    integer count;// counter to count the reset low (no.of clk pulses)

    //generation of clock
    always #5 clk = ~clk;

    //impulses generation for rst
    initial begin
        rst =1;
        #30;
        rst =0;
    end

    //task to count the rst high 
    task reset_high();
        @(posedge clk);
        for(int j=0;j<3;j++) begin
            if(rst == 1'b1) begin
                reset_counter++;
            end
            @(posedge clk);
        end

        for(int i=0;i<16;i++) begin
            if(rst == 1'b0) begin
                count++;
            end
            @(posedge clk);
        end
    endtask

    //checker
    task check();
        if(count == 0 && reset_counter == 3) begin
            $display("VERILOG ASSERTION PASSED AT %0t", $time);
        end else begin
            $error("VERILOG ASSERTION FAILED AT %0t", $time);
        end
    endtask
  
  //SVA implementation
  initial assert property ( @(posedge clk) rst[*3] ##1 !rst[*17]) 
        $info("SVA ASSERTION PASSED AT %0t", $time);
  
  	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
      $assertvacuousoff(0); 
      #200;
      $finish;
    end

endmodule
