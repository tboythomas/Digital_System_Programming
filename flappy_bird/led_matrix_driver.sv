module led_matrix_driver (
input clock,
input reset,
input [7:0] red_array[7:0], 
input [7:0] green_array[7:0], 
output  [7:0] red_driver, 
output  [7:0] green_driver, 
output reg [7:0] row_sink
); 

	reg [2:0] count; 
	always @(posedge clock or negedge reset) 
	begin
		if (!reset)
		count<=0;
		else
		count <= count + 3'b001; 
	end
	always @(*) 
	begin
		case (count) 
			3'b000: row_sink = 8'b11111110; 
			3'b001: row_sink = 8'b11111101; 
			3'b010: row_sink = 8'b11111011; 
			3'b011: row_sink = 8'b11110111; 
			3'b100: row_sink = 8'b11101111; 
			3'b101: row_sink = 8'b11011111; 
			3'b110: row_sink = 8'b10111111; 
			3'b111: row_sink = 8'b01111111; 
		endcase
	end
assign red_driver = red_array[count]; 
assign green_driver = green_array[count]; 
endmodule