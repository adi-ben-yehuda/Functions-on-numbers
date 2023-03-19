# Adi Ben Yehuda
	.data
id:	.quad	211769724

	.section	.rodata         # Read only data section
formatNumber:	.string	"%ld\n"
formatTrue:	.string	"True\n"	
formatFalse:  .string       "False\n"

	########
	.text	# The beginnig of the code
.globl	main
	.type	main, @function
main:
        movq    %rsp, %rbp
        pushq   %rbp		        # Save the old frame pointer
        movq    %rsp, %rbp	        # Create the new frame pointer
        pushq   %rbx		        # Saving a callee save register.

        ### 1 ###
        movq    id,%rsi	                # Passing the value of id
        movq    $formatNumber,%rdi 
        movq    $0,%rax
        pushq   $0x41		        # Pushing a random value to the stack (causing the stack to be 16 byte aligned).
        call    printf	                # Printing the id.

        ### 2 ###
        movq    $id, %rax               # Geting the address of label "id"
        movsbq  1(%rax), %rdx           # Reading the second byte (with sign extension) of label "id".
        movq    id, %rax                # Passing the value of id
        movq    $1, %rcx                # Passing 1 to rcx
        andq    %rdx, %rcx              # Checking if the second byte of the id is odd or even.
        cmpq    $1, %rcx	        # Compare number : 1
        je      .L4                     # Jump if the number is even
        movq    $0, %rdx	
        movl    $3, %ecx       
        idiv    %ecx                    # The number is even. Saving the remainder of id\3 in rdx.
        jmp     .L5
.L4:
        leaq    (%rax,%rax,2), %rdx     # The number is odd. rdx = 3*id
.L5:       
        movq    %rdx, %rsi	        # Passing the value of the result
        movq    $formatNumber, %rdi     # The string is the first paramter passed to the printf function.
        movq    $0, %rax
        call    printf                  # Printing the result (id*3 / id/3)

        ### 3 ###
        movq    $id, %rax	        # Geting the address of label "id"
        movb  (%rax), %cl	        # Reading the first byte of label "id".
	 movb  2(%rax), %bl	        # Reading the third byte of label "id".
        xor     %cl , %bl   	        # first byte^third byte   
        cmp     $127, %bl
	 ja    .L6                      # Jump if xor>127
        movq    $formatFalse, %rdi      # The xor is less than 127. Printing false.
        jmp     .L7
.L6:
        movq    $formatTrue,%rdi        # The xor is biggen than 127. Printing true.
.L7:
        movq    $0,%rax
        call    printf                  # Printing true or false.  
       
        ### 4 ###
        movq    $id, %rax               # Geting the address of label "id".
        movq    3(%rax), %rdx           # Reading the fourth byte of label "id".
        movq    $0, %rsi                # Init %rsi to be 0. This register will save the amount of 1 in the fourth byte.
.L8:
        movq    $1, %rcx                # Passing 1 to rcx.  
        andq    %rdx, %rcx              # Checking if the last digit in the fourth byte of the id is 1.
        cmpq    $1, %rcx	        # Compare bit : 1
        jne     .L9                     # Jump if the rcx is not zero.
        addq    $1, %rsi                # That is, the bit is 1 so add 1 to counter. 
.L9:       
        sarq    $1, %rdx                # Move to the next bits in the fourth byte using shift.
        cmp     $0, %rdx                # Check if the fourth byte after the shift is 0.
        jne      .L8                    # If there are more bits in the fourth byte, run the loop again.
        	             
        movq    $formatNumber,%rdi      # Print the amount of 1 that exist in the fourth byte.
        movq    $0,%rax
        call    printf                  # Print the amount of 1 that exist in the fourth byte.
       
        movq    $0, %rax                # Return value is zero.
        movq    -8(%rbp), %rbx          # Restoring the save register (%rbx) value, for the caller function.
        movq    %rbp, %rsp	        # Restore the old stack pointer - release all used memory.
        popq    %rbp		        # Restore old frame pointer (the caller function frame)
        ret			        # Return to caller function (OS).
        
