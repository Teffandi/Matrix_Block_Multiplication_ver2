
module RAM_input #(
   parameter DATA_WIDTH = 256,
   parameter DEPTH      = 2048
) (
   input wire                   clock,
   input wire  [15:0]           counter_A,
   input wire  [15:0]           counter_B,
   output reg  [DATA_WIDTH-1:0]  output_1,
   output reg  [DATA_WIDTH-1:0]  output_2

);



   reg [DATA_WIDTH-1:0] mem_array_A [DEPTH-1:0];
   reg [DATA_WIDTH-1:0] mem_array_B [DEPTH-1:0];


initial begin

    $readmemh("A.txt", mem_array_A);
    $readmemh("B.txt", mem_array_B);

end
   
   always @(posedge clock) begin

       output_1 <= mem_array_A[counter_A];
       output_2 <= mem_array_B[counter_B];


   end
endmodule