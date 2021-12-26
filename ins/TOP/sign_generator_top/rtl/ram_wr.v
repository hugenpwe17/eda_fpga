module ram_wr(
    input               clk,           //时钟信号
    input               rst_n,         //复位信号，低电平有效
    input wire [11:0]   wave_out,
                                    
    //RAM写端口操作                 
    output              ram_wr_en,     //ram写使能
    output reg [9:0]    ram_wr_addr,   //ram写地址        
    output reg [11:0]   ram_wr_data    //ram写数据
);

//*****************************************************
//**                    main code
//*****************************************************

// //wr_cnt计数范围在0~31,ram_wr_en为高电平
// assign ram_wr_en = ((wr_cnt>=10'd0) && (wr_cnt<=10'd1023) && rst_n) ? 1'b1 : 1'b0;
assign ram_wr_en = 1'b1;

//写地址信号 范围:0~31        
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        ram_wr_addr <= 10'd0;
        ram_wr_data <= 12'd0;
    end         
    else if(ram_wr_addr >= 10'd0 && ram_wr_addr <= 10'd1023) begin
        ram_wr_addr <= ram_wr_addr + 1'b1;
        ram_wr_data <= wave_out;
    end
    else begin
        ram_wr_addr <= 10'd0;
        ram_wr_data <= 12'd0;
    end
        
end        

endmodule