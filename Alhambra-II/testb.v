`timescale 1ns/100ps

module testb;

    reg sysclk = 0;

    wire BLINK_LED;

    always #2 sysclk = !sysclk;

    initial begin
        $dumpfile("testb.vcd");
        $dumpvars(0, BLINK_LED);
        $dumpvars(1, sysclk);

        # 100000 $finish;
    end

    rio rio1 (
        .BLINK_LED (BLINK_LED),
        .sysclk (sysclk)
    );

endmodule
