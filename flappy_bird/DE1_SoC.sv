module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, KEY, GPIO_0, SW);
	input CLOCK_50; // 50MHz clock.
	output reg [6:0] HEX0;
	output reg [6:0] HEX1;
	output reg [6:0] HEX2;
	output reg [6:0] HEX3;
	inout [35:0] GPIO_0;
	input [3:0] KEY;
	input [9:0] SW;
	
	
wire [31:0] divided_clocks;
	
clock_divider cd(.clock(CLOCK_50),.divided_clocks(divided_clocks));

control_top U_control_top(.start(KEY[0]),.reset(~SW[9]),.clock(divided_clocks[3]),
.controller(KEY[1]),.GPIO_0(GPIO_0[35:0]),.out_1(HEX0),.out_2(HEX1),.out_3(HEX2),.out_4(HEX3));

endmodule

module clock_divider (clock, divided_clocks);
	input clock;
	output [31:0] divided_clocks;
	reg [31:0] divided_clocks;
	initial
	divided_clocks = 0;
	always @(posedge clock)
	divided_clocks = divided_clocks + 1;
endmodule

module control_top(start,reset,clock,controller,GPIO_0,out_1,out_2,out_3,out_4);
	input  start;
	input  reset;
	input  clock;
	input controller;
	inout [35:0] GPIO_0;
	output [6:0] out_1;
	output [6:0] out_2;
	output [6:0] out_3;
	output [6:0] out_4;
	reg start_reg;
	wire enable;
	reg [3:0] score0;
	reg [3:0] score1;
	reg [3:0] score2;
	reg [3:0] score3;
	reg [31:0] counter_score;
	wire [7:0] green_array[7:0];
	wire [7:0] red_array[7:0];
	wire [26:0] counter_gen_time;
	
	wire [7:0] red_driver;
	wire [7:0] green_driver;
	wire [7:0] row_sink;
	
	assign GPIO_0[35:0] = {green_driver[0],green_driver[1],green_driver[2],green_driver[3],green_driver[4],green_driver[5],green_driver[6],green_driver[7],
								  red_driver[0],red_driver[1],red_driver[2],red_driver[3],red_driver[4],red_driver[5],red_driver[6],red_driver[7],
								  row_sink[0], row_sink[1], row_sink[2], row_sink[3], row_sink[4], row_sink[5], row_sink[6], row_sink[7], 12'b0}; 
	
	
	

	
	//begin
	always @ (posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			start_reg<=0;
		end
		else
		begin
			start_reg<=start;
		end
	end
	//gameover
	always @ (posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			enable<=0;
		end
		else if ((start_reg==1)&&(start==0))
		begin
			enable<=1;
		end
		else if (((green_array[0][0]==1)&&(red_array[0][0]==1))|((green_array[0][1]==1)&&(red_array[0][1]==1))|((green_array[0][2]==1)&&(red_array[0][2]==1))|((green_array[0][3]==1)&&(red_array[0][3]==1))|((green_array[0][4]==1)&&(red_array[0][4]==1))|((green_array[0][5]==1)&&(red_array[0][5]==1))|((green_array[0][6]==1)&&(red_array[0][6]==1))|((green_array[0][7]==1)&&(red_array[0][7]==1)))
		begin
			enable<=0;
		end
	end
	//keep score
	always @ (posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			counter_score<=0;
		end
		else if ((start_reg==1)&&(start==0))
		begin
			counter_score<=0;
		end
		else if (counter_gen_time==9999999)
		begin
			counter_score<=counter_score+1;
		end
	end

	always @ (posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			score0<=0;
			score1<=0;
			score2<=0;
			score3<=0;
			
		end
		else if ((start_reg==1)&&(start==0))
		begin
			score0<=0;
			score1<=0;
			score2<=0;
			score3<=0;
		end
		else if ((counter_gen_time==9999999)&&(counter_score>=2))
		begin
			if (score0<9)
			begin
				score0<=score0+1;
			end
			else if ((score0==9)&&(score1<9))
			begin
				score0<=0;
				score1<=score1+1;
			end
			else if ((score1==9)&&(score0==9)&&(score2<9))
			begin
				score0<=0;
				score1<=0;
				score2<=score2+1;
			end
			else if ((score1==9)&&(score0==9)&&(score2==9)&&(score3<9))
			begin
				score0<=0;
				score1<=0;
				score2<=0;
				score3<=score3+1;
			end
			else if ((score1=9)&&(score0==9)&&(score2==9)&&(score3==9))
			begin
				score0<=0;
				score1<=0;
				score2<=0;
				score3<=0;
			end		
		end
	end

	bird_controller U_bird_controller(.controller (controller),.clock (clock),.reset (reset),.enable (enable),.green_array (green_array));

	barrier U_barrier(.clock(clock),.reset (reset),.enable (enable),.red_array (red_array),.counter_gen_time (counter_gen_time));

	led_matrix_driver U_led_matrix_driver(.clock (clock),.reset (reset), .red_array (red_array), .green_array (green_array),.red_driver (red_driver),.green_driver (green_driver),.row_sink (row_sink));

	Hex_display U_Hex_display(.in1  (score0 ),.in2  (score1 ),.in3  (score2 ),.in4  (score3 ),.out1 (out_1),.out2 (out_2),.out3 (out_3),.out4 (out_4));		
endmodule

module DE1_SoC_test_bench();
	reg CLOCK_50;
	reg [6:0] HEX0,HEX1,HEX2,HEX3;
	reg [3:0] KEY;
	reg [9:0] SW;
	reg [35:0] GPIO_0;
	integer i;
	DE1_SoC dut(CLOCK_50, HEX0,HEX1, HEX2, HEX3, KEY, GPIO_0, SW);
	
		initial begin
		SW[9] <= 1;					@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		KEY[0]<=0;					@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		SW[1] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		KEY[1] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		KEY[1] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);										
		SW[9] <= 1;					@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		SW[9] <= 0; 				@(posedge CLOCK_50);		
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);		
	   KEY[0] <= 0;					@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
	
		for(i = 0; i < 1000; i++)
		begin				
			@(posedge CLOCK_50);				
		end

		$stop;
	end
endmodule