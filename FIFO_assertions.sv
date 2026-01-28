// FIFO design and assertions //
/* features of the FIFO :

contains a read pointer, write pointer , din (input) , dout (output) ,
empty and full flags as indicators */

module FIFO(input clk, rst, wr, rd, 
            input [7:0] din,output reg [7:0] dout,
            output reg empty, full);
  
  reg [3:0] wptr = 0,rptr = 0,cnt = 0;
  reg [7:0] mem [15:0];
  
  always@(posedge clk)
    begin
      if(rst== 1'b1)
         begin
           cnt <= 0;
           wptr <= 0;
           rptr <= 0;
         end
      else if(wr && !full)
          begin
            if(cnt < 15) begin
            mem[wptr] <= din;
            wptr <= wptr + 1;
            cnt <= cnt + 1;
            end
          end
      else if (rd && !empty)
        begin
          if(cnt > 0) begin
          dout <= mem[rptr];
          rptr <= rptr + 1;
          cnt <= cnt - 1;
          end
        end 
      
      if(wptr == 15)
         wptr <= 0;
      if(rptr == 15)
         rptr <= 0;
    end
  
  assign empty = (cnt == 0) ? 1'b1 : 1'b0;
  assign full = (cnt == 15) ? 1'b1 : 1'b0;
  
endmodule

/* testbench */

module assert_fifo (input clk, rst, wr, rd, 
                    input [7:0] din,input [7:0] dout,
            input empty, full);
  
  
  // (1) status of full and empty when rst asserted
  
  ////check on edge
  
 RST_1: assert property (@(posedge clk) $rose(rst) |-> (full == 1'b0 && empty == 1'b1))$info("A1 Suc at %0t",$time);
   
  /////check on level
   
 RST_2: assert property (@(posedge clk) rst |-> (full == 1'b0 && empty == 1'b1))$info("A2 Suc at %0t",$time);  
 
  
   //  (2) operation of full and empty flag
     
   FULL_1: assert property (@(posedge clk) disable iff(rst) $rose(full) |=> (FIFO.wptr == 0)[*1:$] ##1 !full)$info("full Suc at %0t",$time); 
   
   FULL_2 : assert property (@(posedge clk) disable iff(rst) (FIFO.cnt == 15) |-> full)$info("full Suc at %0t",$time);
     
       
   EMPTY_1:  assert property (@(posedge clk) disable iff(rst) $rose(empty) |=> (FIFO.rptr == 0)[*1:$] ##1 !empty)$info("full Suc at %0t",$time); 
       
  
  EMPTY_2: assert property (@(posedge clk) disable iff(rst) (FIFO.cnt == 0) |-> empty)$info("empty Suc at %0t",$time); 
     
       
       
   ///////  (3) read while empty
  
    READ_EMPTY: assert property (@(posedge clk) disable iff(rst) empty |-> !rd)$info("Suc at %0t",$time);  
 
      ////////// (4) Write while FULL
     
    WRITE_FULL: assert property (@(posedge clk) disable iff(rst) full |-> !wr)$info("Suc at %0t",$time);
  
      
      ////////////// (5) Write+Read pointer behavior with rd and wr signal
 
      
      //////if wr high and full is low, wptr must incr
       
  WPTR1: assert property (@(posedge clk)  !rst && wr && !full |=> $changed(FIFO.wptr));
         
    //////// if wr is low, wptr must constant
  WPTR2: assert property (@(posedge clk) !rst && !wr |=> $stable(FIFO.wptr));
    
    /////// if rd is high, wptr must stay constant
  WPTR3: assert property (@(posedge clk)  !rst && rd |=> $stable(FIFO.wptr)) ;
         
   
  RPTR1: assert property (@(posedge clk)  !rst && rd && !empty |=> $changed(FIFO.rptr));
         
  RPTR2: assert property (@(posedge clk) !rst && !rd |=> $stable(FIFO.rptr));
    
  RPTR3: assert property (@(posedge clk)  !rst && wr |=> $stable(FIFO.rptr));
 
  
      
    
    //////////  (6) state of all the i/o ports for all clock edge
  
  
  
 
 
  always@(posedge clk)
    begin
      assert (!$isunknown(dout));
      assert (!$isunknown(rst));
      assert (!$isunknown(wr));
      assert (!$isunknown(rd));
      assert (!$isunknown(din));
    end
 
 
 
    //////////////////// (7) Data must match
    
  property p1;
    integer waddr;
    logic [7:0] data;
 
    (wr, waddr = tb.i, data = din) |-> ##[1:30] rd ##0 (waddr == tb.i - 1, $display("din: %0d dout :%0d",data, dout));
  endproperty
  
  assert property (@(posedge clk) disable iff(rst) p1) $info("Suc at %0t",$time);
 
endmodule
