module Hex_display(clock,in1,in2,in3,in4,out1,out2,out3,out4);
	input clock;
	input [3:0] in1;
	input [3:0] in2;
	input [3:0] in3;
	input [3:0] in4;
	output reg [6:0] out1;
	output reg [6:0] out2;
	output reg [6:0] out3;
	output reg [6:0] out4;

	always @ (*)
	begin
		case (in1)
			4'd0: out1=7'b1000000;
			4'd1: out1=7'b1111001;
			4'd2: out1=7'b0100100;
			4'd3: out1=7'b0110000;
			4'd4: out1=7'b0011001;
			4'd5: out1=7'b0010010;
			4'd6: out1=7'b0000010;
			4'd7: out1=7'b1011000;
			4'd8: out1=7'b0000000;
			4'd9: out1=7'b0010000;
		endcase
	end

	always @ (*)
	begin
		case (in2)
			4'd0: out2=7'b1000000;
			4'd1: out2=7'b1111001;
			4'd2: out2=7'b0100100;
			4'd3: out2=7'b0110000;
			4'd4: out2=7'b0011001;
			4'd5: out2=7'b0010010;
			4'd6: out2=7'b0000010;
			4'd7: out2=7'b1011000;
			4'd8: out2=7'b0000000;
			4'd9: out2=7'b0010000;
		endcase
	end

	always @ (*)
	begin
		case (in3)
			4'd0: out3=7'b1000000;
			4'd1: out3=7'b1111001;
			4'd2: out3=7'b0100100;
			4'd3: out3=7'b0110000;
			4'd4: out3=7'b0011001;
			4'd5: out3=7'b0010010;
			4'd6: out3=7'b0000010;
			4'd7: out3=7'b1011000;
			4'd8: out3=7'b0000000;
			4'd9: out3=7'b0010000;
		endcase
	end

	always @ (*)
	begin
		case (in4)
			4'd0: out4=7'b1000000;
			4'd1: out4=7'b1111001;
			4'd2: out4=7'b0100100;
			4'd3: out4=7'b0110000;
			4'd4: out4=7'b0011001;
			4'd5: out4=7'b0010010;
			4'd6: out4=7'b0000010;
			4'd7: out4=7'b1011000;
			4'd8: out4=7'b0000000;
			4'd9: out4=7'b0010000;
		endcase
	end
endmodule

//module Hex_display(in1,in2,in3,in4,out1,out2,out3,out4);

module Hex_display_testbench();
	reg [3:0] in1,in2,in3,in4;
	reg [6:0] out1,out2,out3,out4;
	reg CLOCK_50;
	Hex_display dut (CLOCK_50,in1,in2,in3,in4,out1,out2,out3,out4);
		// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial CLOCK_50=1;
	
	always begin
			#(CLOCK_PERIOD/2);
		CLOCK_50 = ~CLOCK_50;
	end
	initial begin

										@(posedge CLOCK_50);
		in1 <= 1; 					@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		in2 <= 9;					@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		in3 <= 9; 						@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		in4 <= 0;						@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		in1 <= 9; 						@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		in2 <= 0;						@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		in3 <= 0; 						@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		in4 <= 0;						@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		$stop;
		end
endmodule
