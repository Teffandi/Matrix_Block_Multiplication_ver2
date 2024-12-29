//this is a testbench for testing mux for handling input 

`include "mux_4_1.v"
module mux_auto_sel_tb;

reg clock;

reg [15:0] input_1,input_2,input_3,input_4;
reg reset;
reg [1:0] select;
wire [15:0] out;

 mux_4_1 mux_0 (
    
   .input_1(input_1), 
   .input_2(input_2),
   .input_3(input_3),
   .input_4(input_4),
   .reset(reset),
   .clock(clock),
   .out(out)
);



initial begin
	repeat(10)
		#5 clock <= ~clock;
end


initial begin
reset <= 1;
clock <= 0;
#1
input_1 <= 16'h0300;
input_2 <= 16'h0200;
input_3 <= 16'h0100;
input_4 <= 16'h0000;
reset <= 0;
#10
input_1 <= 16'h0300;
input_2 <= 16'h0200;
input_3 <= 16'h0100;
input_4 <= 16'h0000;
reset <= 0;
#40
input_1 <= 16'h0300;
input_2 <= 16'h0200;
input_3 <= 16'h0100;
input_4 <= 16'h0000;
reset <= 1;
#10;

end

initial begin
	$dumpfile("wave_mux_2.vcd");
	$dumpvars(0, mux_auto_sel_tb);
end


endmodule
