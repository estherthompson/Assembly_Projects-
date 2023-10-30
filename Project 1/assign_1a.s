//Filename: assign_1a
//Author: Mokutimabasi Thompson
//Date: Sept. 26th, 2023
//Description:
// A .s file that calculates the current y value, y minimum for the polynomial
// 5x^4-448x^2-63x+10 using the range -10≤x≤10


x_y_values: .string "Value of x  = %d, Current_y_value = %d,  Value of y_min   = %d\n"
        .balign 4

        .global main
main:
     	stp	 x29, x30, [sp, -16]!           // Allocating 16 btyes.  Save frame pointer in  x29  and link register in  x30  to stack.
        mov	 x29, sp                        // update frame pointer to stacj pointer
        mov	 x19, -10                       // x_val on the lower range
        mov	 x20, 0                         // y_val
        mov	 x21, 20000                     // will represent the y_min that would be compared later in the code

        mov	 x23, 0                         // loop incrementer 

pre_test:


	cmp	 x19, 11                        // i < 11, it will loop through
        b.ge     finish                         // If loop counter is greater then 10 then it will exit the loop the branch finishes

                                                // reintializing the y value, to store the equation 
        mov     x20, 0
                                                // building the polynomical 5x^4
                                               // register x22 will be our temporary variable to complete calculations
        mov	 x22, 5
        mul	 x22, x22, x19//5x
        mul	 x22, x22, x19//5x^2
        mul	 x22, x22, x19//5x^3
        mul	 x20, x22, x19// x20=5x^4

                                                // building the polynomial -448
        mov	 x22, -448
        mul	 x22, x22, x19//-448(x)
        mul	 x22, x22, x19//-448(x)*(x)
                                                //adding the polynomials 5x^4 and -448x^2
        add	 x20, x20, x22 // x20 = 5x^4 -448x^2

                                               // buildiing the polynomial -63x and adding it the x20 register

        mov	 x22, -63
        mul	 x22, x22, x19                // x22= 63(x)
        add	 x20, x20, x22               // x20 = 5x^4 -448x^2-63x

                                            // adding all the polynomials together
        mov	 x22, 10
        add	 x20, x20, x22             // x20 = 5x^4 - 448x^2-63x+10

                                          //Update max_y if necessary
                                         // if x20, the y_val, is less than x21, the y_min then loop will move to update_min
        cmp     x20, x21
        b.le    update_min

loop_increment:
        adrp     x0,  x_y_values        // setting printf argument 

        add	 x0,  x0,  :lo12:x_y_values // adding 12 bits

        mov	 x1,  x19 // defines x1 as the x value 
        mov	 x2,  x20 // defines x2 as the y value 
        mov	 x3,  x21 // defines x3 as the y minimum
        
        bl	 printf // calls the printf statement and prints the x1, x2, x3 values 

                                        // incrementing the loop counter and the x value to move along in the code
        add     x23, x23, 1
        add     x19, x19, 1
                                        // moves back to the pre_test so the loop can continue 
        b	pre_test
                                       //is x20 is less than x21, the new y minimum will be x21
update_min:
        mov     x21, x20// redefining x21 as x20

                                // code then moves to loop_increment
        b        loop_increment
finish:

        mov     x0,   0 // x0 register is set back to 0

        ldp     x29,  x30, [sp], 16 //Restores the LP and FR
        ret // ends the code
