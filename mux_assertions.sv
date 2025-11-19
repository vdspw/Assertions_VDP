/* ---- 4:1 MUX with Assertions ---- */
/* 
        +--------------+
    A --|              |
    B --|              |    
    C --|   4:1 MUX    |--- Y
    D --|              |
   S1 --|              |
   S0 --|              |
        +--------------+       */
/* The immediate assertions are written in a combinational block (proceduaral block) */

module mux (
    input logic a,
    input logic b,
    input logic c,
    input logic d,
    input logic [1:0] sel,
    output logic y
);

// RTL logic
always@(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        2'b11: y = d;
        default: y = 1'bx;
    endcase
end

// SVA Assertions
// Adding the assertions in the combinational block

always@(*)
begin
    case(sel)
    2'b00: y_equal_to_a : assert(y==a)else $error("Assertion Failed: y is not equal to a when sel=00 at time %0t", $time);
    2'b01: y_equal_to_b : assert(y==b)else $error("Assertion Failed: y is not equal to b when sel=01 at time %0t", $time);
    2'b10: y_equal_to_c : assert(y==c)else $error("Assertion Failed: y is not equal to c when sel=10 at time %0t", $time);
    2'b11: y_equal_to_d : assert(y==d)else $error("Assertion Failed: y is not equal to d when sel=11 at time %0t", $time);

    endcase
end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

module tb();
  
  reg a = 0,b=0,c=0,d=0;
  
  reg[1:0] sel;
  wire y;
  
  mux dut(a,b,c,d,sel,y);
  
  always #5 a = ~a;
  always #10 b = ~b;
  always #15 c = ~c;
  always #20 d = ~d;
  
  initial begin
    sel = 2'b00;
    #50;
    sel = 2'b01;
    #50;
    sel = 2'b10;
    #50;
    sel = 2'b11;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #300;
    $finish;
  end
  
  
endmodule
