module tb_traffic_light_controller_4way;


    reg clk;
    reg rst;
    wire [2:0] north, south, east, west;


    traffic_light_controller_4way uut (
        .clk(clk),
        .rst(rst),
        .north(north),
        .south(south),
        .east(east),
        .west(west)
    );

    always #5 clk = ~clk;

    function [7*8:1] light_color(input [2:0] light);
        case (light)
            3'b100: light_color = "RED";
            3'b010: light_color = "YELLOW";
            3'b001: light_color = "GREEN";
            default: light_color = "UNKNOWN";
        endcase
    endfunction

    localparam SIM_TIME_NS = 200_000_000;  

    initial begin
 
        $dumpfile("traffic_light_4way.vcd");
        $dumpvars();

       
        clk = 0;
        rst = 1;
        
        #20;
        rst = 0;

        #(SIM_TIME_NS);

        $display("Simulation completed.");
        $finish;
    end

    always @(posedge clk) begin
        $display("Time: %0t ns | N: %s | S: %s | E: %s | W: %s",
            $time,
            light_color(north),
            light_color(south),
            light_color(east),
            light_color(west)
        );
    end

endmodule
