module top (
    input  [1:0] SW,      
    input  [0:0] KEY,     
    output [9:0] LEDR     
);

    wire clk;
    wire rst;
    wire w;

    wire [8:0] state;
    wire z;

    
    assign clk = KEY[0];    
    assign w   = SW[1];      
    assign rst = ~SW[0];     

    ex1mod_lab2 uut (
        .clk(clk),
        .rst(rst),
        .w(w),
        .state(state),
        .z(z)
    );

    assign LEDR[8:0] = state;  
    assign LEDR[9]   = z;       

endmodule

module ex1mod_lab2 (
	input clk,
	input rst,
	input w,
	output [8:0] state,
	output z
	);
	wire [8:0] tempnxt;
	next_state u1 (.w(w),.rst(rst),.q(tempnxt),.y(state));
	present_state u2 (.rst(rst),.clk(clk),.y(state),.q(tempnxt));
	out u3 (.clk(clk),.rst(rst),.z(z),.w(w));

endmodule 
	
module out( 
	input clk,
	input rst,
	input w,
	output z
	);
	
	wire tempw1;
	wire tempw2;
   wire tempw3;
	wire tempw;

	d_ff u1(.D(w),.clk(clk),.rst(rst),.Q(tempw));
	d_ff u2(.D(tempw),.clk(clk),.rst(rst),.Q(tempw1));
	d_ff u3(.D(tempw1),.clk(clk),.rst(rst),.Q(tempw2));
	d_ff u4(.D(tempw2),.clk(clk),.rst(rst),.Q(tempw3));
	
	wire temp1;
	wire temp2;
	wire temp3;
	wire temp4;
	
	d_ff u5(.D(1'b1),.clk(clk),.rst(rst),.Q(temp1));
	d_ff u6(.D(temp1),.clk(clk),.rst(rst),.Q(temp2));
	d_ff u7(.D(temp2),.clk(clk),.rst(rst),.Q(temp3));
	d_ff u8(.D(temp3),.clk(clk),.rst(rst),.Q(temp4));
	
	assign clkcheck = temp1 &temp2 &temp3 &temp4;
	assign z= (clkcheck &tempw &tempw1 &tempw2 &tempw3 &~rst)|
				 (clkcheck &~tempw &~tempw1 &~tempw2 &~tempw3 &~rst);

endmodule

	
module present_state(
	input rst,
	input clk,
	input [8:0] q,
	output [8:0] y
	);
	

	d_ff u0 (.D(q[0]),.rst(rst),.clk(clk),.Q(y[0]));
	d_ff u1 (.D(q[1]),.rst(rst),.clk(clk),.Q(y[1]));
	d_ff u2 (.D(q[2]),.rst(rst),.clk(clk),.Q(y[2]));
	d_ff u3 (.D(q[3]),.rst(rst),.clk(clk),.Q(y[3]));
	d_ff u4 (.D(q[4]),.rst(rst),.clk(clk),.Q(y[4]));
	d_ff u5 (.D(q[5]),.rst(rst),.clk(clk),.Q(y[5]));
	d_ff u6 (.D(q[6]),.rst(rst),.clk(clk),.Q(y[6]));
	d_ff u7 (.D(q[7]),.rst(rst),.clk(clk),.Q(y[7]));
	d_ff u8 (.D(q[8]),.rst(rst),.clk(clk),.Q(y[8]));
endmodule

module next_state(
	input w,
	input rst,
	input [8:0] y,
	output [8:0] q
	);

	// chọn bit signature cho từng state, với A thì không có nên phải not bit [8]...[1]
	assign q[0] = ~rst;
	assign q[1] = (~y[8]&~y[7]&~y[6]&~y[5]&~y[4]&~y[3]&~y[2]&~y[1]&~y[0] | y[5] | y[6] | y[7] | y[8]) & ~w;
	assign q[2] = y[1] & ~w;
	assign q[3] = y[2] & ~w;
	assign q[4] = (y[3] | y[4]) & ~w;
	assign q[5] = (~y[8]&~y[7]&~y[6]&~y[5]&~y[4]&~y[3]&~y[2]&~y[1]&~y[0] | y[1] | y[2] | y[3] | y[4]) & w;
	assign q[6] = y[5] & w;
	assign q[7] = y[6] & w;
	assign q[8] = (y[7] | y[8]) & w;
endmodule

module d_ff (
	input logic D,
	input clk,
	input logic rst,
   output logic Q
	);
	
	always_ff @(posedge clk, posedge rst)
	if (rst) 
		Q <= 0;
	else
		Q <= D;
	
endmodule 
