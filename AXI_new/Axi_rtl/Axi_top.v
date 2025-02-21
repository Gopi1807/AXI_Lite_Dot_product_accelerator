`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gopi Chand Ananthu
// 
// Create Date: 19.02.2025 15:13:08
// Design Name: 
// Module Name: axi_top
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


    

module axi_top(
    input clk,
    input rst,
    input start,
    input master_to_slave,
    
    // Inputs for Master
    input [31:0] vector_a_m,
    input [31:0] vector_b_m,    
    input [31:0] vector_a_addr_m,
    input [31:0] vector_b_addr_m,    
    input [31:0] vector_len_m,
    input [31:0] output_addr_m,
    input [31:0] read_data_addr_m,
    
    // Inputs for Slave
    input [31:0] vector_a_s,
    input [31:0] vector_b_s,    
    input [31:0] vector_a_addr_s,
    input [31:0] vector_b_addr_s,    
    input [31:0] vector_len_s,
    input [31:0] output_addr_s,
    input [31:0] read_data_addr_s,
    
    // Output result
   // output [31:0] result_data,
       output [31:0] rdata
);

    wire [31:0] wdata_a_sm, wdata_b_sm, waddr_a_sm, waddr_b_sm, waddr_output_sm, vector_len_o_sm;
    wire [31:0] wdata_a_ms, wdata_b_ms, waddr_a_ms, waddr_b_ms, waddr_output_ms, vector_len_o_ms;
    wire [31:0] read_data;
    wire processing_done, store_done, read_done, status;
    wire start_fetch, start_compute, start_write, start_read;
    wire wdvalid, awvalid, rvalid;
    wire [31:0] rdata;

    axi_master master_inst (
        .clk(clk),
        .rst(rst),
        .vector_a_m(vector_a_m),
        .vector_b_m(vector_b_m),
        .vector_a_addr_m(vector_a_addr_m),
        .vector_b_addr_m(vector_b_addr_m),
        .vector_len_m(vector_len_m),
        .output_addr_m(output_addr_m),
        
        .read_data_addr_m(read_data_addr),
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

    axi_slave slave_inst (
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
        .awvalid(awvalid),
        .rdata(rdata)
    );

  
    
endmodule

