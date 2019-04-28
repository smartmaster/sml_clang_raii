

.model flat

.code 


;void	SmlCVector_Push(PSmlCVector obj, INT_PTR data);
extern _SmlCVector_Push :  proc

;SML_DATA_PTR __stdcall GetRetAddr(PSmlCVector vec, int enabled, int reserved1, int reserved2);
_Sml_AsmGetRetAddr proc public


;eax = retaddr
mov eax, [esp]

;if enabled == 0
;quick return
cmp dword ptr[esp + 8], 0
je __return

push eax
mov ecx, [esp + 8]
push ecx
call _SmlCVector_Push

add esp, 8

__return:
ret 16


_Sml_AsmGetRetAddr endp


; not implmented, just a place holder
;void RunCleanup(LPVOID addr);

_Sml_AsmRunCleanup proc public


add esp, 8 ;restore stack
jmp dword ptr [esp - 8]

_Sml_AsmRunCleanup endp



end
