#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
static void *__VERBS_ABI_IS_EXTENDED = ((uint8_t *)NULL) - 1;


struct test_struct{
   void * abi_compat;
};


int main(void){
    
    struct test_struct p;    
    struct test_struct *pp=&p;
    // Guess, the source code for ibv_open_device is not available
    pp->abi_compat=0xffffffffffffffff;
    printf("pp->abi_compat == __VERBS_ABI_IS_EXTENDED i.e\n");
    printf("%p == %p\n", (void *) pp->abi_compat,__VERBS_ABI_IS_EXTENDED);
    if((void *) pp->abi_compat == __VERBS_ABI_IS_EXTENDED){
    printf("Equality holds\n");
    }
    else{
    printf("Equality does not hold\n");
    }
    // Sanity check that it's not just setting 
    return 0;
}
