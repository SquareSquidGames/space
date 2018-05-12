module linked.destructive_node;

private static import linked.node;

import std.traits : hasMember;

struct Node(T) if(hasMember!(T,"removed")&&is(typeof(T.removed):bool)) {
	Node!T* _next;
	@property ref Node!T* next() {
		while (_next!=null && _next.payload.removed) {
			// TODO: Compare speed of this and being an `if` and calling `_next.next` rather than `_next._next`.
			_next = _next._next;
		}
		return _next;
	}
	@property void next(Node!T* newNext) {
		_next = newNext;
	}
	
	T payload;
	alias value = payload;
	
	alias payload this;
}

