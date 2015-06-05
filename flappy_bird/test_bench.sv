   `timescale 1 ns / 10 ps

module test_bench(
);
//=========25M  CLOCK========= 
reg CLOCK;
 initial CLOCK = 1'b1;
  always 
  begin
   #10 CLOCK <= ~CLOCK;    
  end

//============reset=============
reg [9:0] reset;

initial
begin
			reset<=0;
  #1000 reset <=10'b1000000000;    
  end
 
 reg [3:0] start;

initial
begin
			start<=4'b0001;
  #2000 start <= 4'b0000;    
  end
 

 
 
 
 
DE1_SoC U_DE1_SoC(
.KEY(start),
.SW(reset),
.CLOCK_50(CLOCK)
);


endmodule