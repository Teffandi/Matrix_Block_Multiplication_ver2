
module mux_4_1 (
    
   input [15:0] input_1, 
   input [15:0] input_2,
   input [15:0] input_3,
   input [15:0] input_4,
   input reset,
   input clock,
   output reg [15:0] out
);


reg [1:0] select;


always @(posedge clock or posedge reset) begin

if (reset) begin 
    out <= 16'd0;
    select <= 2'd0;

end else begin
    case (select)
    2'b00 : out <= input_1;
    2'b01 : out <= input_2;
    2'b10 : out <= input_3;
    2'b11 : out <= input_4;
endcase
select <= select+1;
end



end


endmodule