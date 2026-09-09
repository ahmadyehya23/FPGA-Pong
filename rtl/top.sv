module top (
    input logic CLOCK_50,
    input logic [3:0] KEY,

    output logic VGA_HS,
    output logic VGA_VS,

    output logic [3:0] VGA_R,
    output logic [3:0] VGA_G,
    output logic [3:0] VGA_B
);

    logic reset;

    logic game_enable;

    logic [9:0] pixel_x;
    logic [9:0] pixel_y;

    logic video_on;

    logic [9:0] ball_x;
    logic [9:0] ball_y;

    logic [9:0] paddle_left_y;
    logic [9:0] paddle_right_y;

    logic [3:0] score_left;
    logic [3:0] score_right;

    logic left_up;
    logic left_down;
    logic right_up;
    logic right_down;

    logic [3:0] red;
    logic [3:0] green;
    logic [3:0] blue;


    assign reset = ~KEY[0];

    assign left_up    = ~KEY[1];
    assign left_down  = ~KEY[2];

    assign right_up   = 1'b0;
    assign right_down = 1'b0;


    clock_enable clock_enable_inst (
        .clk(CLOCK_50),
        .reset(reset),
        .enable(game_enable)
    );


    vga_controller vga_controller_inst (
        .clk(CLOCK_50),
        .reset(reset),

        .hsync(VGA_HS),
        .vsync(VGA_VS),

        .pixel_x(pixel_x),
        .pixel_y(pixel_y),

        .video_on(video_on)
    );


    pong_engine pong_engine_inst (
        .clk(CLOCK_50),
        .reset(reset),
        .enable(game_enable),

        .left_up(left_up),
        .left_down(left_down),
        .right_up(right_up),
        .right_down(right_down),

        .ball_x(ball_x),
        .ball_y(ball_y),

        .paddle_left_y(paddle_left_y),
        .paddle_right_y(paddle_right_y),

        .score_left(score_left),
        .score_right(score_right)
    );


    renderer renderer_inst (
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),

        .ball_x(ball_x),
        .ball_y(ball_y),

        .paddle_left_y(paddle_left_y),
        .paddle_right_y(paddle_right_y),

        .red(red),
        .green(green),
        .blue(blue)
    );


    always_comb begin

        if (video_on) begin
            VGA_R = red;
            VGA_G = green;
            VGA_B = blue;
        end
        else begin
            VGA_R = 0;
            VGA_G = 0;
            VGA_B = 0;
        end

    end

endmodule