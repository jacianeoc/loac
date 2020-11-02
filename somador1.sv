// DESCRIPTION: Verilator: Systemverilog example module
// with interface to switch buttons, LEDs, LCD and register display

parameter NINSTR_BITS = 32;
parameter NBITS_TOP = 8, NREGS_TOP = 32, NBITS_LCD = 64;
module top(input  logic clk_2,
           input  logic [NBITS_TOP-1:0] SWI,
           output logic [NBITS_TOP-1:0] LED,
           output logic [NBITS_TOP-1:0] SEG,
           output logic [NBITS_LCD-1:0] lcd_a, lcd_b,
           output logic [NINSTR_BITS-1:0] lcd_instruction,
           output logic [NBITS_TOP-1:0] lcd_registrador [0:NREGS_TOP-1],
           output logic [NBITS_TOP-1:0] lcd_pc, lcd_SrcA, lcd_SrcB,
             lcd_ALUResult, lcd_Result, lcd_WriteData, lcd_ReadData, 
           output logic lcd_MemWrite, lcd_Branch, lcd_MemtoReg, lcd_RegWrite);

  always_comb begin
    //LED <= SWI | clk_2;
    //SEG <= SWI;
    lcd_WriteData <= SWI;
    lcd_pc <= 'h12;
    lcd_instruction <= 'h34567890;
    lcd_SrcA <= 'hab;
    lcd_SrcB <= 'hcd;
    lcd_ALUResult <= 'hef;
    lcd_Result <= 'h11;
    lcd_ReadData <= 'h33;
    lcd_MemWrite <= SWI[0];
    lcd_Branch <= SWI[1];
    lcd_MemtoReg <= SWI[2];
    lcd_RegWrite <= SWI[3];
    for(int i=0; i<NREGS_TOP; i++) lcd_registrador[i] <= i+i*16;
    lcd_a <= {56'h1234567890ABCD, SWI};
    lcd_b <= {SWI, 56'hFEDCBA09876543};
  end
  
  //Jaciane de oliveira cruz-118110412
  
  // definicao de constantes
  parameter msb_8bits = 7, msb_answer = 5, msb_signed_ab = 2;
  parameter underflow_value = -4, overflow_value = 3, num_4 = 4;

  //declaracao das variaveis de entrada 
  logic incorrect;          // ira servir como uma validador, se a operação vai ter a saida correta ou nao, com levando em consideração o sinal 
  logic [1:0] controller;   // array controlador
  logic unsigned [msb_signed_ab:0] unsigned_a, unsigned_b; 
  logic signed [msb_signed_ab:0] a,b; 
  
  
  //atribuição da saida que vai ser a resposta da operação escolhida 
  logic signed [msb_answer:0] answer;
  
 
  always_comb begin
        a <= SWI[msb_8bits:msb_answer];
	b <= SWI[msb_signed_ab:0];
 	controller <= SWI[num_4:overflow_value];
 
  end 

  always_comb begin
	
	unique case (controller)
		
		//se for 0 então o resultado irá ser a soma de a com b 
		0:
		begin
			answer[msb_signed_ab:0] <= (a+b);
			answer[msb_answer:3] <= 3'b000;
			incorrect <= ((a+b) < underflow_value) || ((a+b) > overflow_value);
		end

		
		// 1 o resultado será a subtração de a e b 
		1:
		begin
			answer[msb_signed_ab:0] <= (a-b);
			answer[msb_answer:3] <= 3'b000;
			incorrect <= ((a-b) < underflow_value) || ((a-b) > overflow_value);
		end

		
		// multiplicação dos dois termos 
		2:
		begin
			answer[msb_answer:0] <= (unsigned_a*unsigned_b);
			//answer[msb_answer:3] <= 3'b000;
			incorrect <= 0;
		end

		
		//também será a multiplicação dos dois termos
		3:
		begin
			answer[msb_answer:0] <= (a*b);
			//answer[msb_answer:3] <= 3'b000;
			incorrect <= 0;
		end

	endcase

	
	LED[msb_answer:0] <= answer [msb_answer:0];
	LED[msb_8bits] <= incorrect; //se for não conseguir fazer a operação,aqui irá ligar o led7 (a bolinha)
/*
	if (controller[1] == 0)
	begin
		unique case(signed'(answer[msb_signed_ab:0]))
			-9:SEG[msb_8bits:0] <= 8'b11110110;
			-8:SEG[msb_8bits:0] <= 8'b11111110;
			-7:SEG[msb_8bits:0] <= 8'b11100000;
			-6:SEG[msb_8bits:0] <= 8'b10111110;
			-5:SEG[msb_8bits:0] <= 8'b10110110;
			-4:SEG[msb_8bits:0] <= 8'b01100110;
			-3:SEG[msb_8bits:0] <= 8'b11001110;
			-2:SEG[msb_8bits:0] <= 8'b11011010;
			-1:SEG[msb_8bits:0] <= 8'b10000110;
			0:SEG[msb_8bits:0] <= 8'b11111100;
			1:SEG[msb_8bits:0] <= 8'b11000000;
			2:SEG[msb_8bits:0] <= 8'b11011010;
			3:SEG[msb_8bits:0] <= 8'b11001110;
			4:SEG[msb_8bits:0] <= 8'b01100110;
			5:SEG[msb_8bits:0] <= 8'b10110110;
			6:SEG[msb_8bits:0] <= 8'b10111110;
			7:SEG[msb_8bits:0] <= 8'b11100000;
			8:SEG[msb_8bits:0] <= 8'b11111110;
			9:SEG[msb_8bits:0] <= 8'b11110110;
		endcase

	end else begin
		SEG[msb_8bits:0] <= 8'b10000000;
	end
*/
if (controller[1] == 0)
	begin
		unique case(signed'(answer[msb_signed_ab:0]))
			-4:SEG[msb_8bits:0] <= 8'b11100110;
			-3:SEG[msb_8bits:0] <= 8'b11001111;
			-2:SEG[msb_8bits:0] <= 8'b11011011;
			-1:SEG[msb_8bits:0] <= 8'b10000110;
			0:SEG[msb_8bits:0] <= 8'b00111111;
			1:SEG[msb_8bits:0] <= 8'b00000110;
			2:SEG[msb_8bits:0] <= 8'b01011011;
			3:SEG[msb_8bits:0] <= 8'b01001111;
		endcase

	end else begin
		SEG[msb_8bits:0] <= 8'b10000000;
	end
end

  
endmodule
