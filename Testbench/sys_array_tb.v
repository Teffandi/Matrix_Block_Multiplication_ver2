/*

MIT License

Copyright (c) 2020 Debtanu Mukherjee

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

`include "systolic_array.v"
module sys_array_tb;

reg rst, clk;

reg [15:0] inp_west0, inp_west1, inp_west2, inp_west3, inp_north0, inp_north1, inp_north2, inp_north3;
wire done;

systolic_array uut(inp_west0, inp_west1, inp_west2, inp_west3,
		      inp_north0, inp_north1, inp_north2, inp_north3,
		      clk, rst, done);


initial begin
	#3  inp_west0 <= 16'h0300;
	    inp_north0 <= 16'h0100;
	#10 inp_west0 <= 16'h0200;
	    inp_north0 <= 16'h0800;
	#10 inp_west0 <= 16'h0100;
	    inp_north0 <= 16'h0400;
	#10 inp_west0 <= 16'h0000;
	    inp_north0 <= 16'h0000;
	#10 inp_west0 <= 16'h0000;
	    inp_north0 <= 16'h0000;
	#10 inp_west0 <= 16'h0000;
	    inp_north0 <= 16'h0000;
	#10 inp_west0 <= 16'h0000;	
	    inp_north0 <= 16'h0000;
end

initial begin
	#3  inp_west1 <= 16'h0000;
	    inp_north1 <= 16'h0000;
	#10 inp_west1 <= 16'h0700;
	    inp_north1 <= 16'h0100;
	#10 inp_west1 <= 16'h0600;
	    inp_north1 <= 16'h0900;
	#10 inp_west1 <= 16'h0500;
	    inp_north1 <= 16'h0500;
	#10 inp_west1 <= 16'h0400;
	    inp_north1 <= 16'h0100;
	#10 inp_west1 <= 16'h0000;
	    inp_north1 <= 16'h0000;
	#10 inp_west1 <= 16'h0000;	
	    inp_north1 <= 16'h0000;
end

initial begin
	#3  inp_west2 <= 16'h0000;
	    inp_north2 <= 16'h0000;
	#10 inp_west2 <= 16'h0000;
	    inp_north2 <= 16'h0000;
	#10 inp_west2 <= 16'h0100;
	    inp_north2 <= 16'h0400;
	#10 inp_west2 <= 16'h0100;
	    inp_north2 <= 16'h0100;
	#10 inp_west2 <= 16'h0900;
	    inp_north2 <= 16'h0600;
	#10 inp_west2 <= 16'h0800;
	    inp_north2 <= 16'h0200;
	#10 inp_west2 <= 16'h0000;	
	    inp_north2 <= 16'h0000;
end

initial begin
	#3  inp_west3 <= 16'h0000;
	    inp_north3 <= 16'h0000;
	#10 inp_west3 <= 16'h0000;
	    inp_north3 <= 16'h0000;
	#10 inp_west3 <= 16'h0000;
	    inp_north3 <= 16'h0000;
	#10 inp_west3 <= 16'h0500;
	    inp_north3 <= 16'h0500;
	#10 inp_west3 <= 16'h0400;
	    inp_north3 <= 16'h0100;
	#10 inp_west3 <= 16'h0300;
	    inp_north3 <= 16'h0700;
	#10 inp_west3 <= 16'h0200;	
	    inp_north3 <= 16'h0300;
end

initial begin
rst <= 1;
clk <= 0;
#3
rst <= 0;
end

initial begin
	repeat(21)
		#5 clk <= ~clk;
end




initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0, sys_array_tb);
end



endmodule
