//Приемник излученного и отраженного сигнала ЛДМ и счетчик дальности.

module range_finder_2 
	#(parameter WIDTH = 8)
	(
		input clk,
		input rst_n,
		input em_sensor,
		input rec_sensor,
		output reg [WIDTH-1 : 0] range
		//output  state_t
	);
	
	reg [WIDTH-1 : 0] cnt;
	reg [WIDTH-1 : 0] next_cnt;
	
	
	reg state;
	reg next_state;
	
	
	
	localparam	WAIT =	0, // Состояние ожидания начала отсчета по испущенному излучению  
					COUNT =	1; // Состояние отсчета до приема отраженного излучения
		
	always @(posedge clk or negedge rst_n)
		begin
			if (!rst_n)
				begin
						state <= WAIT;
						cnt <= {WIDTH{1'b0}};
				end
			else		
				state <= next_state;
				cnt <= next_cnt;
		end
		
	always @*
		begin
			next_state = state;
			case (state)
				WAIT : 
					if (em_sensor)	next_state = COUNT;
				COUNT :
					if ((cnt == {WIDTH{1'b1}}) | (rec_sensor)) next_state = WAIT;
			endcase
		end
		
	always @*
		begin
			case (state)
				WAIT :	next_cnt =  {WIDTH{1'b0}};
				COUNT :	next_cnt = cnt + 1'b1;
			endcase
		end
		
	always @(posedge clk or negedge rst_n)
		begin
			if (!rst_n) range <= {WIDTH{1'b0}};
			else if ((state == COUNT)&(rec_sensor)) range <= cnt;		
		end
		
		//assign state_t = state;
		
endmodule //range_finder_2
		
		