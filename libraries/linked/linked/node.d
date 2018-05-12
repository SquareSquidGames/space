module linked.node;

struct Node(T) {
	Node!T* next;

	T payload;
	alias value = payload;
	
	alias payload this;
}

