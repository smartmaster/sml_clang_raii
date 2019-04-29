#pragma once

#include <stdio.h>
#include "raii_func.h"

#ifndef SML_RAII_BLOCK_START

//////////////////////////////////////////////////////////////////////////
#define  SML_RAII_VOLATILE(type) type volatile

//////////////////////////////////////////////////////////////////////////
#define  SML_RAII_BLOCK_START(name) \
static SML_RAII_VOLATILE(SmlCVector) _ ## name ## _sml_raii_vec_blocks;  \
static SML_RAII_VOLATILE(SmlCVector) _ ## name ## _sml_raii_vec_jmp;  \
static SML_RAII_VOLATILE(long)  _ ## name ## _sml_raii_const_false = 0;  \
static SML_RAII_VOLATILE(long)  _ ## name ## _sml_raii_initing = 0;  \
static SML_RAII_VOLATILE(long)  _ ## name ## _sml_raii_ready = 0;  \
const long  _ ## name ## _sml_raii_reserved1 = 0xbbbb'bbbb;  \
const long  _ ## name ## _sml_raii_reserved2 = 0xcccc'cccc;  \
SML_RAII_VOLATILE(long)  _ ## name ## _sml_raii_initing_local = (InterlockedCompareExchange(& _ ## name ## _sml_raii_initing, 1, 0) == 0);  \
_ ## name ## _sml_raii_block_start_label: \
if ( _ ## name ## _sml_raii_initing_local)  \
{ \
	SmlCVector_Ctor(& _ ## name ## _sml_raii_vec_blocks);  \
	SmlCVector_Ctor(& _ ## name ## _sml_raii_vec_jmp);  \
}




//////////////////////////////////////////////////////////////////////////
#define SML_RAII_START(name, label) \
Sml_AsmGetRetAddr(& _ ## name ## _sml_raii_vec_blocks,  _ ## name ## _sml_raii_initing_local,  _ ## name ## _sml_raii_reserved1,  _ ## name ## _sml_raii_reserved2);  \
_ ## name ## _sml_raii_lable_ ## label: \
if ( _ ## name ## _sml_raii_const_false)  \
{ \
Sml_JmpTag(SML_JMPTAGPATERN_BEGIN);





//////////////////////////////////////////////////////////////////////////
#define SML_RAII_LABEL(name, label) \
if (_ ## name ## _sml_raii_const_false)  \
{ \
	goto _ ## name ## _sml_raii_lable_ ## label;  \
}




//////////////////////////////////////////////////////////////////////////
#define SML_RAII_END(name, label) \
Sml_JmpTag(SML_JMPTAGPATERN_END);  \
}  \
Sml_AsmGetRetAddr(& _ ## name ## _sml_raii_vec_blocks,  _ ## name ## _sml_raii_initing_local,  _ ## name ## _sml_raii_reserved1,  _ ## name ## _sml_raii_reserved2);  \
SML_RAII_LABEL(name, label)




//////////////////////////////////////////////////////////////////////////
#define  SML_RAII_BLOCK_END(name) \
if (0 ==   _ ## name ## _sml_raii_initing_local) \
{ \
	while (0 ==   _ ## name ## _sml_raii_ready) \
	{ \
		Sleep(0); \
	} \
} \
if (  _ ## name ## _sml_raii_initing_local) \
{ \
	Sml_FindJmps(&  _ ## name ## _sml_raii_vec_blocks, &  _ ## name ## _sml_raii_vec_jmp); \
} \
Sml_AsmLinkAndRunCleanups(  _ ## name ## _sml_raii_initing_local, &  _ ## name ## _sml_raii_ready, &  _ ## name ## _sml_raii_vec_jmp);  \
if ( _ ## name ## _sml_raii_const_false)  \
{  \
	printf("Sml_JmpTag result is %d" "\r\n", Sml_JmpTag('RRRR', 'aaaa', 'IIII', 'iiii'));  \
	goto  _ ## name ## _sml_raii_block_start_label;  \
}



/***********************************************
in release build, SML_RAII_BLOCK_END should be followed by SML_RAII_LABEL(s), for example
	SML_RAII_BLOCK_END(block);
	SML_RAII_LABEL(block, lable_aaa);
	SML_RAII_LABEL(block, lable_bbb);
	SML_RAII_LABEL(block, lable_ccc);
	SML_RAII_LABEL(block, lable_ddd);
	SML_RAII_LABEL(block, lable_eee);
***********************************************/

//////////////////////////////////////////////////////////////////////////
#define SML_RAII_USING(func)  \
SML_RAII_START;  \
func;  \
SML_RAII_END



//////////////////////////////////////////////////////////////////////////
#define  raii_volatile		SML_RAII_VOLATILE
#define  raii_block_start	SML_RAII_BLOCK_START
#define  raii_start			SML_RAII_START
#define  raii_end			SML_RAII_END
#define  raii_block_end		SML_RAII_BLOCK_END
#define  raii_using			SML_RAII_USING
#define	 raii_label			SML_RAII_LABEL

#endif // !SML_RAII_BLOCK_START