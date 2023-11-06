/*
    ######### TangNano9K #########
*/

module rio (
        output BLINK_LED,
        output EXPANSION0_SHIFTREG_CLOCK,
        output EXPANSION0_SHIFTREG_LOAD,
        output EXPANSION0_SHIFTREG_OUT,
        input EXPANSION0_SHIFTREG_IN,
        input sysclk
    );


    blink #(13500000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );



    // expansion_shiftreg
    wire [7:0] EXPANSION0_INPUT;
    wire [7:0] EXPANSION0_OUTPUT;
    wire EXPANSION0_SHIFTREG_OUT_INV;
    assign EXPANSION0_SHIFTREG_OUT = ~EXPANSION0_SHIFTREG_OUT_INV;
    wire EXPANSION0_SHIFTREG_IN_INV;
    assign EXPANSION0_SHIFTREG_IN_INV = ~EXPANSION0_SHIFTREG_IN;
    wire EXPANSION0_SHIFTREG_CLOCK_INV;
    assign EXPANSION0_SHIFTREG_CLOCK = ~EXPANSION0_SHIFTREG_CLOCK_INV;
    wire EXPANSION0_SHIFTREG_LOAD_INV;
    assign EXPANSION0_SHIFTREG_LOAD = ~EXPANSION0_SHIFTREG_LOAD_INV;

    // expansion_shiftreg
    wire [7:0] EXPANSION0_INPUT_RAW;
    assign EXPANSION0_INPUT = EXPANSION0_INPUT_RAW;
    wire [7:0] EXPANSION0_OUTPUT_RAW;
    assign EXPANSION0_OUTPUT_RAW = EXPANSION0_OUTPUT;
    expansion_shiftreg #(8, 135) expansion_shiftreg0 (
       .clk (sysclk),
       .SHIFT_OUT (EXPANSION0_SHIFTREG_OUT_INV),
       .SHIFT_IN (EXPANSION0_SHIFTREG_IN_INV),
       .SHIFT_CLK (EXPANSION0_SHIFTREG_CLOCK_INV),
       .SHIFT_LOAD (EXPANSION0_SHIFTREG_LOAD_INV),
       .data_in (EXPANSION0_INPUT_RAW),
       .data_out (EXPANSION0_OUTPUT_RAW)
    );
endmodule
