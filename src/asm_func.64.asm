

.code 

STACK_SIZE equ 16*8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BYTE* Sml_GetRetAddr(SmlCVector* vec_blocks, long initing_local, BYTE** pretaddr);
extern Sml_GetRetAddr :  proc

Sml_AsmGetRetAddr proc public


;allocate enough stack space, or the sub proc will overwrite the retaddr
sub rsp, STACK_SIZE

lea r8, [rsp + STACK_SIZE]
mov [rsp + 16], r8
mov [rsp + 8], rdx
mov [rsp], rcx
call Sml_GetRetAddr

add rsp, STACK_SIZE
ret


Sml_AsmGetRetAddr endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;//void Sml_AsmPrepareAndRunCleanups(LONG localIniting, LONG volatile* globalInited, SmlCVector* vec_jmp);
extern Sml_LinkAndRunCleanups : proc
Sml_AsmLinkAndRunCleanups proc public

sub rsp, STACK_SIZE

lea r9, [rsp + STACK_SIZE]
mov [rsp + 24], r9
mov [rsp + 16], r8
mov [rsp + 8], rdx
mov [rsp], rcx
call Sml_LinkAndRunCleanups

add rsp, STACK_SIZE
ret

Sml_AsmLinkAndRunCleanups endp

end

