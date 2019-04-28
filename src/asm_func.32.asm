

.model flat

.code 


STACK_SIZE equ 16*4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BYTE* Sml_GetRetAddr(SmlCVector* vec_blocks, long initing_local, BYTE** pretaddr);
extern _Sml_GetRetAddr :  proc

;SML_DATA_PTR /*__stdcall*/ Sml_AsmGetRetAddr(PSmlCVector vec, int enabled, int reserved1, int reserved2);
_Sml_AsmGetRetAddr proc public


;allocate enough stack space, or the sub proc will overwrite the retaddr
sub esp, STACK_SIZE

lea eax, [esp + STACK_SIZE]
mov [esp + 8], eax

mov eax, [esp + STACK_SIZE + 8]
mov [esp + 4], eax

mov eax, [esp + STACK_SIZE + 4]
mov [esp], eax
call _Sml_GetRetAddr

add esp, STACK_SIZE
ret


_Sml_AsmGetRetAddr endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;void Sml_LinkAndRunCleanups(LONG localIniting, LONG volatile* globalInited, SmlCVector* vec_jmp, LPBYTE* pretddr);
extern _Sml_LinkAndRunCleanups : proc

;void /*__stdcall*/ Sml_AsmLinkAndRunCleanups(LONG localIniting, LONG volatile* globalInited, SmlCVector* vec_jmp);
_Sml_AsmLinkAndRunCleanups proc public

sub esp, STACK_SIZE

lea eax, [esp + STACK_SIZE]
mov [esp + 12], eax

mov eax, [esp + STACK_SIZE + 12]
mov [esp + 8], eax

mov eax, [esp + STACK_SIZE + 8]
mov [esp + 4], eax

mov eax, [esp + STACK_SIZE + 4]
mov [esp], eax
call _Sml_LinkAndRunCleanups

add esp, STACK_SIZE
ret

_Sml_AsmLinkAndRunCleanups endp

end
