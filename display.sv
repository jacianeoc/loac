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
  
  //declaracao das variaveis de entrada 
    logic [5:0] controller;
    logic [3:0] notas;
    logic classifier;
    
  always_comb begin
	 //atribuicao 
    controller <= SWI[5:0];
    classifier <= SWI[7];
    
    if (classifier)begin
    	case (notas[3:0])
    	  0: SEG[6:0] <= 7'b0111111;
          1: SEG[6:0] <= 7'b0111111;
          2: SEG[6:0] <= 7'b0111111;
          3: SEG[6:0] <= 7'b0111111;
          4: SEG[6:0] <= 7'b1110001;
          5: SEG[6:0] <= 7'b1110001;
          6: SEG[6:0] <= 7'b1110001;
          7: SEG[6:0] <= 7'b1110111;
          8: SEG[6:0] <= 7'b1110111;
          9: SEG[6:0] <= 7'b1110111;
          10: SEG[6:0] <= 7'b1110111;
          default: SEG[6:0] <= 7'b1000000;  // -
          endcase
    	end 
    else begin    
    case (controller[5:0])
        //numeros em Hexadecimal
        0: SEG[6:0] <= 7'b0111111;
        1: SEG[6:0] <= 7'b0000110;
        2: SEG[6:0] <= 7'b1011011;
        3: SEG[6:0] <= 7'b1001111;
        4: SEG[6:0] <= 7'b1100110;
        5: SEG[6:0] <= 7'b1101101;
        6: SEG[6:0] <= 7'b1111101;
        7: SEG[6:0] <= 7'b0000111;
        8: SEG[6:0] <= 7'b1111111;
        9: SEG[6:0] <= 7'b1101111;
        10: SEG[6:0] <= 7'b1110111;
        11: SEG[6:0] <= 7'b1111100;
        12: SEG[6:0] <= 7'b0111001;
        13: SEG[6:0] <= 7'b1011110;
        14: SEG[6:0] <= 7'b1111001;
        15: SEG[6:0] <= 7'b1110001;
        
        // Alfabeto
        16: SEG[6:0] <= 7'b1110111; // A
        17: SEG[6:0] <= 7'b1111100; // b
        18: SEG[6:0] <= 7'b0111001; // C
        19: SEG[6:0] <= 7'b1011000; // c
        20: SEG[6:0] <= 7'b1011110; // d
        21: SEG[6:0] <= 7'b1111001; // E
        22: SEG[6:0] <= 7'b1110001; // F
        23: SEG[6:0] <= 7'b1101111; // g
        24: SEG[6:0] <= 7'b1110110; // H
        25: SEG[6:0] <= 7'b1110100; // h
        26: SEG[6:0] <= 7'b0000110; // I
        27: SEG[6:0] <= 7'b0000100; // i
        28: SEG[6:0] <= 7'b0011110; // J
        29: SEG[6:0] <= 7'b0111000; // L
        30: SEG[6:0] <= 7'b1010100; // n
        31: SEG[6:0] <= 7'b0111111; // O
        32: SEG[6:0] <= 7'b1011100; // o
        33: SEG[6:0] <= 7'b1110011; // P
        34: SEG[6:0] <= 7'b1100111; // q
        35: SEG[6:0] <= 7'b1010000; // r
        36: SEG[6:0] <= 7'b1101101; // S
        37: SEG[6:0] <= 7'b1111000; // t
        38: SEG[6:0] <= 7'b0111110; // U
        39: SEG[6:0] <= 7'b0011100; // u
        40: SEG[6:0] <= 7'b1101110; // y
        41: SEG[6:0] <= 7'b1100011; // °
        
        default: SEG[6:0] <= 7'b1000000;  // -
        
    endcase
    end

  end
  
  	 
  	 

endmodule
