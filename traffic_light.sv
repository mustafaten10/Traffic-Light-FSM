`timescale 1ns / 1ps
module traffic_light(
    input  logic clk,
    input  logic reset,
    input  logic TAORB,
    output logic LA_G,
    output logic LA_Y,
    output logic LA_R,
    output logic LB_G,
    output logic LB_Y,
    output logic LB_R
);
// state definition
typedef enum logic [1:0] {
    S0,
    S1,
    S2,
    S3
} state_t;
state_t state, next_state;
logic [2:0] timer;
// state register
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        state <= S0;
    else
        state <= next_state;
end
// timer
always_ff @(posedge clk or posedge reset) begin
    if (reset)
        timer <= 0;
    else if (state == S1 || state == S3)
        timer <= timer + 1;
    else
        timer <= 0;
end
// next state logic
always_comb begin
    case(state)
        S0: next_state = (~TAORB) ? S1 : S0;
        S1: next_state = (timer == 5) ? S2 : S1;
        S2: next_state = (TAORB) ? S3 : S2;
        S3: next_state = (timer == 5) ? S0 : S3;
        default: next_state = S0;
    endcase
end
// output logic
always_comb begin
    case(state)
        S0: begin
            LA_G = 1; LA_Y = 0; LA_R = 0;
            LB_G = 0; LB_Y = 0; LB_R = 1;
        end
        S1: begin
            LA_G = 0; LA_Y = 1; LA_R = 0;
            LB_G = 0; LB_Y = 0; LB_R = 1;
        end
        S2: begin
            LA_G = 0; LA_Y = 0; LA_R = 1;
            LB_G = 1; LB_Y = 0; LB_R = 0;
        end
        S3: begin
            LA_G = 0; LA_Y = 0; LA_R = 1;
            LB_G = 0; LB_Y = 1; LB_R = 0;
        end
    endcase
end
endmodule   
