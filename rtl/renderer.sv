module renderer (
    input logic [9:0] pixel_x,
    input logic [9:0] pixel_y,

    input logic [9:0] ball_x,
    input logic [9:0] ball_y,

    input logic [9:0] paddle_left_y,
    input logic [9:0] paddle_right_y,

    output logic [3:0] red,
    output logic [3:0] green,
    output logic [3:0] blue
);

    parameter BALL_SIZE = 10;
    parameter PADDLE_WIDTH = 10;
    parameter PADDLE_HEIGHT = 80;

    parameter LEFT_PADDLE_X = 20;
    parameter RIGHT_PADDLE_X = 610;

    always_comb begin

        // Background
        red   = 0;
        green = 0;
        blue  = 0;

        // Ball
        if ((pixel_x >= ball_x) &&
            (pixel_x < ball_x + BALL_SIZE) &&
            (pixel_y >= ball_y) &&
            (pixel_y < ball_y + BALL_SIZE)) begin

            red   = 15;
            green = 15;
            blue  = 15;

        end

        // Left paddle
        else if ((pixel_x >= LEFT_PADDLE_X) &&
                 (pixel_x < LEFT_PADDLE_X + PADDLE_WIDTH) &&
                 (pixel_y >= paddle_left_y) &&
                 (pixel_y < paddle_left_y + PADDLE_HEIGHT)) begin

            red   = 15;
            green = 15;
            blue  = 15;

        end

        // Right paddle
        else if ((pixel_x >= RIGHT_PADDLE_X) &&
                 (pixel_x < RIGHT_PADDLE_X + PADDLE_WIDTH) &&
                 (pixel_y >= paddle_right_y) &&
                 (pixel_y < paddle_right_y + PADDLE_HEIGHT)) begin

            red   = 15;
            green = 15;
            blue  = 15;

        end

    end

endmodule