`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gopi Chand Ananthu
// 
// Create Date: 19.02.2025 10:41:58
// Design Name: 
// Module Name: axi_slave
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



module axi_slave(
    input clk,
    input rst,
    // Input to the Slave
    input start,
    input [31:0] vector_a_s,
    input [31:0] vector_b_s,    
    input [31:0] vector_a_addr_s,
    input [31:0] vector_b_addr_s,    
    input [31:0] vector_len_s,
    input [31:0] output_addr_s,
    input [31:0] read_data_addr_s,
    input master_to_slave,
    // Data from the Master
    input [31:0] read_data,
    input status,
  //  input fetch_done,
    input processing_done,
    input store_done,
    input read_done,
    // Output to the Data
    output reg [31:0] rdata,
    input rvalid,
    // Inputs from the Master
    input [31:0] wdata_a_ms,
    input [31:0] wdata_b_ms,
    input [31:0] waddr_a_ms,
    input [31:0] waddr_b_ms,
    input [31:0] waddr_output_ms,
    input [31:0] vector_len_o_ms,   
    // Outputs to the Master
    output reg [31:0] wdata_a_sm,
    output reg [31:0] wdata_b_sm,
    output reg [31:0] waddr_a_sm,
    output reg [31:0] waddr_b_sm,
    output reg [31:0] waddr_output_sm,
    output reg [31:0] vector_len_o_sm,
    // Control signals to master
    output reg start_fetch,
    output reg start_compute,
    output reg start_write,
    output reg start_read,
    output reg wdvalid,
    output reg awvalid
);

reg [2:0] state, next_state;


parameter IDLE         = 3'b000;
parameter START_STATE  = 3'b001;
parameter FETCH_STATE  = 3'b010;
parameter COMPUTE_STATE = 3'b011;
parameter WRITE_STATE  = 3'b100;
parameter READ_STATE   = 3'b101;


always @(posedge clk or negedge rst) begin
    if (!rst) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end


always @(*) begin
    case (state)
        IDLE: 
            if (start) begin
                next_state = START_STATE;
                end
            else begin
                next_state = IDLE;
             end  
           

            
        
        START_STATE:  
            next_state = FETCH_STATE;
        
        FETCH_STATE: 
     //       if (fetch_done)
                next_state = COMPUTE_STATE;
     //       else
     //           next_state = FETCH_STATE;

        COMPUTE_STATE: 
            if (processing_done) 
                next_state = WRITE_STATE;
            else 
                next_state = COMPUTE_STATE;

        WRITE_STATE: 
            if (store_done) 
                next_state = READ_STATE;
            else 
                next_state = WRITE_STATE;
        
        READ_STATE: 
            if (read_done) 
                next_state = IDLE;
            else 
                next_state = READ_STATE;

        default: 
            next_state = IDLE;
    endcase
end

// Output Logic
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        awvalid <= 0;
        wdvalid <= 0;
        wdata_a_sm <= 0;
        wdata_b_sm <= 0;
        waddr_a_sm <= 0;
        waddr_b_sm <= 0;
        waddr_output_sm <= 0;
        vector_len_o_sm <= 0;
        start_fetch <= 0;
        start_compute <= 0;
        start_write <= 0;
        start_read <= 0;
       
    end else begin
        
        start_fetch <= 0;
        start_compute <= 0;
        start_write <= 0;
        start_read <= 0;
        
        case (state)
            IDLE: begin
                awvalid <= 0;
                wdvalid <= 0;
            end
            
            START_STATE: begin
                if (master_to_slave) begin
                awvalid <= 1;
                wdvalid <= 1;
                wdata_a_sm <= wdata_a_ms;
                wdata_b_sm <= wdata_b_ms;
                waddr_a_sm <= waddr_a_ms;
                waddr_b_sm <= waddr_b_ms;
                waddr_output_sm <= waddr_output_ms;
                vector_len_o_sm <= vector_len_o_ms;
                end else  begin
                awvalid <= 1;
                wdvalid <= 1;
                wdata_a_sm <= vector_a_s;
                wdata_b_sm <= vector_b_s;
                waddr_a_sm <= vector_a_addr_s;
                waddr_b_sm <= vector_b_addr_s;
                waddr_output_sm <= output_addr_s;
                vector_len_o_sm <= vector_len_s;
                end
            $display("wdata_a_sm = %d, wdata_b_sm = %d, waddr_a_sm = %d,waddr_b_sm = %d,waddr_output_sm = %d,vector_len_o_sm = %d",
                                               wdata_a_sm,wdata_b_sm , waddr_a_sm, waddr_b_sm, waddr_output_sm,vector_len_o_sm);                
            end
            
            FETCH_STATE: begin
                start_fetch <= 1;
                $display("start_fetch = %d",start_fetch); 
                
            end
            
            COMPUTE_STATE: begin
                start_compute <= 1;
                 $display("start_compute = %d",start_compute); 
             
            end
            
            WRITE_STATE: begin
                start_write <= 1;
                $display("start_write = %d",start_write); 
            end
            
            READ_STATE: begin
                start_read <= 1;
               
                if (rvalid) begin
                rdata <= read_data;
                end
                $display("start_read = %d,rdata = %d",start_read,rdata);
            end
        endcase
    end
end

endmodule

