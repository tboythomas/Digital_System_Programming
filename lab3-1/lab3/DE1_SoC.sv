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
		//lab2
		stolen sub1 (.steal(LEDR[0]), .U(SW[0]), .P(SW[1]), .C(SW[2]), .M(SW[3]));
		discounted sub2 (.dis(LEDR[1]), .U(SW[0]), .P(SW[1]), .C(SW[2]));

endmodule 

//check the steal light
module stolen (steal, U, P, C, M);
		output steal;
      input U, P, C, M;
		wire n1,n3,a2;
      nor nRM(n1, P, M);
		not nC (n3, C);
		or oUC (a2, n3, U);
		and a3(steal, n1, a2); 
endmodule

//check the discoutted light		
module discounted (dis, U, C, P);
     output dis;
	  input U, C, P;
	  wire a1;
	  and aUC (a1, U, C);
	  or o1(dis, a1, P);
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
		for(i = 0; i <16; i++) begin
		SW[3:0] = i; #10;
		end
		end
endmodule
