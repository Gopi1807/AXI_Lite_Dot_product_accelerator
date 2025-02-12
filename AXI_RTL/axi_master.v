`timescale 1ns/1ps

module axi_master(
    input clk,
    input rst,
    
    input start,
    input [31:0] vector_a,
    input [31:0] vector_b,    
    input [31:0] vector_a_addr,
    input [31:0] vector_b_addr,    
    input [31:0] vector_len,
    input [31:0] output_addr,
    input [31:0] read_data_addr,
  
    input [31:0] read_data,
    input status,
  //  input fetch_done,
    input processing_done,
    input store_done,
    input read_done,
   
    output reg [31:0] rdata,
    input rvalid,
    
    output reg [31:0] wdata_a,
    output reg [31:0] wdata_b,
    output reg [31:0] waddr_a,
    output reg [31:0] waddr_b,
    output reg [31:0] waddr_output,
    output reg [31:0] vector_len_o,
    output reg wdvalid,
    output reg awvalid,
    
    output reg start_fetch,
    output reg start_compute,
    output reg start_write,
    output reg start_read
);

reg [2:0] state, next_state;


parameter IDLE         = 3'b000;
parameter START_STATE  = 3'b001;
parameter FETCH_STATE  = 3'b010;
parameter COMPUTE_STATE = 3'b011;
parameter WRITE_STATE  = 3'b100;
parameter READ_STATE   = 3'b101;

// State transition logic
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Next State Logic
always @(*) begin
    case (state)
        IDLE: 
            if (start) 
                next_state = START_STATE;
            else 
                next_state = IDLE;
        
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
        wdata_a <= 0;
        wdata_b <= 0;
        waddr_a <= 0;
        waddr_b <= 0;
        waddr_output <= 0;
        vector_len_o <= 0;
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
                awvalid <= 1;
                wdvalid <= 1;
                wdata_a <= vector_a;
                wdata_b <= vector_b;
                waddr_a <= vector_a_addr;
                waddr_b <= vector_b_addr;
                waddr_output <= output_addr;
                vector_len_o <= vector_len;
                
            end
            
            FETCH_STATE: begin
                start_fetch <= 1;
                
            end
            
            COMPUTE_STATE: begin
                start_compute <= 1;
             
            end
            
            WRITE_STATE: begin
                start_write <= 1;
            end
            
            READ_STATE: begin
                start_read <= 1;
               
                if (rvalid) begin
                rdata <= read_data;
                end
            end
        endcase
    end
end

endmodule
