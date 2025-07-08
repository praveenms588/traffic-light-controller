module traffic_light_controller_4way(
    input wire clk,
    input wire rst,
    output reg [2:0] north,
    output reg [2:0] south,
    output reg [2:0] east,
    output reg [2:0] west
);
    parameter NS_GREEN   = 3'd0;
    parameter NS_YELLOW  = 3'd1;
    parameter EW_GREEN   = 3'd2;
    parameter EW_YELLOW  = 3'd3;
    parameter ALL_RED    = 3'd4;

    reg [2:0] current_state, next_state, prev_state;
    reg [31:0] counter;

    parameter TIME_GREEN  = 5_000_000;
    parameter TIME_YELLOW = 2_000_000;
    parameter TIME_ALL_RED = 1_000_000;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= NS_GREEN;
            prev_state <= NS_GREEN;
            counter <= 0;
        end else begin
            if (counter >= TIME_GREEN && (current_state == NS_GREEN || current_state == EW_GREEN)) begin
                counter <= 0;
                prev_state <= current_state;
                current_state <= (current_state == NS_GREEN) ? NS_YELLOW : EW_YELLOW;
            end else if (counter >= TIME_YELLOW && (current_state == NS_YELLOW || current_state == EW_YELLOW)) begin
                counter <= 0;
                prev_state <= current_state;
                current_state <= ALL_RED;
            end else if (counter >= TIME_ALL_RED && current_state == ALL_RED) begin
                counter <= 0;
                current_state <= (prev_state == NS_YELLOW) ? EW_GREEN : NS_GREEN;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    always @(*) begin
        north = 3'b100; 
        south = 3'b100;
        east = 3'b100;
        west = 3'b100;

        case (current_state)
            NS_GREEN: begin north = 3'b001; south = 3'b001; end
            NS_YELLOW: begin north = 3'b010; south = 3'b010; end
            EW_GREEN: begin east = 3'b001; west = 3'b001; end
            EW_YELLOW: begin east = 3'b010; west = 3'b010; end
        endcase
    end

endmodule
