`timescale 1ns / 1ps
module traffic_light_tb;
logic clk;
logic reset;
logic TAORB;
logic LA_G;
logic LA_Y;
logic LA_R;
logic LB_G;
logic LB_Y;
logic LB_R;
// instantiate DUT
traffic_light dut(
    .clk(clk),
    .reset(reset),
    .TAORB(TAORB),
    .LA_G(LA_G),
    .LA_Y(LA_Y),
    .LA_R(LA_R),
    .LB_G(LB_G),
    .LB_Y(LB_Y),
    .LB_R(LB_R)
);
// clock generation
initial clk = 0;
always #5 clk = ~clk;
// stimulus
initial begin
reset = 1;
TAORB = 1;
#10 reset = 0;
#50 TAORB = 0;
#100 TAORB = 1;
#200 $finish;
end
endmodule  