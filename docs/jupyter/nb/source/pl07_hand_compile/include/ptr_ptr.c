typedef struct node {
  struct node * l;
  struct node * r;
} node;
  
node * left_right(node * n) {
  return n->l->r;
}
