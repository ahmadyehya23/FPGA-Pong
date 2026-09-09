module pong_engine (
    input logic clk,
    input logic reset,
    input logic enable,

    input logic left_up,
    input logic left_down,
    input logic right_up,
    input logic right_down,

    output logic [9:0] ball_x,
    output logic [9:0] ball_y,

    output logic [9:0] paddle_left_y,
    output logic [9:0] paddle_right_y,

    output logic [3:0] score_left,
    output logic [3:0] score_right
);

    parameter SCREEN_WIDTH  = 640;
    parameter SCREEN_HEIGHT = 480;

    parameter PADDLE_HEIGHT = 80;
    parameter PADDLE_SPEED  = 4;

    parameter BALL_SIZE  = 10;
    parameter BALL_SPEED = 2;

    parameter LEFT_PADDLE_X  = 20;
    parameter RIGHT_PADDLE_X = 610;

    logic ball_dx;
    logic ball_dy;

    always_ff @(posedge clk or posedge reset) begin

        if (reset) begin
            ball_x <= 320;
            ball_y <= 235;

            paddle_left_y  <= 200;
            paddle_right_y <= 200;

            ball_dx <= 1;
            ball_dy <= 1;

            score_left  <= 0;
            score_right <= 0;
        end

        else if (enable) begin

            // Left paddle movement
            if (left_up && paddle_left_y > 0)
                paddle_left_y <= paddle_left_y - PADDLE_SPEED;
            else if (left_down &&
                     paddle_left_y < SCREEN_HEIGHT - PADDLE_HEIGHT)
                paddle_left_y <= paddle_left_y + PADDLE_SPEED;

            // Right paddle movement
            if (right_up && paddle_right_y > 0)
                paddle_right_y <= paddle_right_y - PADDLE_SPEED;
            else if (right_down &&
                     paddle_right_y < SCREEN_HEIGHT - PADDLE_HEIGHT)
                paddle_right_y <= paddle_right_y + PADDLE_SPEED;

            // Ball movement
            if (ball_dx)
                ball_x <= ball_x + BALL_SPEED;
            else
                ball_x <= ball_x - BALL_SPEED;

            if (ball_dy)
                ball_y <= ball_y + BALL_SPEED;
            else
                ball_y <= ball_y - BALL_SPEED;

            // Top wall
            if (ball_y <= 0)
                ball_dy <= 1;

            // Bottom wall
            if (ball_y >= SCREEN_HEIGHT - BALL_SIZE)
                ball_dy <= 0;

            // Left paddle collision
            if ((ball_x <= LEFT_PADDLE_X + 10) &&
                (ball_x + BALL_SIZE >= LEFT_PADDLE_X) &&
                (ball_y + BALL_SIZE >= paddle_left_y) &&
                (ball_y <= paddle_left_y + PADDLE_HEIGHT))
                ball_dx <= 1;

            // Right paddle collision
            if ((ball_x + BALL_SIZE >= RIGHT_PADDLE_X) &&
                (ball_x <= RIGHT_PADDLE_X + 10) &&
                (ball_y + BALL_SIZE >= paddle_right_y) &&
                (ball_y <= paddle_right_y + PADDLE_HEIGHT))
                ball_dx <= 0;

            // Right player scores
            if (ball_x <= 0) begin
                score_right <= score_right + 1;

                ball_x <= 320;
                ball_y <= 235;

                ball_dx <= 1;
                ball_dy <= 1;
            end

            // Left player scores
            if (ball_x >= SCREEN_WIDTH - BALL_SIZE) begin
                score_left <= score_left + 1;

                ball_x <= 320;
                ball_y <= 235;

                ball_dx <= 0;
                ball_dy <= 1;
            end

        end
    end

endmodule