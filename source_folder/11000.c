
typedef struct Data {
    int from, to;
} Data;

int comp(const void* a, const void* b)
{
    Data A = *(Data*)a;
    Data B = *(Data*)b;

    if(A.from > B.from)
        return 1;
    else if (A.from == B.from)
        return B.to - A.to;
    else
        return -1;
}
typedef struct Heap {
    Data node[262145];
    int size;
} Heap;

Heap heap;

void heap_init();
void push(Data d);
Data pop();
Data top();
bool is_heapable(Data child, Data parent);
void swap(Data* a, Data* b);

int main()
{
    Data arr[202020];
    int n, count = 0;
    scanf("%d", &n);
    for(int i = 0; i < n; i++)
        scanf("%d %d", &arr[i].from, &arr[i].to);
    qsort(arr, n, sizeof(Data), comp);
    // (1, 3) (2, 4) (3, 5)
    // TOP: (1, 3)
    // TOP.to > next.from :: push(next)
    // else :: top = pop(); top.to = next.to; push(top);
    
    heap_init();
    Data dummy = {0, 0};
    push(dummy);
    for(int i = 0; i < n; i++) {
        Data next = arr[i];
        if(top().to <= next.from)
            next.from = pop().from;
        push(next);
    }
    printf("%d\n", heap.size);
    
    return 0;
}



void heap_init()
{
    heap.size = 0;
}


void push(Data d)
{
    heap.node[++heap.size] = d;
    int prt_idx = heap.size/2;
    int chd_idx  = heap.size;

    while(prt_idx >= 1 && is_heapable(heap.node[chd_idx], heap.node[prt_idx]) == false) {
        swap(&heap.node[prt_idx], &heap.node[chd_idx]);
        chd_idx = prt_idx;
        prt_idx = chd_idx/2;
    }
}
Data top()
{
    return heap.node[1];
}


Data pop()
{
    Data popped = heap.node[1];
    heap.node[1] = heap.node[heap.size--];

    int parent = 1;
    int current = 1;
    while(1) {
        current = parent;
        int left = current * 2;
        int right = current * 2 + 1;

        if(left <= heap.size && is_heapable(heap.node[left], heap.node[current]) == false) {
            current = left;
        }

        if(right <= heap.size && is_heapable(heap.node[right], heap.node[current]) == false) {
            current = right;
        }

        if(current == parent) {
            break;
        }

        swap(&heap.node[current], &heap.node[parent]);
        parent = current;
    }

    return popped;
}

bool is_heapable(Data child, Data parent)
{
    return parent.to < child.to;
}

void swap(Data* a, Data* b)
{
    Data tmp = *a;
    *a = *b;
    *b = tmp;
}

