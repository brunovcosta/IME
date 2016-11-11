#include<stdio.h>
/*01*/int main(int argc,char **argv){
/*01*/	int comprouBebida=0;
/*01*/	double valorTotal=0;
/*01*/	char formaPagamento;
/*01*/	//Input de usuarios
/*02*/	while(1){
/*03*/		char ch = getc(stdin);
/*03*/		int qty;
/*04*/		switch(ch){
/*05*/			case 'L':
/*05*/				scanf("%d",&qty);
/*05*/				valorTotal+=2*qty;
/*05*/				break;
/*06*/			case 'M':
/*06*/				scanf("%d",&qty);
/*06*/				valorTotal+=5*qty;
/*06*/				break;
/*07*/			case 'B':
/*07*/				comprouBebida=1;
/*07*/				scanf("%d",&qty);
/*07*/				valorTotal+=4*qty;
/*07*/				break;
/*08*/			case 'P': case 'C': case 'D':
/*08*/				formaPagamento = ch;
/*08*/				break;
/*09*/		}
/*10*/		if(formaPagamento=='P'||formaPagamento=='C'||formaPagamento=='D')
/*11*/			break;
/*12*/	}
/*13*/	//Calcula desconto
/*13*/	switch(formaPagamento){
/*14*/		case 'P':
/*15*/			if(comprouBebida)
/*16*/				valorTotal*=.95;
/*17*/			else
/*17*/				valorTotal*=.9;
/*18*/			break;
/*19*/		case 'D':
/*19*/			valorTotal*=.95;
/*19*/			break;
/*20*/		case 'C':
/*21*/			if(valorTotal>=25)
/*22*/				valorTotal*=.95;
/*23*/			break;
/*24*/	}
/*24*/	printf("R$%.2lf\n",valorTotal);
/*24*/
/*24*/	return 0;
/*XX*/}
