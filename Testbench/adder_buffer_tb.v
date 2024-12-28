`include "adder_buffer.v"

module adder_buffer_tb;

reg [255:0] test_input;
reg reset;
reg clock;
reg systolic_done;
wire accumulator_done;
wire [255:0] out;

adder_buffer add_0(

.input_1(test_input),
.reset(reset),
.clock(clock),
.systolic_done(systolic_done),
.accumulator_done(accumulator_done),
.out(out)
);

initial begin
reset <= 1;
systolic_done <= 0;
#3
reset <= 0;
test_input <= 'h000400E800C9008D00F400D10017000C00EA001300EB00BD010000FA00DD0060;
#8
test_input <= 'h000400E800C9008D00F400D10017000C00EA001300EB00BD010000FA00DD0060;
#13
test_input <= 'h0000000000000000000000000000000000000000000000000000000000000000;


end

initial begin
	repeat(133)
		#5 systolic_done <= ~systolic_done;
end


initial begin
	$dumpfile("wave_adder_buffer.vcd");
	$dumpvars(0, adder_buffer_tb);
end





endmodule