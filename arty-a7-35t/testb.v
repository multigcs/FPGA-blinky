`timescale 1ns/100ps

module testb;

    reg HOME_X = 0;
    reg HOME_Y = 0;
    reg HOME_Z = 0;
    reg E_STOP = 0;
    reg INTERFACE_SPI_MOSI = 0;
    reg INTERFACE_SPI_SCK = 0;
    reg INTERFACE_SPI_SSEL = 0;
    reg sysclk = 0;

    wire BLINK_LED;
    wire SPINDLE_ENABLE;
    wire COOLANT;
    wire ENA;
    wire INTERFACE_SPI_MISO;
    wire JOINT6_STEPPER_STP;
    wire JOINT6_STEPPER_DIR;
    wire JOINT7_STEPPER_STP;
    wire JOINT7_STEPPER_DIR;
    wire JOINT8_STEPPER_STP;
    wire JOINT8_STEPPER_DIR;

    always #2 sysclk = !sysclk;

    initial begin
        $dumpfile("testb.vcd");
        $dumpvars(0, BLINK_LED);
        $dumpvars(1, HOME_X);
        $dumpvars(2, HOME_Y);
        $dumpvars(3, HOME_Z);
        $dumpvars(4, E_STOP);
        $dumpvars(5, SPINDLE_ENABLE);
        $dumpvars(6, COOLANT);
        $dumpvars(7, ENA);
        $dumpvars(8, INTERFACE_SPI_MOSI);
        $dumpvars(9, INTERFACE_SPI_MISO);
        $dumpvars(10, INTERFACE_SPI_SCK);
        $dumpvars(11, INTERFACE_SPI_SSEL);
        $dumpvars(12, JOINT6_STEPPER_STP);
        $dumpvars(13, JOINT6_STEPPER_DIR);
        $dumpvars(14, JOINT7_STEPPER_STP);
        $dumpvars(15, JOINT7_STEPPER_DIR);
        $dumpvars(16, JOINT8_STEPPER_STP);
        $dumpvars(17, JOINT8_STEPPER_DIR);
        $dumpvars(18, sysclk);

        # 100000 $finish;
    end

    rio rio1 (
        .BLINK_LED (BLINK_LED),
        .HOME_X (HOME_X),
        .HOME_Y (HOME_Y),
        .HOME_Z (HOME_Z),
        .E_STOP (E_STOP),
        .SPINDLE_ENABLE (SPINDLE_ENABLE),
        .COOLANT (COOLANT),
        .ENA (ENA),
        .INTERFACE_SPI_MOSI (INTERFACE_SPI_MOSI),
        .INTERFACE_SPI_MISO (INTERFACE_SPI_MISO),
        .INTERFACE_SPI_SCK (INTERFACE_SPI_SCK),
        .INTERFACE_SPI_SSEL (INTERFACE_SPI_SSEL),
        .JOINT6_STEPPER_STP (JOINT6_STEPPER_STP),
        .JOINT6_STEPPER_DIR (JOINT6_STEPPER_DIR),
        .JOINT7_STEPPER_STP (JOINT7_STEPPER_STP),
        .JOINT7_STEPPER_DIR (JOINT7_STEPPER_DIR),
        .JOINT8_STEPPER_STP (JOINT8_STEPPER_STP),
        .JOINT8_STEPPER_DIR (JOINT8_STEPPER_DIR),
        .sysclk (sysclk)
    );

endmodule
