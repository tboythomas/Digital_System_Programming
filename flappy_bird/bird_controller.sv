//this module control the bird up and down

module bird_controller(controller,clock,reset,enable,green_array);
	input  controller;
	input  clock;
	input  reset;
	input  enable;
	output reg  [7:0] green_array[7:0];
	//set up time period
	reg [24:0] counter_up_time;

	always @ (posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			counter_up_time<=0;
		end
		else if (enable)
		begin
			if ((controller==0)&&(counter_up_time<2499999))
			begin
				counter_up_time<=counter_up_time+1;
			end
			else 
			begin
				counter_up_time<=0;
			end
		end
		else
		begin
			counter_up_time<=0;
		end
	end
	//set down time period
	reg [24:0] counter_down_time;

	always @ (posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			counter_down_time<=0;
		end
		else if (enable)
		begin
			if (controller)
			begin
				if (counter_down_time<2499999)
				begin
					counter_down_time<=counter_down_time+1;
				end
				else if (counter_down_time==2499999)
				begin
					counter_down_time<=0;
				end
			end
			else
			begin
				counter_down_time<=0;
			end
		end
		else
		begin
			counter_down_time<=0;
		end
	end

	//control bird up and down

	reg [2:0] counter_controller;

	always @ (posedge clock or negedge reset)
	begin
		if (!reset)
		begin
			counter_controller<=3;
		end
		else if (enable)
		begin
			if (counter_up_time==2499999)
			begin
				counter_controller<=counter_controller+1;
			end
			else if (counter_down_time==2499999)
			begin
				counter_controller<=counter_controller-1;
			end
		end
		else
		begin
			counter_controller<=3;
		end
	end



	always @ (*)
	begin
		if(reset)
		begin
			 green_array[1] = 8'b00000000;
			 green_array[2] = 8'b00000000;
			 green_array[3] = 8'b00000000;
			 green_array[4] = 8'b00000000;
			 green_array[5] = 8'b00000000;
			 green_array[6] = 8'b00000000;
			 green_array[7] = 8'b00000000;
		end
	end


	always @ (*)
	begin
		case (counter_controller)
			3'd0: green_array[0] = 8'b00000001;
			3'd1: green_array[0] = 8'b00000010;
			3'd2: green_array[0] = 8'b00000100;
			3'd3: green_array[0] = 8'b00001000;
			3'd4: green_array[0] = 8'b00010000;
			3'd5: green_array[0] = 8'b00100000;
			3'd6: green_array[0] = 8'b01000000;
			3'd7: green_array[0] = 8'b10000000;
		endcase
	end
		
endmodule

//module bird_controller(controller,clock,reset,enable,green_array);
module bird_controller_test_bench();
	reg CLOCK_50;
	reg [3:0] KEY;
	reg [9:0] SW;
	reg [35:0] GPIO_0;
	integer i;
	bird_controller dut(KEY[1],CLOCK_50, SW[9],KEY[0], GPIO_0[35:28]);
	
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
	   KEY[0] <= 0;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
	
		for(i = 0; i < 1000; i++)
		begin				
			@(posedge CLOCK_50);				
		end

		$stop;
	end
endmodule