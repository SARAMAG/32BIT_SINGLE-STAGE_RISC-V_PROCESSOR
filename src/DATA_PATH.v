 //////////////////
 ///// DATA PATH 
 /////////////////////
 
 
 
 `timescale 1ps/1ps 
 
  module DATA_PATH (
			output beq , 
			
			output [31:0] pc, MEM_wDATA, 
			output [7:0]MEM_addr, 
			
			input clk , rest, pc_sel , a_sel , b_sel , RF_we,
			
			input [1:0]wb_sel , 
			
			input [2:0]imm_sel, 
			
			input [3:0]alu_sel , 
			
			input [31:0] ins , MEM_rData 
 
  ); 
		  /***********PC *********/
		  wire [31:0] PC_NXT, PC_PLS4, PCi; 
		  
		  /*********INPUT DATA **********/
		  wire [31:0] rs1, rs2, wDATAs1, wDATAs2; 
		  
			/*******I TYPE *********/
			
		 wire [31:0]imm;
		 wire [31:0] ALU_rs1, ALU_rs2 , ALU_rd;
		 
	 /****************************************/
	 
	 
	 
	 /***********PC CURRET STATE **************/
	 assign pc=PCi; 
	 
	 assign MEM_addr = ALU_rd [7:0]; 
	 
	 assign MEM_wDATA = rs2; 
	 
	 /***************PC NEXT STATE ******************/
		PCREG  PCREg ( .dout(PCi) , .rest(rest),.clk(clk), .din(PC_NXT) );
		
		adder PCP4 (.PC_pLUS4(PC_PLS4), .PC(PCi), .b(32'b100) );
		
		MUX   PCMUX  ( .M_out(PC_NXT) , .M_IN1(PC_PLS4), .M_in2( ALU_rd) , .sel(pc_sel)) ;
		
		/************REGISTER FILE *******************/
		
		RF  rf(.r_data1(rs1), .r_data2(rs2), .clk(clk), .we(RF_we),  .r_add1(ins[19:15]), .r_add2(ins[24:20]), .w_add(ins[11:7]), .w_data(wDATAs2)  );
		
		/*************BRANCHING ****************/

		 BR_COMP  bc( .beq(beq) , .rs1(rs1) , .rs2(rs2) ); 
		 
		
		 imm_gen img( .imm(imm), .ins(ins), .imm_sel(imm_sel));
		 
		 
		 /***********ALU ************/
		 
		 MUX   AMUX( .M_out(ALU_rs1) , .M_IN1(rs1), .M_in2( PCi) , .sel(a_sel)) ;
		 
		 MUX  BMUX ( .M_out(ALU_rs2) , .M_IN1(rs2), .M_in2( imm) , .sel(b_sel)) ;
		 
		 ALU  alu ( .rd(ALU_rd), .rs1(ALU_rs1), .rs2(ALU_rs2), .alu_sel(alu_sel));
		
		/************ WRITE BACK *************/
		
		 MUX   wbmux1( .M_out(wDATAs1) , .M_IN1(MEM_rData), .M_in2( ALU_rd) , .sel(wb_sel[0])) ; //00>>>mem_data 01>>>alu  >>10 >> pc+4
		 
		 MUX   wbmux2( .M_out(wDATAs2) , .M_IN1(wDATAs1), .M_in2( PC_PLS4) , .sel(wb_sel[1])) ;
		 
		
		 
		 
	 
  
  endmodule 