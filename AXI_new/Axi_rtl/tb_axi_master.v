`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gopi Chand Ananthu
// 
// Create Date: 19.02.2025 23:29:07
// Design Name: 
// Module Name: tb_axi_master
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module axi_master_tb;
    
    reg clk;
    reg rst;
    reg [31:0] vector_a_m;
    reg [31:0] vector_b_m;
    reg [31:0] vector_a_addr_m;
    reg [31:0] vector_b_addr_m;
    reg [31:0] vector_len_m;
    reg [31:0] output_addr_m;
    reg [31:0] read_data_addr_m;
    reg master_to_slave;
    
    wire [31:0] read_data;
    wire status;
    wire processing_done;
    wire store_done;
    wire read_done;
    
    reg [31:0] wdata_a_sm;
    reg [31:0] wdata_b_sm;
    reg [31:0] waddr_a_sm;
    reg [31:0] waddr_b_sm;
    reg [31:0] waddr_output_sm;
    reg [31:0] vector_len_o_sm;
    
    reg wdvalid;
    reg awvalid;
    wire rvalid;
    
    reg start_fetch;
    reg start_compute;
    reg start_write;
    reg start_read;
    
    wire [31:0] wdata_a_ms;
    wire [31:0] wdata_b_ms;
    wire [31:0] waddr_a_ms;
    wire [31:0] waddr_b_ms;
    wire [31:0] waddr_output_ms;
    wire [31:0] vector_len_o_ms;
    
    // Instantiate the DUT (Device Under Test)
    axi_master dut (
        .clk(clk),
        .rst(rst),
        .vector_a_m(vector_a_m),
        .vector_b_m(vector_b_m),
        .vector_a_addr_m(vector_a_addr_m),
        .vector_b_addr_m(vector_b_addr_m),
        .vector_len_m(vector_len_m),
        .output_addr_m(output_addr_m),
        .read_data_addr_m(read_data_addr_m),
        .master_to_slave(master_to_slave),
        .read_data(read_data),
        .status(status),
        .processing_done(processing_done),
        .store_done(store_done),
        .read_done(read_done),
        .wdata_a_sm(wdata_a_sm),
        .wdata_b_sm(wdata_b_sm),
        .waddr_a_sm(waddr_a_sm),
        .waddr_b_sm(waddr_b_sm),
        .waddr_output_sm(waddr_output_sm),
        .vector_len_o_sm(vector_len_o_sm),
        .wdvalid(wdvalid),
        .awvalid(awvalid),
        .rvalid(rvalid),
        .start_fetch(start_fetch),
        .start_compute(start_compute),
        .start_write(start_write),
        .start_read(start_read),
        .wdata_a_ms(wdata_a_ms),
        .wdata_b_ms(wdata_b_ms),
        .waddr_a_ms(waddr_a_ms),
        .waddr_b_ms(waddr_b_ms),
        .waddr_output_ms(waddr_output_ms),
        .vector_len_o_ms(vector_len_o_ms)
    );
    
    
    always #5 clk = ~clk;
    
    initial begin
       
        clk = 0;
        rst = 0;
        vector_a_m = 0;
        vector_b_m = 0;
        vector_a_addr_m = 0;
        vector_b_addr_m = 0;
        vector_len_m = 15;
        output_addr_m = 0;
        read_data_addr_m = 0;
       master_to_slave = 1;
        start_fetch = 0;
        start_compute = 0;
        start_write = 0;
        start_read = 0;
         wdvalid = 0;
         awvalid = 0;
        
        wdata_a_sm = 0;
        wdata_b_sm = 0;
        waddr_a_sm = 0;
        waddr_b_sm = 0;
        waddr_output_sm = 0;
        vector_len_o_sm = 0;
        
        
        #10 rst = 1;
        
        
       
        #10 start_fetch = 1;
        vector_a_m = 3;
        vector_b_m = 2;
        wdata_a_sm = 3;
        wdata_b_sm = 2;
        waddr_a_sm = 10;
        waddr_b_sm = 11;
        waddr_output_sm = 15;
        vector_len_o_sm = 8;
         wdvalid = 1;
         awvalid = 1;
      //  #10 start_fetch = 0;
        #10;
       // #10 start_fetch = 1;        
        vector_a_m = 5;
        vector_b_m = 4;
        
         #10;
       // #10 start_fetch = 1;        
        vector_a_m = 6;
        vector_b_m = 7;
         #10;
       // #10 start_fetch = 1;        
        vector_a_m = 3;
        vector_b_m = 8;
        #10 start_fetch = 0;
        
        
       
        #20;
        
      
        start_compute = 1;
        #10 start_compute = 0;
        
        
        #30;
        
        
        start_write = 1;
        #10 start_write = 0;
        
        
        #20;
        
      
        start_read = 1;
        #10 start_read = 0;
        
        
        #20; 
        
        
        
        master_to_slave = 0;   
        
        
        #10 start_fetch = 1;
        vector_a_m = 5;
        vector_b_m = 4;
        wdata_a_sm = 3;
        wdata_b_sm = 5;
        waddr_a_sm = 13;
        waddr_b_sm = 12;
        waddr_output_sm = 18;
        vector_len_o_sm = 7;
        #10;
        
        wdata_a_sm = 15;
        wdata_b_sm = 7;
        #10;
        
        wdata_a_sm = 9;
        wdata_b_sm = 3;
        
        #10 start_fetch = 0;
        
        
        #20;
        
        
        start_compute = 1;
         vector_a_m = 6;
        vector_b_m = 7;
        #10 start_compute = 0;
        
        
        #30;
        
        
        start_write = 1;
        #10 start_write = 0;
        
        
        #20;
        
        
        start_read = 1;
        #10 start_read = 0;
        
        
        #20; 
        
        
        #100 $stop;
    end
    
endmodule

