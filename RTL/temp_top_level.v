`include "control_mux.v"
`include "mux_4_1.v"
`include "systolic_array.v"
`include "adder_buffer.v"


module temp_top_level(

input [255:0] input_1,
input [255:0] input_2,
input clock,
input reset,
input reset_accum,
output [255:0] out,
output done_systolic,
output done_accum
);


wire [15:0] temp_inp_west0;
wire [15:0] temp_inp_west4;
wire [15:0] temp_inp_west8;
wire [15:0] temp_inp_west12;
wire [15:0] temp_inp_north0;
wire [15:0] temp_inp_north1;
wire [15:0] temp_inp_north2;
wire [15:0] temp_inp_north3;


wire [3:0] mux_control_west;
wire [3:0] mux_control_north;

wire [255:0] out_systolic;

control_mux control_mux_west(
.clock(clock),
.reset(reset),
.mux_reset(mux_control_west)
);

control_mux control_mux_north(
.clock(clock),
.reset(reset),
.mux_reset(mux_control_north)
);


mux_4_1 mux_0_W (

   .input_1(input_1[255-16*3:255-16*3-15]), 
   .input_2(input_1[255-16*2:255-16*2-15]),
   .input_3(input_1[255-16*1:255-16*1-15]),
   .input_4(input_1[255:240]),
   .reset(mux_control_west[3]),
   .clock(clock),
   .out(temp_inp_west0)
);

mux_4_1 mux_1_W (

   .input_1(input_1[255-16*7:255-16*7-15]), 
   .input_2(input_1[255-16*6:255-16*6-15]),
   .input_3(input_1[255-16*5:255-16*5-15]),
   .input_4(input_1[255-16*4:255-16*4-15]),
   .reset(mux_control_west[2]),
   .clock(clock),
   .out(temp_inp_west4)
);

mux_4_1 mux_2_W (

   .input_1(input_1[255-16*11:255-16*11-15]), 
   .input_2(input_1[255-16*10:255-16*10-15]),
   .input_3(input_1[255-16*9:255-16*9-15]),
   .input_4(input_1[255-16*8:255-16*8-15]),
   .reset(mux_control_west[1]),
   .clock(clock),
   .out(temp_inp_west8)
);

mux_4_1 mux_3_W (

   .input_1(input_1[255-16*15:255-16*15-15]), 
   .input_2(input_1[255-16*14:255-16*14-15]),
   .input_3(input_1[255-16*13:255-16*13-15]),
   .input_4(input_1[255-16*12:255-16*12-15]),
   .reset(mux_control_west[0]),
   .clock(clock),
   .out(temp_inp_west12)
);


mux_4_1 mux_0_N (

   .input_1(input_2[255-16*3:255-16*3-15]), 
   .input_2(input_2[255-16*2:255-16*2-15]),
   .input_3(input_2[255-16*1:255-16*1-15]),
   .input_4(input_2[255:240]),
   .reset(mux_control_north[3]),
   .clock(clock),
   .out(temp_inp_north0)
);

mux_4_1 mux_1_N (

   .input_1(input_2[255-16*7:255-16*7-15]), 
   .input_2(input_2[255-16*6:255-16*6-15]),
   .input_3(input_2[255-16*5:255-16*5-15]),
   .input_4(input_2[255-16*4:255-16*4-15]),
   .reset(mux_control_north[2]),
   .clock(clock),
   .out(temp_inp_north1)
);

mux_4_1 mux_2_N (

   .input_1(input_2[255-16*11:255-16*11-15]), 
   .input_2(input_2[255-16*10:255-16*10-15]),
   .input_3(input_2[255-16*9:255-16*9-15]),
   .input_4(input_2[255-16*8:255-16*8-15]),
   .reset(mux_control_north[1]),
   .clock(clock),
   .out(temp_inp_north2)
);

mux_4_1 mux_3_N (

   .input_1(input_2[255-16*15:255-16*15-15]), 
   .input_2(input_2[255-16*14:255-16*14-15]),
   .input_3(input_2[255-16*13:255-16*13-15]),
   .input_4(input_2[255-16*12:255-16*12-15]),
   .reset(mux_control_north[0]),
   .clock(clock),
   .out(temp_inp_north3)
);



systolic_array sys_0 (
.inp_west0(temp_inp_west0), 
.inp_west4(temp_inp_west4), 
.inp_west8(temp_inp_west8), 
.inp_west12(temp_inp_west12),	      
.inp_north0(temp_inp_north0), 
.inp_north1(temp_inp_north1), 
.inp_north2(temp_inp_north2), 
.inp_north3(temp_inp_north3),
.clk(clock), 
.rst(reset),
.out(out_systolic), 
.done(done_systolic)
);
	
adder_buffer adder_buff_0(

.input_1(out_systolic),
.reset(reset_accum),
.clock(clock),
.systolic_done(done_systolic),
.accumulator_done(done_accum),
.out(out)

);

endmodule

