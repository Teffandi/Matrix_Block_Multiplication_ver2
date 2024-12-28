//this is a testbench for testing mux for handling input 

`include "control_mux.v"
module control_mux_tb;

reg reset;
reg clock;
wire [3:0] mux_reset;

 control_mux control_0(

.clock(clock),
.reset(reset),
.mux_reset(mux_reset)
);



initial begin
	repeat(20)
		#5 clock <= ~clock;
end

initial begin
reset <= 1;
clock <= 1;
#10
reset <=0;
#50;
end



initial begin
	$dumpfile("wave_mux_control.vcd");
	$dumpvars(0, control_mux_tb);
end


endmodule
