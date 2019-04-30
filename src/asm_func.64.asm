ifndef x64

.model flat
.code


else

.code 


;//number starting from 1
setvar macro number:req, reg:req, stacksize:req
mov qword ptr [rsp + stacksize - number * sizeof(qword)], reg
endm

getvar macro reg:req, number:req, stacksize:req
mov reg, qword ptr [rsp + stacksize - number * sizeof(qword)]
endm


;//number starting from 1
setparam macro number:req, reg:req, stacksize:req
mov qword ptr [rsp + stacksize + number * sizeof(qword)], reg
endm

getparam macro reg:req, number:req, stacksize:req
mov reg, qword ptr [rsp + stacksize + number * sizeof(qword)]
endm


;//number starting from 1
setsubparam macro number:req, reg:req
mov qword ptr [rsp + (number - 1) * sizeof(qword)], reg
endm

getsubparam macro reg:req, number:req
mov reg, qword ptr [rsp + (number - 1) * sizeof(qword)]
endm


STACK_SIZE equ 16*8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BYTE* Sml_GetRetAddr(SmlCVector* vec_blocks, long initing_local, BYTE** pretaddr);
extern Sml_GetRetAddr :  proc

Sml_AsmGetRetAddr proc public


;allocate enough stack space, or the sub proc will overwrite the retaddr
sub rsp, STACK_SIZE

lea r8, [rsp + STACK_SIZE]
setsubparam 3, r8
setsubparam 2, rdx
setsubparam 1, rcx
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
setsubparam 4, r9
setsubparam 3, r8
setsubparam 2, rdx
setsubparam 1, rcx
call Sml_LinkAndRunCleanups

add rsp, STACK_SIZE
ret

Sml_AsmLinkAndRunCleanups endp


endif

end

