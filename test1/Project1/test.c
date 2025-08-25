#include<stdio.h>

int test(const char* str)
{
	printf("test()\n");
	return 0;
}

int main()
{

	int (*p)(const char*) = &test;
	
	p = test;
	//p("abc");


	/*p("abc");*/
	/*printf("%d", sizeof(test));
	printf("%d", sizeof(&test));*/

	//( *( void (*)())0 )();

	//void(* signal(int,void(*)(int)))(int);


	return 0;
}

