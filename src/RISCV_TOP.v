////////////////
//// RISCV-32 TOP MODULE 
////////////////

`timescale 1ps/1ps 

module RISCV_TOP(

			output dm_we ,
			output [31:0] pc ,  MEM_wDATA, 
			output [7:0]MEM_addr, 
			
			input clk, rset,
			input [31:0] ins, MEM_rData
			
			); 



		wire beq, pc_sel, RF_we, a_sel, b_sel;
		wire [2:0] imm_sel;
		wire [3:0] alu_sel;
		wire [1:0] wb_sel ;

     Control_Unit ctrl (.ins(ins),
                   .beq(beq),
				   .pcsel(pc_sel),
				   .imm_sel(imm_sel),
				   .RF_we(RF_we),
				   .a_sel(a_sel),
				   .b_sel(b_sel),
				   .alu_sel(alu_sel),
				   .dm_we(dm_we),
				   .wb_sel(wb_sel));
				   
	
	 DATA_PATH dp (.clk(clk),
				 .rest(rset),
				 .pc_sel(pc_sel),
				 .imm_sel(imm_sel),
				 .wb_sel(wb_sel),
				 .RF_we(RF_we),
				 .a_sel(a_sel),
				 .b_sel(b_sel),
				 .alu_sel(alu_sel),
				 .beq(beq),
				 .ins(ins),
				 .pc(pc),
				 .MEM_addr(MEM_addr),
				 .MEM_rData(MEM_rData),
				 .MEM_wDATA(MEM_wDATA));
						   
					   
				   
endmodule