module button(Clock, pressed, count);
	input Clock;
	input pressed;
	output reg count;
	reg ps, ns;
	
	always @(*)
		ns = pressed;
	always @(posedge Clock)
		ps <= ns;
	
	assign count = (~ps & ns);

endmodule



module button_testbench();
		reg CLOCK_50, pressed, count;
		wire out;
		button dut (CLOCK_50,pressed, count);
		// Set up the clock.
		parameter CLOCK_PERIOD=100;
		initial CLOCK_50=1;
				always begin
				#(CLOCK_PERIOD/2);
				CLOCK_50 = ~CLOCK_50;
				end

				initial begin
				 pressed<= 1; @(posedge CLOCK_50);
				 pressed<= 0; @(posedge CLOCK_50);
				 pressed<= 0; @(posedge CLOCK_50);
								  @(posedge CLOCK_50);
									@(posedge CLOCK_50);
				 pressed<= 1; @(posedge CLOCK_50);
				 @(posedge CLOCK_50);
				$stop; // End the simulation.
				end
endmodule