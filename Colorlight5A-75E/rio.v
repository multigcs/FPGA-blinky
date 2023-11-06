/*
    ######### Colorlight5A-75E #########
*/

module rio (
        output BLINK_LED,
        output EXPANSION0_SHIFTREG_CLOCK,
        output EXPANSION0_SHIFTREG_LOAD,
        output EXPANSION0_SHIFTREG_OUT,
        input EXPANSION0_SHIFTREG_IN,
        input sysclk_in
    );


    wire sysclk;
    wire locked;
    pll mypll(sysclk_in, sysclk, locked);

    blink #(50000000) blink1 (
        .clk (sysclk),
        .led (BLINK_LED)
    );



    // expansion_shiftreg
    wire [7:0] EXPANSION0_INPUT;
    wire [7:0] EXPANSION0_OUTPUT;

    // expansion_shiftreg
    wire [7:0] EXPANSION0_INPUT_RAW;
    assign EXPANSION0_INPUT = EXPANSION0_INPUT_RAW;
    wire [7:0] EXPANSION0_OUTPUT_RAW;
    assign EXPANSION0_OUTPUT_RAW = EXPANSION0_OUTPUT;
    expansion_shiftreg #(8, 2) expansion_shiftreg0 (
       .clk (sysclk),
       .SHIFT_OUT (EXPANSION0_SHIFTREG_OUT),
       .SHIFT_IN (EXPANSION0_SHIFTREG_IN),
       .SHIFT_CLK (EXPANSION0_SHIFTREG_CLOCK),
       .SHIFT_LOAD (EXPANSION0_SHIFTREG_LOAD),
       .data_in (EXPANSION0_INPUT_RAW),
       .data_out (EXPANSION0_OUTPUT_RAW)
    );
endmodule
