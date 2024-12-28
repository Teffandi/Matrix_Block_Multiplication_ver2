//this is a testbench for testing mux for handling input 

`include "mux_4_1.v"
module mux_tb;

reg rst, clk;

reg [15:0] input_1,input_2,input_3,input_4;
reg reset;
reg [1:0] select;
wire [15:0] out;

mux_4_1 mux_4_1 (
    
    .input_1(input_1), 
    .input_2(input_2),
    .input_3(input_3),
    .input_4(input_4),
    .reset(reset),
    .select(select),
    .out(out)
);

initial begin

input_1 <= 16'h0300;
input_2 <= 16'h0200;
input_3 <= 16'h0100;
input_4 <= 16'h0000;
select <= 2'd0;
reset <= 0;
#10
input_1 <= 16'h0300;
input_2 <= 16'h0200;
input_3 <= 16'h0100;
input_4 <= 16'h0000;
select <= 2'd1;
reset <= 0;
#10
input_1 <= 16'h0300;
input_2 <= 16'h0200;
input_3 <= 16'h0100;
input_4 <= 16'h0000;
select <= 2'd1;
reset <= 1;
#10;


end

initial begin
	$dumpfile("wave_mux.vcd");
	$dumpvars(0, mux_tb);
end


endmodule
