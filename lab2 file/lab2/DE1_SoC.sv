// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
		output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		output [9:0] LEDR;
		input [3:0] KEY;
		input [9:0] SW;
		// Default values, turns off the HEX displays
		assign HEX0 = 7'b1111111;
		assign HEX1 = 7'b1111111;
		assign HEX2 = 7'b1111111;
		assign HEX3 = 7'b1111111;
		assign HEX4 = 7'b1111111;
		assign HEX5 = 7'b1111111;
		// Logic to check if SW[3]..SW[0] match your bottom digit,
		// and SW[7]..SW[4] match the next.
		// Result should drive LEDR[0].
		wire a;
		wire b;	
		Fdigit aSubmodule (.Output1(a),.SW0(SW[0]),.SW1(SW[1]),.SW2(SW[2]),.SW3(SW[3]));
		Sdigit bSubmodule (.Output2(b),.SW4(SW[4]),.SW5(SW[5]),.SW6(SW[6]),.SW7(SW[7]));
	   and result (LEDR[1], a, b);	
 
 endmodule 
 
//module for the first digit
module Fdigit (Output1, SW0, SW1, SW2, SW3);
		output Output1;
		input SW0,SW1,SW2,SW3;
		nor n1 (top1, SW2, SW3);
		not nn1 (nC, SW1);
		nand n2 (top2, top1, nC);
		nor n3(Output1, top2, SW0);
endmodule
      
//module for the second digit
module Sdigit(Output2, SW4, SW5, SW6, SW7);
		output Output2;
		input SW4,SW5,SW6,SW7;
      not nSW4(nA, SW4);
		not nSW5(nC, SW5);
		not nSW7(nD, SW7);
		and temp(Output2,nA,nC,nD,SW6);
endmodule

		
module DE1_SoC_testbench();
		wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		wire [9:0] LEDR;
		reg [3:0] KEY;
		reg [9:0] SW;
		DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
		.SW);
		// Try all combinations of inputs.
		integer i;
		initial begin
		SW[9] = 1'b0;
		SW[8] = 1'b0;
		for(i = 0; i <256; i++) begin
		SW[7:0] = i; #10;
		end
		end
endmodule
