// this is an accumulator module 
module adder_buffer(

input [255:0] input_1,
input reset,
input clock,
input systolic_done,

output reg accumulator_done,
output reg [255:0] out

);

reg [15:0]update_value[15:0];
reg [6:0] count;

always @(posedge systolic_done or posedge reset) begin
	if(reset) begin
		accumulator_done <= 0;
		count <= 0;
        update_value[0] <= 'h0000;
        update_value[1] <= 'h0000;
        update_value[2] <= 'h0000;
        update_value[3] <= 'h0000;
        update_value[4] <= 'h0000;
        update_value[5] <= 'h0000;
        update_value[6] <= 'h0000;
        update_value[7] <= 'h0000;
        update_value[8] <= 'h0000;
        update_value[9] <= 'h0000;
        update_value[10] <= 'h0000; 
        update_value[11] <= 'h0000;
        update_value[12] <= 'h0000;
        update_value[13] <= 'h0000;
        update_value[14] <= 'h0000;
        update_value[15] <= 'h0000;
        out <=  'h0000000000000000000000000000000000000000000000000000000000000000;


	end
	else begin

		if(count == 16) begin
			accumulator_done <= 1;
            out <= {update_value[0],update_value[1],update_value[2],update_value[3],update_value[4],update_value[5],update_value[6],update_value[7],update_value[8],update_value[9],update_value[10],update_value[11],update_value[12],update_value[13],update_value[14],update_value[15]};
			count <= 0;
		end
		else begin
			accumulator_done <= 0;
    			count <= count + 1;
    		end

    update_value[0] <= update_value[0]+ input_1[255:240];
    update_value[1] <= update_value[1]+ input_1[255-16*1:255-16*1-15];
    update_value[2] <= update_value[2]+ input_1[255-16*2:255-16*2-15];
    update_value[3] <= update_value[3]+ input_1[255-16*3:255-16*3-15];
    update_value[4] <= update_value[4]+ input_1[255-16*4:255-16*4-15];
    update_value[5] <= update_value[5]+ input_1[255-16*5:255-16*5-15];
    update_value[6] <= update_value[6]+ input_1[255-16*6:255-16*6-15];
    update_value[7] <= update_value[7]+ input_1[255-16*7:255-16*7-15];
    update_value[8] <= update_value[8]+ input_1[255-16*8:255-16*8-15];
    update_value[9] <= update_value[9]+ input_1[255-16*9:255-16*9-15];
    update_value[10] <= update_value[10]+ input_1[255-16*10:255-16*10-15];
    update_value[11] <= update_value[11]+ input_1[255-16*11:255-16*11-15];
    update_value[12] <= update_value[12]+ input_1[255-16*12:255-16*12-15];
    update_value[13] <= update_value[13]+ input_1[255-16*13:255-16*13-15];
    update_value[14] <= update_value[14]+ input_1[255-16*14:255-16*14-15];
    update_value[15] <= update_value[15]+ input_1[255-16*15:255-16*15-15];

	end	
end




endmodule