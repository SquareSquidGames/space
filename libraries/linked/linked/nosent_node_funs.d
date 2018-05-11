module linked.nosent_node_funs;

import std.traits : hasMember;







public {
	@property bool empty(T, N)(N!T* node) if(mixin(constrain)) {
		return (node is null);
	}
}
public {
	N!T dup(T, N)(N!T* node) if(mixin(constrain)) {
		return new N!T(node.next, node.payload);
	}
}
public {
	void removeNext(T, N)(N!T* node) if(mixin(constrain)) {
		assert(!node.empty);
		node.next = node.next.next;
	}
	void insertAfter(T, N)(N!T* node, N!T* newNode) if(mixin(constrain)) {
		newNode.next	= node.next;
		node.next	= newNode;
	}
	void insertAfter(T, N)(N!T* node, T value) if(mixin(constrain)) {
		node.insertAfter(new N!T(null, value));
	}
	void redirect(T, N)(N!T* node, N!T* newNode) if(mixin(constrain)) {
		node.next = newNode;
	}
}

public {
	Iterator!T iterator(T, N)(N!T* node)  if(mixin(constrain)) {
		return Iterator!T(node);
	}
	private struct Iterator(T, N) if(mixin(constrain)) {
		private N!T* node;
		@disable this();
		this(N!T* node) {
			this.node = node;
		}
		@property bool empty() {
			return node.empty;
		}
		@property N!T* front() {
			assert(!empty);
			return node;
		}
		void popFront() {
			assert(!empty);
			node = node.next;
		}
	}
}






unittest {
	import std.stdio;
	import std.algorithm.iteration;
	import std.algorithm.searching;

	Node!int* s = new Node!int();
	s.append(4);

	foreach(a;s.iterator){
		a.value.writeln;
	}
	////
	s.insertAfter(5);
	////s = s.next;
	////s = s.next;
	writeln;
	foreach(a;s.iterator){a.value.writeln;}
	////s.find!(a=>a.empty).append(6);

	writeln;
	foreach(a;s.iterator){a.value.writeln;}
	writeln;
	foreach(a;s.iterator){a.value.writeln;}

	s.iterator.each!(a=>a.value.writeln);


	int[][] a = [[4,6,2],[1,2,3]];
	a.each!writeln;
}



private enum constrain = "hasMember!(N!T,\"next\")&&is(typeof(N!T.next:N!T*) && hasMember!(N!T,\"payload\")&&is(typeof(N!T.payload:T)";


