`timescale 1ns/1ns
module main_tb;

reg clk;
reg rst_n;

reg W_ctrl;
reg A_ctrl;
reg P_ctrl;
reg F_ctrl;

wire [11:0] wave_out;

initial begin
    clk <= 1'b0;
    rst_n <= 1'b0;

    W_ctrl <= 1'b0;
    A_ctrl <= 1'b0;
    P_ctrl <= 1'b0;
    F_ctrl <= 1'b0;

    #100 rst_n <=1'b1;
    //
    #100000 W_ctrl <=1'b1;
    #100 W_ctrl <=1'b0;

    #100000 W_ctrl <=1'b1;
    #100 W_ctrl <=1'b0;

    #100000 W_ctrl <=1'b1;
    #100 W_ctrl <=1'b0;
    
    //
    #100000 A_ctrl <=1'b1;
    #100 A_ctrl <=1'b0;

    #100000 A_ctrl <=1'b1;
    #100 A_ctrl <=1'b0;

    #100000 A_ctrl <=1'b1;
    #100 A_ctrl <=1'b0;

    #100000 A_ctrl <=1'b1;
    #100 A_ctrl <=1'b0;

    //
    #100000 F_ctrl <=1'b1;
    #100 F_ctrl <=1'b0;
    
    #100000 F_ctrl <=1'b1;
    #100 F_ctrl <=1'b0;

    #100000 F_ctrl <=1'b1;
    #100 F_ctrl <=1'b0;
end

always #10 clk = ~clk;

main u_main(
    .clk    ( clk    ),
    .rst_n  ( rst_n  ),
    .W_ctrl ( W_ctrl ),
    .A_ctrl ( A_ctrl ),
    .P_ctrl ( P_ctrl ),
    .F_ctrl ( F_ctrl ),
    .wave_out  ( wave_out  )
);

endmodule