;5. Parašykite programa, kuri vieno failo baitus užrašo šešioliktainiais skaitmenim i kita faila.
.model small
.stack 100h
.data 
    fname db "duom.txt",0
    handle dw 0
    fbuf db 100h dup(?)
    
.code
start:
    mov ax, @data
    mov ds, ax
    
    mov dx, offset fname
    mov ax, 3d00h
    int 21h
    jc exit
    
    mov [handle],ax
    mov bx,ax
    
read:
    mov ah, 3fh
    mov cx, 100h
    mov dx, offset fbuf
    int 21h
    jc exit
    
    or ax, ax
    jz exit
    mov cx, ax 
    call printbuf
    jmp read

exit:
    mov bx,[handle]
    or bx,bx
    jz noclose
    
    mov ah, 3eh
    int 21h

noclose:
    mov ax, 04c00h
    int 21h
    
printbuf proc
    push ax
    push bx
    
    mov ah, 40h
    mov bx, 1
    int 21h
    
    pop bx
    pop ax
    ret
printbuf endp
end start