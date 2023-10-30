// Filename: assign_1a
// Author: Mokutimabasi Esther Thompson
// Description:
// A .asm file that calculates the current y value, y minimum for the polynomial
// 5x^4-448x^2-63x+10 using the range -10≤x≤10. the file incorporates the use of marcos 

output_str:     .string "x value = %d, y value = %d, y minimum = %d\n"

                .global main

                .balign 4
main:

                stp x29, x30, [sp, -16]!
                mov x29, sp

                // defining the registers we will be using in the code
                define(coef_a, x23) 
                define(coef_b, x24)
                define(coef_c, x25)
                define(coef_d, x26)

                define(x_val, x19)
		define(y_val, x20)
                define(y_min, x21)
                define(var_temp, x22)
                define(var_temp_2, x28)

                // seting the integers from the previously defined registers 
                mov x_val,  -10
                mov y_min, 30000
		mov y_val, 0

                mov coef_a, 5
                mov coef_b, -448
                mov coef_c, -63
                mov coef_d, 10

                // once everything it defined the code will start doing the calculations
                b   top
top:
                mov y_val,  0 //y_val = 0
                mov var_temp,0 // var_temp = 0

		add y_val, y_val, coef_d // y = 10+0
		madd y_val, coef_c, x_val, y_val// y = 10+(-63x)

		mul var_temp, coef_b, x_val// var_temp = -448x
		madd y_val, var_temp, x_val, y_val// y = 10-63x + (-448x)(x)

		mov var_temp, 0 // var_temp = 0
		mul var_temp, coef_a, x_val  //var_temp = 5x
		mul var_temp, var_temp, x_val // var temp = 5x*x
		mul var_temp, var_temp, x_val // var temp = 5x^2*x

		madd y_val, var_temp, x_val, y_val //y =  10-63x-448^2+ (5x^3(x))

                // comparing the y_val and y_min to see if y_val is less then or equal to the y_min. 
                //if it is then the loop will move to update_min
		
		cmp y_val, y_min
                b.le update_min
		b increment_x
update_min:
                //updating the y_min to y_val if y_val is less than y_min
                mov y_min, y_val

increment_x:

        
                //creating the printf statement
                adrp x0, output_str
                add  x0, x0, :lo12:output_str
                mov x1, x_val // setting x_val to x1 register
                mov x2, y_val // setting the y_val to x2 register
                mov x3, y_min // setting the y_min to the x3 register

                // printing the x1, x2, and x3 values
                bl printf
                // incrementing the x value to move through the loop
                add x_val, x_val, 1


                // running through the b test to continue looping 
                b test
test:
                // is our post test loop range, it will run through top till is reaches x = 10
                cmp x_val, 11
                b.le top
done:
                // redefing the x0 to 0
                mov     x0,   0

                ldp     x29,  x30, [sp], 16 // restoring stack
                ret // returning to the caller to end the code
