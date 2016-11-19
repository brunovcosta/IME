#include<stdio.h>
#include"deque.c"
int main(){
	struct deque *l1 = new_deque(2);
	struct deque *l2 = new_deque(1);

	push_next(l1,new_deque(3));
	push_next(l1,new_deque(7));
	push_next(l1,new_deque(11));
	push_next(l1,new_deque(14));
	push_next(l1,new_deque(18));

	push_next(l2,new_deque(3));
	push_next(l2,new_deque(5));
	push_next(l2,new_deque(7));
	push_next(l2,new_deque(8));
	push_next(l2,new_deque(9));

	printf("passei por aqui");
	struct deque *temp = new_deque(0);
	sort_concat(temp,l1,l2);

	struct deque *l3 = temp->next;




	return 0;
}
