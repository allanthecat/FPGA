module HeartBeat(
input wire clk,
input wire reset,
output wire beat);
parameter WIDTH = 20;
   reg [(WIDTH-1):0] count;
	assign beat = &count;
   always @(posedge clk) begin
      if(reset) count <= {WIDTH{1'b0}};
      else count <= count +1'b1;
		//case(count)
		//	4'b0001:	beat <= 1'b1;
		//	4'b0100: beat <= 1'b1;
		//	4'b1000:	beat <= 1'b1;
		//	default beat <= 1'b0;
		//endcase
    end
endmodule 