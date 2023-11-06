`timescale 1ns/100ps

module testb;

    reg sysclk_in = 0;

    wire BLINK_LED;

    always #2 sysclk = !sysclk;

    initial begin
        $dumpfile("testb.vcd");
        $dumpvars(0, BLINK_LED);
        $dumpvars(1, sysclk_in);

        # 100000 $finish;
    end

    rio rio1 (
        .BLINK_LED (BLINK_LED),
        .sysclk_in (sysclk_in)
    );

endmodule
