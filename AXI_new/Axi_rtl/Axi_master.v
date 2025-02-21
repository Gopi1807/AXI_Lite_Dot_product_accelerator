`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gopi Chand Ananthu
// 
// Create Date: 19.02.2025 10:41:58
// Design Name: 
// Module Name: axi_master
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

module axi_master(
    input clk,
    input rst,
    //input start_m,
    input [31:0] vector_a_m,
    input [31:0] vector_b_m,    
    input [31:0] vector_a_addr_m,
    input [31:0] vector_b_addr_m,    
    input [31:0] vector_len_m,
    input [31:0] output_addr_m,
    input [31:0] read_data_addr_m,
    input master_to_slave,
    
    output reg [31:0] read_data,
    output reg status,
    output reg processing_done,
    output reg store_done,
    output reg read_done,
   
    input [31:0] wdata_a_sm,
    input [31:0] wdata_b_sm,
    input [31:0] waddr_a_sm,
    input [31:0] waddr_b_sm,
    input [31:0] waddr_output_sm,
    input [31:0] vector_len_o_sm,

    input wdvalid,
    input awvalid,
    output reg rvalid,
   
    input start_fetch,
    input start_compute,
    input start_write,
    input start_read,

    output reg [31:0] wdata_a_ms,
    output reg [31:0] wdata_b_ms,
    output reg [31:0] waddr_a_ms,
    output reg [31:0] waddr_b_ms,
    output reg [31:0] waddr_output_ms,
    output reg [31:0] vector_len_o_ms
);

    reg [31:0] storage_a [0:31];     
    reg [31:0] storage_b [0:31];
    reg [31:0] storage_out [0:31];
   // reg [31:0] temp_result [31:0];
     reg [31:0] memory_a [0:31];
     reg [31:0] memory_b [0:31]; 
    
    reg [31:0] result; 
    reg fetch_done;
    integer i;
    reg [5:0] counter;



    always @(*) begin
        wdata_a_ms = vector_a_m;
        wdata_b_ms = vector_b_m;
        waddr_a_ms = vector_a_addr_m;
        waddr_b_ms = vector_b_addr_m;
        waddr_output_ms = output_addr_m;
        vector_len_o_ms = vector_len_m;
        $display("wdata_a_ms: %d,wdata_b_ms = %d,waddr_a_ms = %d,waddr_b_ms = %d,waddr_output_ms = %d,vector_len_o_ms = %s",wdata_a_ms,wdata_b_ms,waddr_a_ms,waddr_b_ms,
                 waddr_output_ms,vector_len_o_ms);
    end


always @(posedge clk or negedge rst) begin
    if (!rst) begin
        processing_done <= 0;
        store_done <= 0;
        read_done <= 0;
        status <= 0;
        result <= 0;
        fetch_done <= 0;
        counter <= 0;
        rvalid <= 0;

        for (i = 0; i < 32; i = i + 1) begin
            storage_a[i] <= 0;
            storage_b[i] <= 0;
            storage_out[i] <= 0;
        end
    end 
    else if (master_to_slave) begin
        if (start_fetch) begin
            storage_a[counter] <= vector_a_m;        
            storage_b[counter] <= vector_b_m;
            counter <= counter + 1;
            
            if (counter == vector_len_m - 1) begin
                fetch_done <= 1;
            end
        end
        else if (start_compute) begin
            result = 0; 
            for (i = 0; i < counter; i = i + 1) begin      
                result = result + (storage_a[i] * storage_b[i]); 
                $display("Result: %d, storage_a[%d] = %d, storage_b[%d] = %d", result, i, storage_a[i], i, storage_b[i]);
            end          
            processing_done <= 1; 
        end
        else if (start_write) begin
            storage_out[waddr_output_sm] <= result; 
            memory_a[vector_a_addr_m] <= vector_a_m;
            memory_b[vector_b_addr_m] <= vector_b_m;              
            store_done <= 1;
            $display("storage_out[%d] = %d, store_done = %d", waddr_output_sm, storage_out[waddr_output_sm], store_done);
        end
        else if (start_read) begin
            read_data <= result;
            read_done <= 1;
            status <= 0;
            rvalid <= 1;
            $display("read_data: %d, read_done = %d", read_data, read_done);            
        end
    end 
    else if (!master_to_slave) begin
        if (start_fetch) begin 
            storage_a[counter] <= wdata_a_sm;        
            storage_b[counter] <= wdata_b_sm; 
            counter <= counter + 1;            
            if (counter == vector_len_o_ms - 1) begin
                fetch_done <= 1;
            end
        end
        else if (start_compute) begin
            result = 0; 
            for (i = 0; i < counter; i = i + 1) begin      
                result = result + (storage_a[i] * storage_b[i]); 
                $display("Result: %d, storage_a[%d] = %d, storage_b[%d] = %d", result, i, storage_a[i], i, storage_b[i]);
            end          
            processing_done <= 1; 
        end
        else if (start_write) begin
            storage_out[waddr_output_ms] <= result;  
            memory_a[vector_a_addr_m] <= wdata_a_sm;
            memory_b[vector_b_addr_m] <= wdata_b_sm;              
            store_done <= 1;
            $display("storage_out[%d] = %d, store_done = %d", waddr_output_sm, storage_out[waddr_output_sm], store_done);
        end
        else if (start_read) begin
            read_data <= result;
            read_done <= 1;
            status <= 0;
            rvalid <= 1;
            $display("read_data: %d, read_done = %d", read_data, read_done);            
        end
    end
end

 
 endmodule
     


