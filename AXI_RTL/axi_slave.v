module axi_slave(
    input clk,
    input rst,
    
    output reg [31:0] read_data,
    output reg status,
    output reg fetch_done,
    output reg processing_done,
    output reg store_done,
    output reg read_done,
   
    input [31:0] wdata_a,
    input [31:0] wdata_b,
    input [31:0] waddr_a,
    input [31:0] waddr_b,
    input [31:0] waddr_output,
    input [31:0] vector_len_o,
    input wdvalid,
    input awvalid,
    output reg rvalid,
   
    input start_fetch,
    input start_compute,
    input start_write,
    input start_read
);

    reg [31:0] storage_a [0:31];     
    reg [31:0] storage_b [0:31];
    reg [31:0] storage_out [0:31];
    
    reg [31:0] result; 
    integer i;
    reg [5:0] counter;

    
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        processing_done <= 0;
        store_done <= 0;
        read_done <= 0;
        status <= 0;
        result <= 0;       
        
        for (i = 0; i < 32; i = i + 1) begin
            storage_a[i] <= 0;
            storage_b[i] <= 0;
            storage_out[i] <= 0;
        end
    end
end

always @(posedge clk or negedge rst) begin
        if (!rst) begin
            fetch_done <= 0;
            counter <= 0;
        end else if (start_fetch) begin    
            storage_a[counter] <= wdata_a;        
            storage_b[counter] <= wdata_b; 
            counter <= counter + 1;       
            fetch_done <= 1;
        end else begin
            fetch_done <= 0;  
        end
    end

    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            result <= 0;
            processing_done <= 0;
        end else if (start_compute) begin
            result = 0;
            for (i = 0; i < counter; i = i + 1) begin      
                result = result + (storage_a[i] * storage_b[i]); 
                $display("Result: %d, storage_a[%d] = %d, storage_b[%d] = %d", 
                         result, i, storage_a[i], i, storage_b[i]);
            end          
            processing_done <= 1; 
        end else begin
            processing_done <= 0;
        end
    end  

/*
    
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        fetch_done <= 0;
    end else if (start_fetch) begin    
      //  storage_a[waddr_a + i] <= wdata_a;        
      //  storage_b[waddr_b + i] <= wdata_b;
        storage_a[counter] <= wdata_a;        
        storage_b[counter] <= wdata_b; 
        counter <= counter + 1;       
        fetch_done <= 1;
        
    end else begin
        fetch_done <= 0;  // Ensure it resets properly
    end
end


   
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        result <= 0;
        processing_done <= 0;
    end else if (start_compute) begin
        result = 0;
        for (counter = 0; counter < vector_len_o; counter = counter + 1) begin      
         //   result = result + ($signed(storage_a[waddr_a]) * $signed(storage_b[waddr_b]));  
             result = result + (storage_a[counter] * storage_b[counter]); 
             $display("The value of result; %d ,storage_a = %d , storage_b = %d, wdata_b = %d, wdata_a = %d",result,storage_a[waddr_a], storage_b[waddr_b],wdata_b,wdata_a );
        end          
        processing_done <= 1; 
    end else begin
        processing_done <= 0;
    end
end  
*/
/*
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        result <= 0;
        processing_done <= 0;
        fetch_done <= 0;
    end else if (start_fetch) begin
        result = 0;
        for (i = 0; i < vector_len_o; i = i + 1) begin           
         storage_a[waddr_a+i] <= wdata_a;        
         storage_b[waddr_b+i] <= wdata_b;
         fetch_done <= 1;
         status <= 1;      
         //   result = result + ($signed(storage_a[waddr_a]) * $signed(storage_b[waddr_b]));  
             result = result + (storage_a[waddr_a+i] * storage_b[waddr_b+i]); 
             $display("The value of result",result);
        end          
        processing_done <= 1; 
        fetch_done  <= 1;
    end else begin
        processing_done <= 0;
        fetch_done <= 0;
    end
end */


 

    
    always @(posedge clk) begin
        if (start_write) begin
            storage_out[waddr_output] <= result;
            store_done <= 1;
        end else begin
            store_done <= 0;
        end
    end

    
    always @(posedge clk) begin
        if (start_read) begin
            read_data <= result;
            read_done <= 1;
            status <= 0;
            rvalid <= 1;
        end else begin
            read_done <= 0;
        end
    end

endmodule