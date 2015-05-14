module DE1_SoC (CLOCK_50, HEX0, KEY, LEDR, SW);
	input CLOCK_50; // 50MHz clock.
	output reg [6:0] HEX0;
	output reg [9:0] LEDR;
	input  [3:0] KEY;
	input  [9:0] SW;
	wire right,left,H1,H2;
	button b1 (.Clock(CLOCK_50) , .pressed(~KEY[3]), .count(left));
	button b2 (.Clock(CLOCK_50) , .pressed(~KEY[0]), .count(right));
	
	
	Display d1 (.Clock(CLOCK_50), .Reset(SW[9]), .L(left), .R(right), .Le(LEDR[9]), .Re(LEDR[1]), .out(HEX0));
	normalLight nl1(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[2]),.NR(1'b0),	 .lightOn(LEDR[1]));
	normalLight nl2(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[3]),.NR(LEDR[1]),.lightOn(LEDR[2]));
	normalLight nl3(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[4]),.NR(LEDR[2]),.lightOn(LEDR[3]));
	normalLight nl4(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[5]),.NR(LEDR[3]),.lightOn(LEDR[4]));
	centerLight nl5(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[6]),.NR(LEDR[4]),.lightOn(LEDR[5]));
	normalLight nl6(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[7]),.NR(LEDR[5]),.lightOn(LEDR[6]));
	normalLight nl7(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[8]),.NR(LEDR[6]),.lightOn(LEDR[7]));
	normalLight nl8(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(LEDR[9]),.NR(LEDR[7]),.lightOn(LEDR[8]));
	normalLight nl9(.Clock(CLOCK_50), .Reset(SW[9]),.L(left),.R(right), .NL(1'b0),   .NR(LEDR[8]),.lightOn(LEDR[9]));
endmodule


module DE1_SoC_testbench(); //CLOCK_50, KEY, SW, LEDR, HEX0
	reg CLOCK_50;
	reg [9:0] LEDR;
	reg [6:0] HEX0;
	reg [9:0] SW;
	reg [3:0] KEY;
	DE1_SoC dut(CLOCK_50, HEX0,KEY, LEDR, SW);
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial CLOCK_50=1;
	initial KEY[3:0]=4'b1111;
	
	always begin
			#(CLOCK_PERIOD/2);
		CLOCK_50 = ~CLOCK_50;
	end
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

										@(posedge CLOCK_50);
		SW[9] <= 0; 		@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		SW[9] <= 1;					@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		SW[9] <= 0; 		@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
		KEY[0] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[0] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
												KEY[0] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[0] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
												KEY[0] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[0] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
												KEY[0] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[0] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
												KEY[0] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[0] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
												KEY[0] <= 0; 				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
		KEY[0] <= 1;				@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										@(posedge CLOCK_50);
										
										
		$stop; // End the simulation.
	end
endmodule



