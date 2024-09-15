module top
(
    input clk,          /* 27 MHz clock input */
    output [5:0] led    /* 6 on-board LEDs */
);

localparam WAIT_TIME = 27000000;    /* to generate 1 second delay */
reg [5:0] ledCounter = 0;
reg [24:0] clockCounter = 0;        /* must hold at least the value 27 000 000, hence 25 bits */

/* every clock tick, increment the clockCounter variable.
 * if we count 27 000 000 times (WAIT_TIME), then we know 1 second has passed
 * and we reset the counter and increment our ledCounter variable */
always @(posedge clk) begin
    clockCounter <= clockCounter + 1;
    if (clockCounter == WAIT_TIME) begin
        clockCounter <= 0;
        ledCounter <= ledCounter + 1;
    end
end

assign led = ~ledCounter;   /* display ledCounter to the LEDs, inverted because active-low LEDs */

endmodule