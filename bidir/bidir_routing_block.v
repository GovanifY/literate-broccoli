module bidir_routing_block(
	input [wire_width*12-1:0] select,
	// zero, zero in lower left corner
	inout [wire_width-1:0] left, 
	inout [wire_width-1:0] right,
	inout [wire_width-1:0] top,
	inout [wire_width-1:0] bottom
	);
	parameter wire_width = 3;
	genvar i;
	generate for (i = 0; i < wire_width; i = i + 1)
	begin
		bidir_switch bs_inst(select[11+i*12:i*12], left[i], right[i], top[i], bottom[i]);
	end endgenerate
endmodule

