#include<stdio.h>
#include<stdlib.h>
struct node{
	//int val;
	int key;
	struct node *left,*right;
};

struct node *make_tree(int list[],int n){
	if(n){
		struct node *retVal = (struct node*)malloc(sizeof(struct node));
		retVal->key=list[n/2];
		retVal->left=make_tree(list,n/2);
		retVal->right=make_tree(list+n/2+1,n/2-(1-n%2));
		return retVal;
	}else{
		return NULL;
	}

}

int main(){
	int list[] = {1,3,5,7,9,34,900};

	struct node *root = make_tree(list,7);

	return 0;

}
