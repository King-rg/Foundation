/*=================================================================================================================================================================================
   Design       : Dual-port RAM

   Description  : Fully synthesisable and configurable Dual-port RAM. One write port & read port.
                  - Infers Dual-port Block RAM on FPGA synthesisers.
                  - Configurable Data width.
                  - Configurable Depth.
                  
   Developer    : Mitu Raj, chip@chipmunklogic.com at Chipmunk Logic ™, https://chipmunklogic.com
   Date         : Feb-01-2021
=================================================================================================================================================================================*/

module dual_port_RAM   #(
                    /* Global Parameters */
                    parameter DATA_W           = 8                    ,        // Data width
                    parameter DEPTH            = 8                    ,        // Depth

                    /* Dependent Parameters */
                    parameter ADDR_W           = $clog2 (DEPTH)                // Address width 
                 )

                 (
                    /* Global */                  
                    input  logic                  clk                 ,        // Clock                    
                                       
                    /* Write Port*/
                    input  logic                  i_wren              ,        // Write Enable
                    input  logic [ADDR_W - 1 : 0] i_waddr             ,        // Write-address                    
                    input  logic [DATA_W - 1 : 0] i_wdata             ,        // Write-data 
                    
                    /* Read Port */
                    input  logic [ADDR_W - 1 : 0] i_raddr             ,        // Read-address                   
                    output logic [DATA_W - 1 : 0] o_rdata                      // Read-data                   
                 );

(* ram_style ="block" *)
logic [DATA_W - 1 : 0] data_rg [DEPTH] ;        // Data array

always @ (posedge clk) begin
              
   if (i_wren) begin                          
         
      data_rg [i_waddr] <= i_wdata  ;      

   end

end

always @ (posedge clk) begin
   
   o_rdata <= data_rg [i_raddr] ;
      
end


endmodule