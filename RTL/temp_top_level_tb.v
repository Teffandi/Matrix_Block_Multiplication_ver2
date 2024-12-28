
`include "temp_top_level.v"
`include "RAM_input.v"


module temp_top_level_tb;

reg reset, clock;
wire done;
wire done_systolic;
wire done_accum;
reg reset_accum;

wire [255:0] buffer_input_1;
wire [255:0] buffer_input_2;

reg [15:0] counter_A;
reg [15:0] counter_B;
reg [15:0] counter;
reg [15:0] counter_row;
reg [15:0] counter_col;
reg [15:0] flag;


reg [225:0] buffer_output [16383:0];

wire[255:0] out;

temp_top_level uut(

.input_1(buffer_input_1),
.input_2(buffer_input_2),
.clock(clock),
.reset(reset),
.reset_accum(reset_accum),
.out(out),
.done_systolic(done_systolic),
.done_accum(done_accum)
);

RAM_input RAM_0 (
.clock(clock),
.counter_A(counter_A),
.counter_B(counter_B),
.output_1(buffer_input_1),
.output_2(buffer_input_2)
);



initial begin
reset <= 1;
reset_accum <= 1;
clock <= 1;
counter_A <= 0;
counter_B <= 0;
counter <= 0;
counter_row <= 0;
counter_col <= 0;
flag <= 0;
#1
reset <= done_systolic;
reset_accum <= 0;

end



always @(posedge clock) begin

if(done_systolic == 1) begin
	reset <= 1;
end else begin
	reset <= 0;
end

end

always @(posedge clock) begin

if(done_accum == 1) begin
	reset_accum <= 1;
end else begin
	reset_accum <= 0;
end
end

initial begin
	forever
		#5 clock <= ~clock;
end

always @(posedge done_systolic) begin
	counter_A <= counter + 16*counter_row;
	counter_B <= counter + 16*counter_col;
end

always @(posedge done_systolic) begin
	if (counter == 15) begin
		counter <= 0;
	end else begin
		counter <= counter + 1;
	end
end

always @(posedge done_accum) begin //address offset generation
	if (counter_col == 127) begin
		counter_col <= 0;
		counter_row <= counter_row + 1;
	end else begin
		counter_col <= counter_col + 1;
	end
end

always @(posedge done_accum) begin //address offset generation
	if (flag == 16383) begin
		flag <= 0;
		$fclose(f); 
		$finish;
	end else begin
		flag <= flag + 1;
	end
end

integer f;
// data parsing section
initial begin
    f = $fopen("output.txt","w");
end


always @(posedge done_accum) begin //address offset generation
        $fwrite(f,"%h\n",out);
end


initial begin
	$dumpfile("wave_temp_top_level.vcd");
	$dumpvars(0, temp_top_level_tb);
end



endmodule
