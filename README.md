# sml_clang_raii
RAII for C language in pure C and ASM

Features:
- easy and graceful to use
- no need seperate free cleanup functions
- able to cleanup any resources or call any function on scope exits


User guide:
- add source files in src folder to your project
- include sml_raii_clang.h in .c file
- annote resource and its cleanup functions


Sample:

```c
void sml_raii_clang_test()
{
	//start a scope, the scope name can be any string
	SML_RAII_BLOCK_START(0); 


	SML_RAII_VOLATILE(WCHAR*) resA000 = calloc(128, sizeof(WCHAR)); //allocate memory resource
	SML_RAII_START(0, resA000); //indicate starting a cleanup code fragment, here 'resA000' can be any string you want
	if (resA000) //cleanup code fragment
	{
		free(resA000);
		resA000 = NULL;
	}
	SML_RAII_END(0, resA000); //indicate end of a cleanup code fragment


	//another resource
	//////////////////////////////////////////////////////////////////////////
	SML_RAII_VOLATILE(WCHAR*) res8000 = calloc(128, sizeof(WCHAR));
	SML_RAII_START(0, D000);
	if (res8000)
	{
		free(res8000);
		res8000 = NULL;
	}
	SML_RAII_END(0, D000);

	
	//scope ended, will call all annoated cleanups
	SML_RAII_BLOCK_END(0);
	SML_RAII_LABEL(0, resA000); //if code is optimized, we have to put labels after SML_RAII_BLOCK_END
	SML_RAII_LABEL(0, D000);
}
```

For more details, please debug the main function

```c
int _tmain(int argc, TCHAR** argv)
{
	int testCase = -1;
	if (argc > 1)
	{
		testCase = wcstol(argv[1], NULL, 10);
	}
	
	switch (testCase)
	{
	case 2:
	{
		sml_raii_clang_test(); //with macro for users
	}
	break;
	case 1:
	{
		sml_raii_clang_test_nomacro(); //without macro for developers
	}
	break;
	}
	return 0;
}
```

Status:
- Tested windows x64 64bit release and debug build
- Tested windows x86 32bit release and debug build
