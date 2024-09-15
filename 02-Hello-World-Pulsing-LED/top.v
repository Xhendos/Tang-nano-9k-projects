module top
(
    input clk,          /* 27 MHz clock input */
    output [5:0] led    /* 6 on-board LEDs */
);

localparam WAIT_TIME = 27000000 / 8;    /* to generate 125 ms delay */
reg [5:0] ledCounter = 0;
reg [24:0] clockCounter = 0;            /* must hold at least the value 27 000 000, hence 25 bits */

/* every clock tick, increment the clockCounter variable.
 * if we count WAIT_TIME times then we know 125 ms have passed
 * and we reset the counter and increment our ledCounter variable */
always @(posedge clk) begin
    clockCounter <= clockCounter + 1;
    if (clockCounter == WAIT_TIME) begin
        clockCounter <= 0;
        ledCounter <= ledCounter + 1;

        led <= ~(6'b000001 << ledCounter);

        if(ledCounter == 5) begin       /* maximum shifts since we have 6 LEDs. Reset the ledCounter */
            ledCounter <= 0;
        end
    end
end

endmodule
