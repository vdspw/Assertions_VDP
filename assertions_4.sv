/* Assertions 5  to check that RST is high for the first 2 clk pulses and low for the remaining 10 puleses.
in the 12 clk pulses the Write(wr) should be high atleast once and Read(rd) should be high atleast once. 

    clk ___/  \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/ \__/
    rst____/--------\___________________________________________
    wr  _________________________/ \_________________________
    rd  _______________________________/ \____________________
    

    */

    module tb;

    reg clk = 0;
    reg rst = 0;
    reg wr = 0;
    reg rd = 0;

    integer wr_high =0;
    integer rd_high =0;
    integer err =0;

    //clock generation
    always #5 clk = ~clk;

    default clocking
        @(posedge clk);
    endclocking

    //reset generation
    initial begin   
        rst =1;
        #20;
        rst =0; 
    end

    //write and read signal generation
    initial begin
        #50;
        wr =1;
        #10;
        wr =0;
        #30;
        rd =1;
        #10;
        rd =0;
    end

    //task to count the wr and rd high--verilog assertion
    task checkreset();
        repeat(2)@(posedge clk);
        for(int i=0;i<10;i++) begin
            @(posedge clk);
            if(rst == 1'b1)begin
                err++;
            end
        end

    
    endtask

    task hit();
        repeat(2)@(posedge clk);
        for(int j=0;j<10;j++)begin
            @(posedge clk);
            if(!rst && wr)
                wr_high++;
            if(!rst && rd)
                rd_high++;
        end

    endtask

    initial begin
        fork
            checkreset();
            hit();
        join
    

    if(err ==0 && wr_high >0 && rd_high >0) begin
        $display("VERILOG ASSERTION PASSED AT %0t", $time);
    end else begin
        $error("VERILOG ASSERTION FAILED AT %0t", $time);
    end
      
    end
      
    initial assert property (##2 !rst |-> !rst throughout ##[0:9] wr ) $info("WR Suc at %0t",$time);
    
  initial assert property (##2 !rst |-> !rst throughout ##[0:9] rd ) $info("RD Suc at %0t",$time);  

    initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    $assertvacuousoff(0); 
    #120;
    $finish;
 	 end

      
endmodule
