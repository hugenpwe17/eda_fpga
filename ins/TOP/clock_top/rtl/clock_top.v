module clock_top (
    input clk,
    input rst_n,

    output wire [5:0] sel,
    output wire [7:0] seg
);

    // wire
    wire [23:0] tm;
    wire [7:0] hr;
    wire [7:0] mn;
    wire [7:0] sd;

    clock#(
        .cnt_max ( 28'd500_000 )
    )u_clock(
        .clk   ( clk   ),
        .rst_n ( rst_n ),
        .hr    ( hr    ),
        .mn    ( mn    ),
        .sd    ( sd    )
    );

    assign tm = {hr,mn,sd};

    cnt_seg_dync#(
        .stay_time ( 16'd50_000 )
    )u_cnt_seg_dync(
        .clk   ( clk   ),
        .rst_n ( rst_n ),
        .num   ( tm    ),
        .sel   ( sel   ),
        .seg   ( seg   )
    );
    
endmodule