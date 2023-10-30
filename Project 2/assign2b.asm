//Filename: assign2b.asm 
//Date: October 5th 2023 
//Description:
// An ARMv8 assembly language program the implements a given c program. 
//This c program reverses the bit x = 0x7F807F80  and prints out the orginal bit and reversed bit.
// The assembly program will do the same except it print the orginal , reversed in hexadecimal 
// and the orginal and reversed number in binary 

                //define registers for variables 
                define(x_val,  w19)                     // register to store the orginal value 
                define(y_val,  w20)                     // register to store the reversed value 
                define(t1_val, w21)                     // temporary registers for calculations 
                define(t2_val, w22)           
                define(t3_val, w23)
                define(t4_val, w24)

// String format for printing             
x_y_values:     .string " Hexadecimal Original: 0x%08X  Hexdecimal Reversed: 0x%08X\n"
                
                .balign 4
                .global main 
                                                              
main:                                                        
                stp x29, x30, [sp, -16]!                   // Save the stack frame 
                mov x29, sp 
                 
                mov x_val,  0x7F807F80                    // Initialzie x_val with the orginal value 
     
                // Step #1: Reverse Bits               
                and t1_val, x_val, 0x55555555        
                lsl t1_val, t1_val, 1                   //   t1 = (x & 0x55555555) << 1       
                                                    
                lsr t2_val, x_val, 1               
                and t2_val, t2_val, 0x55555555        //   (x >> 1) & 0x55555555
                                                
                orr y_val, t1_val, t2_val            //    y = t1 | t2

                //Step #2: Reverse Bits 

                and t1_val, y_val, 0x33333333    
                lsl t1_val, t1_val, 2               //    t1 = (y & 0x33333333) << 2

                lsr t2_val, y_val, 2           
                and t2_val, t2_val, 0x33333333     //    t2 = (y >> 2) & 0x33333333
                orr y_val, t1_val, t2_val          //    y = t1 | t2

                //Step #3: Reverse Bits 

                and t1_val, y_val, 0x0F0F0F0F 
                lsl t1_val, t1_val, 4            // t1 = (y & 0x0F0F0F0F) << 4   
                lsr t2_val, y_val,  4         
                and t2_val, t2_val, 0x0F0F0F0F   // t2 = (y >> 4) & 0x0F0F0F0F
                orr y_val, t1_val, t2_val       //  y = t1 | t2


                // Step 4: Reverse Bits 
                lsl t1_val, y_val, 24         // t1 = y << 24
                and t2_val, y_val, 0xFF00     
                lsl t2_val, t2_val, 8        // t2 = (y & 0xFF00) << 8
                lsr t3_val, y_val, 8  
                and t3_val, t3_val, 0xFF00  // t3 = (y >> 8) & 0xFF00
                lsr t4_val, y_val, 24       // t4 = y >> 24
                orr y_val, t1_val, t2_val  
                orr y_val, y_val, t3_val 
                orr y_val, y_val, t4_val   //  y = t1 | t2 | t3 | t4

             // Load string format and values for printing 
                adrp x0, x_y_values  
                add  x0, x0, :lo12:x_y_values
                mov w1, x_val
                mov w2, y_val
                bl printf
                
                // Redefine the x0 to 0
                ldp     x29,  x30, [sp], 16         // Restoring stack frame
                ret         
                                       
                