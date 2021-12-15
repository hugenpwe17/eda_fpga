//****************************************Copyright (c)***********************************//
//原子哥在线教学平台：www.yuanzige.com
//技术支持：www.openedv.com
//淘宝店铺：http://openedv.taobao.com 
//关注微信公众平台微信号："正点原子"，免费获取ZYNQ & FPGA & STM32 & LINUX资料。
//版权所有，盗版必究。
//Copyright(C) 正点原子 2018-2028
//All rights reserved
//----------------------------------------------------------------------------------------
// File name:           video_display
// Last modified Date:  2019/7/1 9:30:00
// Last Version:        V1.1
// Descriptions:        视频显示模块，显示彩条
//----------------------------------------------------------------------------------------
// Created by:          正点原子
// Created date:        2019/7/1 9:30:00
// Version:             V1.0
// Descriptions:        The original version
//
//----------------------------------------------------------------------------------------
//****************************************************************************************//

module  video_display(
    input                pixel_clk,
    input                sys_rst_n,
    input                pixel_flag,
    
    input        [10:0]  pixel_xpos,  //像素点横坐标
    input        [10:0]  pixel_ypos,  //像素点纵坐标
    output  reg  [23:0]  pixel_data   //像素点数据
);

//parameter define
parameter  H_DISP = 11'd1280;                       //分辨率——行
parameter  V_DISP = 11'd720;                        //分辨率——列

localparam WHITE  = 24'b11111111_11111111_11111111;  //RGB888 白色
localparam BLACK  = 24'b00000000_00000000_00000000;  //RGB888 黑色
localparam RED    = 24'b11111111_00001100_00000000;  //RGB888 红色
localparam GREEN  = 24'b00000000_11111111_00000000;  //RGB888 绿色
localparam Green  = 24'b00000000_01111111_00000000;  //淡绿色
localparam BLUE   = 24'b00000000_00000000_11111111;  //RGB888 蓝色

// wire
wire display_region;    // 显示区域信号
wire edge_region;       // 边框区域像素信号
    
//*****************************************************
//**                    main code
//*****************************************************

// 显示区域
assign display_region = ((pixel_xpos >= 140 - 1) && (pixel_xpos <= 1280 - 140) && (pixel_ypos >= 48) && (pixel_ypos <= 624)) ? 1'b1 : 1'b0;
// 边框区域
assign edge_region = ((pixel_xpos == 140 - 1) || (pixel_xpos == 1280 - 140) || (pixel_ypos == 48) || (pixel_ypos == 624)) ? 1'b1 : 1'b0;
// 坐标轴区域
assign axis_region = ((pixel_xpos == 640) || (pixel_ypos == 336)) ? 1'b1 : 1'b0;
// 网格区域
assign grid_region = ((((( pixel_xpos / 64 ) * 64 - pixel_xpos) == 0) && (pixel_ypos[0])) || ((((pixel_ypos / 48) * 48 - pixel_ypos) == 0) && (pixel_xpos[0]))) ? 1'b1 : 1'b0;

//根据当前像素点坐标指定当前像素点颜色数据，在屏幕上显示彩条
always @(posedge pixel_clk ) begin
    if (!sys_rst_n)
        pixel_data <= 16'd0;
    else begin
        if(pixel_flag)begin
            pixel_data <= RED;
        end
        else begin
            if(display_region) begin
                if(edge_region || axis_region) begin
                    pixel_data <= GREEN;
                end
                else if(grid_region) begin
                    pixel_data <= Green;
                end
                else begin
                    pixel_data <= BLACK;
                end
            end
            else begin
                pixel_data <= BLACK;
            end
        end  
    end
end

endmodule