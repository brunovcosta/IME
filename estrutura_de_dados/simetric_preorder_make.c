#include<stdio.h>
#include<stdlib.h>
struct node{
	//int val;
	int key;
	struct node *left,*right;
};

struct node *simetric_preorder_make(int p[], int s[], int i, int j){
	struct node *retVal=(struct node*)malloc(sizeof(struct node));
	retVal.key=p[i];

}
int main(){
	int p[] = {10,12,15,29,17,11,30,16,26,18};
	int s[] = {15,29,12,17,10,30,11,16,18,26};

	struct *node = simetric_preorder_make(p,s,0,0);

	struct node *root = make_tree(list,7);

	return 0;

}
