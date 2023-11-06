`timescale 1ns/100ps

module testb;

    reg BUTTON1 = 0;
    reg BUTTON2 = 0;
    reg BUTTON3 = 0;
    reg sysclk = 0;

    wire BLINK_LED;
    wire LED1;
    wire LED2;
    wire LED3;
    wire LED4;
    wire LED5;
    wire DOUT11;
    wire ENA;
    wire JOINT8_STEPPER_STP;
    wire JOINT8_STEPPER_DIR;
    wire JOINT9_STEPPER_STP;
    wire JOINT9_STEPPER_DIR;
    wire JOINT10_STEPPER_STP;
    wire JOINT10_STEPPER_DIR;

    always #2 sysclk = !sysclk;

    initial begin
        $dumpfile("testb.vcd");
        $dumpvars(0, BLINK_LED);
        $dumpvars(1, BUTTON1);
        $dumpvars(2, BUTTON2);
        $dumpvars(3, BUTTON3);
        $dumpvars(4, LED1);
        $dumpvars(5, LED2);
        $dumpvars(6, LED3);
        $dumpvars(7, LED4);
        $dumpvars(8, LED5);
        $dumpvars(9, DOUT11);
        $dumpvars(10, ENA);
        $dumpvars(11, JOINT8_STEPPER_STP);
        $dumpvars(12, JOINT8_STEPPER_DIR);
        $dumpvars(13, JOINT9_STEPPER_STP);
        $dumpvars(14, JOINT9_STEPPER_DIR);
        $dumpvars(15, JOINT10_STEPPER_STP);
        $dumpvars(16, JOINT10_STEPPER_DIR);
        $dumpvars(17, sysclk);

        # 100000 $finish;
    end

    rio rio1 (
        .BLINK_LED (BLINK_LED),
        .BUTTON1 (BUTTON1),
        .BUTTON2 (BUTTON2),
        .BUTTON3 (BUTTON3),
        .LED1 (LED1),
        .LED2 (LED2),
        .LED3 (LED3),
        .LED4 (LED4),
        .LED5 (LED5),
        .DOUT11 (DOUT11),
        .ENA (ENA),
        .JOINT8_STEPPER_STP (JOINT8_STEPPER_STP),
        .JOINT8_STEPPER_DIR (JOINT8_STEPPER_DIR),
        .JOINT9_STEPPER_STP (JOINT9_STEPPER_STP),
        .JOINT9_STEPPER_DIR (JOINT9_STEPPER_DIR),
        .JOINT10_STEPPER_STP (JOINT10_STEPPER_STP),
        .JOINT10_STEPPER_DIR (JOINT10_STEPPER_DIR),
        .sysclk (sysclk)
    );

endmodule
