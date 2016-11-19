#include<stdlib.h>
struct deque{
	int val;
	struct deque *next,*prev;
};
struct deque* new_deque(int val){
	struct deque *retVal =  (struct deque*)malloc(sizeof(struct deque));
	retVal->val=val;
	retVal->next=NULL;
	retVal->prev=NULL;
	return retVal;
}
void push_next(struct deque *old,struct deque *new){
	printf("push_next: recebendo old=%d e new=%d\n",old->val,new->val);
	if(old->next){
		printf("chamando push_next com old->next=%d\n",old->next->val);
		push_next(old->next,new);
	}else{
		printf("linkando %d -> %d\n",old->val,new->val);
		old->next = new;
		new->prev = old;
	}
}
struct deque* push_prev(struct deque *old,struct deque *new){
	if(old->prev){
		push_next(old->prev,new);
	}else{
		old->prev = new;
		new->next = old;
	}
	return old;
}

struct deque* sort_concat(struct deque *l3,struct deque *l1,struct deque *l2){
	if(l1 || l2){
		if(l1->val < l2->val || !l2){
			push_next(l3,l1);
			sort_concat(l1,l1->next,l2);
		}
		if(l2->val < l1->val || !l1){
			push_next(l3,l2);
			sort_concat(l2,l1,l2->next);
		}
	}
}

