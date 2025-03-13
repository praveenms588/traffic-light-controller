module traffic_light_controller(
    input wire clk,         // Clock input
    input wire rst,         // Reset input
    output reg [2:0] main_road, // Traffic lights for main road (Red, Yellow, Green)
    output reg [2:0] side_road  // Traffic lights for side road (Red, Yellow, Green)
);

    // State Encoding (Without typedef)
    parameter RED_MAIN    = 3'b000;
    parameter YELLOW_MAIN = 3'b001;
    parameter GREEN_MAIN  = 3'b010;
    parameter RED_SIDE    = 3'b011;
    parameter YELLOW_SIDE = 3'b100;
    parameter GREEN_SIDE  = 3'b101;

    reg [2:0] current_state, next_state;
    reg [31:0] counter;  // Timer counter

    parameter TIME_RED    = 5_000_000;  // Example delay for RED state
    parameter TIME_YELLOW = 2_000_000;  // Example delay for YELLOW state
    parameter TIME_GREEN  = 5_000_000;  // Example delay for GREEN state

    // State Transition Logic (Sequential)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= RED_MAIN; // Start with RED on Main Road
            counter <= 0;
        end else begin
            if (counter >= TIME_RED && (current_state == RED_MAIN || current_state == RED_SIDE)) 
                counter <= 0;
            else if (counter >= TIME_YELLOW && (current_state == YELLOW_MAIN || current_state == YELLOW_SIDE))
                counter <= 0;
            else if (counter >= TIME_GREEN && (current_state == GREEN_MAIN || current_state == GREEN_SIDE))
                counter <= 0;
            else
                counter <= counter + 1;
            
            current_state <= next_state;
        end
    end

    // Next State Logic (Combinational)
    always @(*) begin
        case (current_state)
            RED_MAIN:    
                next_state = (counter >= TIME_RED) ? YELLOW_MAIN : RED_MAIN;
            YELLOW_MAIN: 
                next_state = (counter >= TIME_YELLOW) ? GREEN_MAIN : YELLOW_MAIN;
            GREEN_MAIN:  
                next_state = (counter >= TIME_GREEN) ? RED_SIDE : GREEN_MAIN;
            RED_SIDE:    
                next_state = (counter >= TIME_RED) ? YELLOW_SIDE : RED_SIDE;
            YELLOW_SIDE: 
                next_state = (counter >= TIME_YELLOW) ? GREEN_SIDE : YELLOW_SIDE;
            GREEN_SIDE:  
                next_state = (counter >= TIME_GREEN) ? RED_MAIN : GREEN_SIDE;
            default:     
                next_state = RED_MAIN;
        endcase
    end

    // Output Logic (Traffic Light Control)
    always @(*) begin
        case (current_state)
            RED_MAIN:    begin main_road = 3'b100; side_road = 3'b001; end // Red Main, Green Side
            YELLOW_MAIN: begin main_road = 3'b010; side_road = 3'b100; end // Yellow Main, Red Side
            GREEN_MAIN:  begin main_road = 3'b001; side_road = 3'b100; end // Green Main, Red Side
            RED_SIDE:    begin main_road = 3'b001; side_road = 3'b100; end // Green Main, Red Side
            YELLOW_SIDE: begin main_road = 3'b100; side_road = 3'b010; end // Red Main, Yellow Side
            GREEN_SIDE:  begin main_road = 3'b100; side_road = 3'b001; end // Red Main, Green Side
            default:     begin main_road = 3'b100; side_road = 3'b100; end // Default to Red on both
        endcase
    end

endmodule
