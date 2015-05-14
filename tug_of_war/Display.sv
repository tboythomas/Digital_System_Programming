module Display(Clock, Reset, L, R, Le, Re, out);
	input Clock, Reset, L, R, Le, Re;
	output reg[6:0] out;
	reg [6:0] ps;
	reg [6:0] ns;
	
	parameter[6:0] leftwin = 7'b0100100, rightwin = 7'b1111001, def = 7'b1111111;
	always @(*)
	case(ps)
			def:if(Le && L) ns = leftwin;
				 else if(Re && R) ns = rightwin;
				 else ns = def;
			leftwin: ns = leftwin;
			rightwin: ns = rightwin;
	endcase
	assign out = ps;	
	always @(posedge Clock)
		if(Reset)
			ps <= def;
		else
			ps <= ns;
			
endmodule

module Display_testbench();
		reg CLOCK_50, L, R, Le, Re, Reset;
		reg [6:0] dis;
		wire out;
		// Set up the clock.
		Display dut (CLOCK_50, L, R, Le, Re, dis);
		parameter CLOCK_PERIOD=100;
		initial CLOCK_50=1;
				always begin
				#(CLOCK_PERIOD/2);
				CLOCK_50 = ~CLOCK_50;
				end

				initial begin
				 @(posedge CLOCK_50);
				 Reset <= 1; @(posedge CLOCK_50);
				 Reset <= 0; Le <= 0; @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 Le <= 1; @(posedge CLOCK_50);
				 Re <= 0; @(posedge CLOCK_50);
				 Re<= 1; @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 L <= 0; @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 L <= 1; @(posedge CLOCK_50);
				 R <= 0; R <= 0; @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				$stop; // End the simulation.
				end
endmodule