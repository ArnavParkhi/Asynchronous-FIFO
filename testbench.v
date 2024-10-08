module testbench(
);

localparam counter_rd = 2;
reg wr_clk; 
reg rd_clk;
reg reset;
wire wr_en;
wire rd_en;
wire [15:0] data_in;
wire [15:0] data_out;
wire empty;
wire full;
wire [4:0] wr_ptr;
wire [4:0] rd_ptr;

async_fifo i0(wr_clk, rd_clk, reset, wr_en, rd_en, data_in, data_out, empty, full, wr_ptr, rd_ptr);
data_mem i1(wr_clk, wr_en, data_in);

always begin
	#5 wr_clk = !wr_clk;
	//#5 rd_clk = !rd_clk;
end

initial begin
	wr_clk = 1'b0; reset = 1'b1;
	#10 reset = 1'b0;
	#1000 $finish;
	
end

reg [counter_rd-1:0] k_bit_counter_rd = 0;

always @(posedge wr_clk) begin
	k_bit_counter_rd <= k_bit_counter_rd + 1;
	rd_clk <= k_bit_counter_rd[counter_rd-1];
end

//assign rd_clk = k_bit_counter_rd[counter_rd-1];
endmodule 
