
`timescale 1ns/1ps

module range_finder_2_test;
	
	//localparam WIDTH = 8;
	
	reg clk;
	reg rst_n;
	reg em_sensor;
	reg rec_sensor;
	wire [7 : 0] range;
	//wire state_t;
	
	range_finder_2 #(8) DUT
		(
			.clk(clk),
			.rst_n(rst_n),
			.em_sensor(em_sensor),
			.rec_sensor(rec_sensor),
			.range(range)
			//.state_t(state_t)
		);
		
	initial
		begin
			clk = 1'b0; rst_n = 1'b1; em_sensor = 1'b0; rec_sensor = 1'b0;
			#50; rst_n = 1'b0; #55; rst_n = 1'b1;
			# 165 em_sensor = 1'b1; #40 em_sensor = 1'b0;
			# 654 rec_sensor = 1'b1; #82 rec_sensor = 1'b0;
			
			#50; rst_n = 1'b0; #55; rst_n = 1'b1;
			# 165 em_sensor = 1'b1; #40 em_sensor = 1'b0;
			# 654 rec_sensor = 1'b1; #82 rec_sensor = 1'b0;
			
			# 165 em_sensor = 1'b1; #40 em_sensor = 1'b0;
			# 854 rec_sensor = 1'b1; #82 rec_sensor = 1'b0;
			# 100;
			
		end
		
	always  #20 clk = ~clk;
	
	
	
endmodule //range_finder_2_test