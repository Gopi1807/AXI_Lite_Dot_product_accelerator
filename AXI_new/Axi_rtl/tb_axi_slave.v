`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gopi Chand Ananthu
// 
// Create Date: 20.02.2025 00:36:40
// Design Name: 
// Module Name: tb_axi_slave
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


module axi_slave_tb;
    
    reg clk;
    reg rst;
    reg start;
    reg [31:0] vector_a_s;
    reg [31:0] vector_b_s;
    reg [31:0] vector_a_addr_s;
    reg [31:0] vector_b_addr_s;
    reg [31:0] vector_len_s;
    reg [31:0] output_addr_s;
    reg [31:0] read_data_addr_s;
    reg master_to_slave;
    reg [31:0] read_data;
    reg status;
    reg processing_done;
    reg store_done;
    reg read_done;
    reg rvalid;
    reg [31:0] wdata_a_ms;
    reg [31:0] wdata_b_ms;
    reg [31:0] waddr_a_ms;
    reg [31:0] waddr_b_ms;
    reg [31:0] waddr_output_ms;
    reg [31:0] vector_len_o_ms;
    
    wire [31:0] wdata_a_sm;
    wire [31:0] wdata_b_sm;
    wire [31:0] waddr_a_sm;
    wire [31:0] waddr_b_sm;
    wire [31:0] waddr_output_sm;
    wire [31:0] vector_len_o_sm;
    wire start_fetch;
    wire start_compute;
    wire start_write;
    wire start_read;
    wire wdvalid;
    wire awvalid;
    
    
    axi_slave dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .vector_a_s(vector_a_s),
        .vector_b_s(vector_b_s),
        .vector_a_addr_s(vector_a_addr_s),
        .vector_b_addr_s(vector_b_addr_s),
        .vector_len_s(vector_len_s),
        .output_addr_s(output_addr_s),
        .read_data_addr_s(read_data_addr_s),
        .master_to_slave(master_to_slave),
        .read_data(read_data),
        .status(status),
        .processing_done(processing_done),
        .store_done(store_done),
        .read_done(read_done),
        .rdata(),
        .rvalid(rvalid),
        
        .wdata_a_ms(wdata_a_ms),
        .wdata_b_ms(wdata_b_ms),
        .waddr_a_ms(waddr_a_ms),
        .waddr_b_ms(waddr_b_ms),
        .waddr_output_ms(waddr_output_ms),
        .vector_len_o_ms(vector_len_o_ms),
        
        .wdata_a_sm(wdata_a_sm),
        .wdata_b_sm(wdata_b_sm),
        .waddr_a_sm(waddr_a_sm),
        .waddr_b_sm(waddr_b_sm),
        .waddr_output_sm(waddr_output_sm),
        .vector_len_o_sm(vector_len_o_sm),
        
        .start_fetch(start_fetch),
        .start_compute(start_compute),
        .start_write(start_write),
        .start_read(start_read),
        .wdvalid(wdvalid),
        .awvalid(awvalid)
    );
    
    
    always #5 clk = ~clk;
    
    initial begin
        
        clk = 0;
        rst = 0;
        start = 0;
        vector_a_s = 5;
        vector_b_s = 10;
        vector_a_addr_s = 32'h1000;
        vector_b_addr_s = 32'h2000;
        vector_len_s = 4;
        output_addr_s = 32'h3000;
        read_data_addr_s = 32'h4000;
        master_to_slave = 1;
        read_data = 0;
        status = 0;
        processing_done = 0;
        store_done = 0;
        read_done = 0;
        rvalid = 0;
        wdata_a_ms = 0;
        wdata_b_ms = 0;
        waddr_a_ms = 0;
        waddr_b_ms = 0;
        waddr_output_ms = 0;
        vector_len_o_ms = 0;
        
       
        #10 rst = 1;
        
       
        #10 start = 1;
        
        wdata_a_ms = 10;
        wdata_b_ms = 11;
        waddr_a_ms = 17;
        waddr_b_ms = 18;
        waddr_output_ms = 5;
        vector_len_o_ms = 6;
        #10 start = 0;
        
        
        
       
        
        
        #20;
        
        
        processing_done = 1;
        #10 processing_done = 0;
        
       
        store_done = 1;
        #10 store_done = 0;
        
        
        read_done = 1;
        rvalid = 1;
        read_data = 50;
        #10 read_done = 0;
        rvalid = 0;
        
         #10  master_to_slave = 0; 
          #10 rst = 1;
        
      
        #10 start = 1;
        
        wdata_a_ms = 10;
        wdata_b_ms = 11;
        waddr_a_ms = 17;
        waddr_b_ms = 18;
        waddr_output_ms = 5;
        vector_len_o_ms = 6;
        #10 start = 0;
        
        
        
       
        
        
        #20;
        
        
        processing_done = 1;
        #10 processing_done = 0;
        
        
        store_done = 1;
        #10 store_done = 0;
        
        
        read_done = 1;
        rvalid = 1;
        read_data = 50;
        #10 read_done = 0;
        rvalid = 0;
        
        
        #100 $stop;
    end
    
endmodule

