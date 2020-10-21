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
  
//---------//-------//-------//  
  //01. Fim de Expediente
  
  //declaracao das variaveis de entrada 
  logic noite;
  logic paradas;
  logic sexta;
  logic producao;
  
  //atribuicao 
  always_comb begin
  	noite <= SWI[4];
  	paradas <= SWI[5];
  	sexta <= SWI[6];
  	producao = SWI[7];
  end
  
  //declaracao da saida 
  logic sirene;
  
  //atribuicao da saida 
  always_comb LED[2] <= sirene;
  
  //operação logica: condicão a ou b sera valido para a variavel de saida 
  always_comb sirene <= (noite & paradas) | (sexta & paradas & producao ) ;
  
//--------//-------//------//
  
 //02. Uma agência bancária
 
  //declaracao das variaveis de entrada 
  logic porta;
  logic relogio;
  logic interruptor;
  
  
  //atribuicao 
  always_comb begin
  	porta <= SWI[0];
  	relogio <= SWI[1];
  	interruptor <= SWI[2];
  	
  end
  
  //declaracao da saida 
  logic alarme;
  
  //atribuicao da saida 
  always_comb SEG[0] <= alarme;
  
  // o alarme tocará se estiver fora no expediente e com o interruptor ligado 
  // e se estiver em expediente, só se o interruptor estiver ligados 
  //ambas com a porta do cofre aberta 
  always_comb alarme <= (porta & ~relogio & interruptor) | (porta & relogio & interruptor) ;

//-------//---------//-------//

//03. Uma estufa

 //declaracao das variaveis de entrada 
  logic t1;
  logic t2;

  //atribuicao 
  always_comb begin
  	t1 <= SWI[3];
  	t2 <= SWI[4];
  	
  end
  
  //declaracao da saida 
  logic a;
  logic r;
  logic inconsistencia;
  
  
  //atribuicao da saida 
  always_comb begin
  
  	LED[6]<= a;
  	LED[7]<= r;
  	SEG[7]<= inconsistencia; 
  
  end 
  
  always_comb a <=(~t1 & ~t2);//se for abaixo de 15 graus
  always_comb r <= (t2 & ~t1);//se estiver acima de 20 graus
  always_comb inconsistencia <= (t1 & t2); //inconsistencia nos sensores
  
//--------//--------//---------// 

//04. As aeronaves
//declaracao das variaveis de entrada 
  logic lavatorio1;
  logic lavatorio2;
  logic lavatorio3;

  //atribuicao 
  always_comb begin
  	lavatorio1 <= SWI[0];
  	lavatorio2 <= SWI[1];
  	lavatorio3 <= SWI[2];
  	
  end
  
  //declaracao da saida 
  logic dispoM;//disponivel para mulheres
  logic dispoH;//disponivel para homens
  
  //atribuicao da saida 
  always_comb begin
  
  	LED[0]<= dispoM;
  	LED[1]<= dispoH;
  	 
  end 
  
  always_comb begin
  	  if(lavatorio1)
  	  begin
  	  dispoM <= lavatorio1;//lavatorio das mulheres disponivel
  	  end
  	  else if(lavatorio3)
  	  begin
  	  dispoH <= lavatorio3;//lavatorio 3 dos homens disponivel
  	  end
  	  else 
  	  begin
  	  dispoH <= lavatorio2;//lavatorio 2 dos homens disponivel
  	  end
  end
  
  
endmodule
