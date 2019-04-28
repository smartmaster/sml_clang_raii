

.code 

STACK_SIZE equ 16*8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void	SmlCVector_Push(PSmlCVector obj, INT_PTR data);
extern SmlCVector_Push :  proc

;SML_DATA_PTR GetRetAddr(PSmlCVector vec, int enabled, int reserved1, int reserved2);

Sml_AsmGetRetAddr proc public

;rax = retaddr
mov rax, [rsp]

;if enabled == 0
;quick return
cmp edx, 0 
je __return

;allocate enough stack space, or the sub proc will overwrite the retaddr

sub rsp, STACK_SIZE

mov rdx, rax
mov [rsp], rcx
mov [rsp + 8], rdx
call SmlCVector_Push

add rsp, STACK_SIZE

__return:
;rax = retaddr
mov rax, [rsp]
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
mov [rsp + 9], rdx
mov [rsp], rcx
call Sml_LinkAndRunCleanups

add rsp, STACK_SIZE
ret

Sml_AsmLinkAndRunCleanups endp

end

