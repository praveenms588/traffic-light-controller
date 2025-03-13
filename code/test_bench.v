module traffic_light_tb;

    reg clk;
    reg rst;
    wire [2:0] main_road;
    wire [2:0] side_road;

    // Instantiate the DUT (Device Under Test)
    traffic_light_controller dut (
        .clk(clk),
        .rst(rst),
        .main_road(main_road),
        .side_road(side_road)
    );

    // Clock Generation (50MHz)
    always #10 clk = ~clk; // Toggle clock every 10ns → 50MHz clock

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1; // Apply reset
        #100;     // Hold reset for 100ns
        rst = 0;  // Release reset

        // Run simulation for a sufficient duration to test all states
        #200_000_000; // Run for 200ms (adjust based on your FSM timings)
        $finish;     // End simulation
    end

    // Monitor output changes
    initial begin
        $monitor("Time=%0t | Main Road = %b | Side Road = %b", $time, main_road, side_road);
    end

endmodule
