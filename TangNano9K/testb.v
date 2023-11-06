`timescale 1ns/100ps

module testb;

    reg EXPANSION0_SHIFTREG_IN = 0;
    reg sysclk = 0;

    wire BLINK_LED;
    wire EXPANSION0_SHIFTREG_CLOCK;
    wire EXPANSION0_SHIFTREG_LOAD;
    wire EXPANSION0_SHIFTREG_OUT;

    always #2 sysclk = !sysclk;

    initial begin
        $dumpfile("testb.vcd");
        $dumpvars(0, BLINK_LED);
        $dumpvars(1, EXPANSION0_SHIFTREG_CLOCK);
        $dumpvars(2, EXPANSION0_SHIFTREG_LOAD);
        $dumpvars(3, EXPANSION0_SHIFTREG_OUT);
        $dumpvars(4, EXPANSION0_SHIFTREG_IN);
        $dumpvars(5, sysclk);

        # 100000 $finish;
    end

    rio rio1 (
        .BLINK_LED (BLINK_LED),
        .EXPANSION0_SHIFTREG_CLOCK (EXPANSION0_SHIFTREG_CLOCK),
        .EXPANSION0_SHIFTREG_LOAD (EXPANSION0_SHIFTREG_LOAD),
        .EXPANSION0_SHIFTREG_OUT (EXPANSION0_SHIFTREG_OUT),
        .EXPANSION0_SHIFTREG_IN (EXPANSION0_SHIFTREG_IN),
        .sysclk (sysclk)
    );

endmodule
