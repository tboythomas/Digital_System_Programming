
module centerLight (Clock, Reset, L, R, NL, NR, lightOn);
	input Clock, Reset;
	input L, R, NL, NR;
	reg ns;
	reg ps;
	
	parameter  on = 1'b1, off = 1'b0;
	output reg lightOn;
	
	always @(*)
	case(ps) 
		off: if((L && NR)||(R && NL)) ns = on;
				else ns = off;
		on: if((L)||(R))ns = off;
			else ns = on;
	endcase
	
	assign lightOn = (ps == on);
	
	always @(posedge Clock)
		if(Reset)
			ps <= on;
		else
			ps <= ns;
endmodule




module centerLight_testbench();

	reg clk, reset;
	wire out;
	wire [9:0] LEDR;
	wire [3:0] KEY;
	wire [6:0] HEX;
	reg [9:0] SW;	
	reg NL, NR, L, R;
	centerLight dut(.Clock(clk), .Reset(reset), .L(L), .R(R), .NL(NL), .NR(NR), .lightOn(LEDR[5]));

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
			#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

		reset <= 1; 				@(posedge clk);
										@(posedge clk);
		reset <= 0;					@(posedge clk);
										@(posedge clk);
		L <= 1;						@(posedge clk);
										@(posedge clk);
		NR <= 1;						@(posedge clk); ////in order to turn on the LED
										@(posedge clk);
										@(posedge clk);
		NR <= 0;						@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		L <= 0;						@(posedge clk); //this turns the LED off!!
										@(posedge clk);					
		R <= 1;						@(posedge clk);
										@(posedge clk);
		NL <= 1; 					@(posedge clk); //test turn led on
										@(posedge clk);
		NL <= 0;						@(posedge clk);
										@(posedge clk);
										@(posedge clk);
		R <= 0;						@(posedge clk);
										@(posedge clk); //test turn led off
										
		$stop; // Ends
	end
endmodule
