STRUC Point ;define a point structure
.x RESD 1   ;reserve 4 bytes for x coordinate
.y RESD 1   ;reserve 4 bytes for y coordinate
.size:
ENDSTRUC

section .data   ;data section

msgPt: db "What are the x and y values for the points?", 10, 0
msgPtL: equ $-msgPt

msg2: db"The point coordinates are ", 10  ,0
msgL2: equ $-msg2

formatPointScan: db "%d", 0

xVal: dd 0
yVal: dd 0

loopCount: dd 0

section .bss    ;bss section

PtArr: RESB Point.size*5    ;reserver place for 5 structures
;PtArr points to the start of array
ArrCount: EQU($ - PtArr)/Point.size ;should be 5


section .text

extern _scanf

global _main
_main:
    push ebp
    mov ebp, esp

   mov ecx, msgPt
   mov edx, msgPtL
   call PString

    mov dword[loopCount], ArrCount  ;ecx has the number of array elements
    mov esi, PtArr  ;esi contains address of first struct in array

getPointsLoop:
    push xVal
    push formatPointScan
    call _scanf
    mov dword[esi + Point.x], xVal  

    push yVal
    push formatPointScan
    call _scanf
    mov dword[esi + Point.y], yVal
    add esi, Point.size
    dec dword[loopCount]
    cmp dword[loopCount], 0
jne getPointsLoop

    mov ecx, msg2
    mov edx, msgL2
    call PString
    mov dword[loopCount], ArrCount ;set ecx to num of array elements
    mov esi, PtArr  ;point esi to 1st element of array

printPointsLoop:
    mov eax, [esi + Point.x]    ;indirect access to x value
    call printDec
    call println

    mov eax, [esi + Point.y]    ;indirect access to y value
    call printDec
    call println

    add esi, Point.size
    dec dword[loopCount]
    cmp dword[loopCount], 0
jne printPointsLoop

    ;exit program and cleaning
    mov esp, ebp
    pop ebp
    ret

PString:; save register values of the called function
    pusha
    mov eax,4 ; use 'write' system call = 4
    mov ebx,1 ; file descriptor 1 = STDOUT
    int 80h ; call the kernel

    ; restore the old register values of the called function
    popa
    ret

println:
    ;will call PString func
    ;will change content of ecx and edx
    ;need to save registers used by the main program
    section .data
    nl db 10
    section .text
    pusha

    mov ecx, nl
    mov edx, 1
    call PString

    ;return original register values
    popa
    ret

printDec:
;saves all registers so they return unmodified
;build the function to handle dword size

    section .bss
    decstr resb 10 ; 10 32-bit digits
    ct1 resd 1 ;keep track of dec-string size

    section .text
    pusha; save registers

    mov dword[ct1],0 ;initially assume 0
    mov edi, decstr ; edi points to dec-string
    add edi, 9 ; moved to the last element of string
    xor edx, edx ; clear edx for 64-bit div
whileNotZero:
    mov ebx, 10 ; get ready to divide by 10
    div ebx ; divide by 10
    add edx, '0' ; convert to ascii
    mov byte[edi], dl ; put it in string
    dec edi ; move to next char in str
    inc dword[ct1] ; inc char counter
    xor edx, edx ; clear edx
    cmp eax, 0  ;is remainder 0?
    jne whileNotZero ;if no, keep on looping

    inc edi ; conversion finished, bring edi
    mov ecx, edi ; back to start of string. make ecx
    mov edx, [ct1] ; point to counterm edx gets # chars
    mov eax, 4 ; print to stdout
    mov ebx, 1
    int 0x80 ; call kernel

    popa ; restore registers
    ret