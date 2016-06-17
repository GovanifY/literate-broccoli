module bidir_switch_block(
	input [wire_width*wire_width*12-1:0] select,
	inout [wire_width-1:0] left, 
	inout [wire_width-1:0] right, 
	inout [wire_width-1:0] bottom
	);
	parameter wire_width = 3;
	/*wire tb[2:0][2:0];
	wire lr[2:0][1:0];
	
	// First row
	bidir_switch bs1(
		.select(select[11:0]), 
		.left(left[0]), 
		.right(lr[0][0]), 
		.top(tb[0][0]), 
		.bottom(bottom[0])
	);
	bidir_switch bs2(
		.select(select[23:12]), 
		.left(lr[0][0]), 
		.right(lr[0][1]), 
		.top(tb[0][1]), 
		.bottom(bottom[1])
	);
	bidir_switch bs3(
		.select(select[35:24]), 
		.left(lr[0][1]),
		.right(right[0]), 
		.top(tb[0][2]), 
		.bottom(bottom[2])
	);
	// Second row
	bidir_switch bs4(
		.select(select[47:36]), 
		.left(left[1]), 
		.right(lr[1][0]), 
		.top(tb[1][0]), 
		.bottom(tb[0][0])
	);
	bidir_switch bs5(
		.select(select[59:48]), 
		.left(lr[1][0]), 
		.right(lr[1][1]), 
		.top(tb[1][1]), 
		.bottom(tb[0][1])
	);
	bidir_switch bs6(
		.select(select[71:60]), 
		.left(lr[1][1]), 
		.right(right[1]), 
		.top(tb[1][2]), 
		.bottom(tb[0][2])
	);
	// Third row
	bidir_switch bs7(
		.select(select[83:72]), 
		.left(left[2]), 
		.right(lr[2][0]), 
		.top(tb[2][0]), 
		.bottom(tb[1][0])
	);
	bidir_switch bs8(
		.select(select[95:84]), 
		.left(lr[2][0]), 
		.right(lr[2][1]), 
		.top(tb[2][1]), 
		.bottom(tb[1][0])
	);
	bidir_switch bs9(
		.select(select[107:96]), 
		.left(lr[2][1]), 
		.right(right[2]), 
		.top(tb[2][2]), 
		.bottom(tb[1][2])
	);*/
	wire [wire_width-1:0] top;
	
	genvar x, y;
	wire lr[wire_width:0][wire_width:0];
	wire tb[wire_width:0][wire_width:0];
	generate
	for(y = 0; y < wire_width; y = y + 1) begin
		for (x = 0; x < wire_width; x = x + 1) begin
			localparam s_base = (x*12)+(y*wire_width*12);
			if (x == 0) begin
				if (y == 0) begin // Bottom left
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( left[y] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( bottom[x] )
					);
				end
				else if (y == wire_width-1) begin // Top left
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( left[y] ),
						.right( lr[y][x+1] ),
						.top( top[x] ),
						.bottom( tb[y][x] )
					);
				end
				else begin // Some left
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( left[y] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( tb[y][x] )
					);
				end
			end
			else if (x == wire_width-1) begin
				if (y == 0) begin // Bottom right
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( lr[y][x] ),
						.right( right[y] ),
						.top( tb[y+1][x] ),
						.bottom( bottom[x] )
					);
				end
				else if (y == wire_width-1) begin // Top right
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( lr[y][x] ),
						.right( right[y] ),
						.top( top[x] ),
						.bottom( tb[y][x] )
					);
				end
				else begin // Some right
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( lr[y][x] ),
						.right( right[y] ),
						.top( tb[y+1][x] ),
						.bottom( tb[y][x] )
					);
				end
			end else begin
				if (y == 0) begin // Bottom edge
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( lr[y][x] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( bottom[x] )
					);
				end
				else if (y == wire_width-1) begin // Top edge
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( lr[y][x] ),
						.right( lr[y][x+1] ),
						.top( top[x] ),
						.bottom( tb[y][x] )
					);
				end
				else begin // Middle somewhere
					bidir_switch bs(
						.select(select[s_base+11:s_base]), 
						.left( lr[y][x] ),
						.right( lr[y][x+1] ),
						.top( tb[y+1][x] ),
						.bottom( tb[y][x] )
					);
				end
			end
		
			/*bidir_switch bs(
				.left( x==0 ? left[y] : lr[y][x] ),
				.right( x == wire_width-1 ? right[y] : lr[y][x+1] ),
				.top( y == wire_width-1 ? top[x] : tb[y+1][x] ),
				.bottom( y == 0 ? bottom[x] : tb[y][x] )
			);*/
		end
	end
	endgenerate
	
endmodule

