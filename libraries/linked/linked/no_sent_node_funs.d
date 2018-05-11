module linked.no_sent_node_funs;

import std.traits : hasMember;







public {
	@property bool empty(N)(N* node) if(mixin(constrain)){
		return (node is null);
	}
}
public {
	N dup(N)(N* node) if(mixin(constrain)) {
		return new N(node.next, node.payload);
	}
}
public {
	void removeNext(N)(N* node) if(mixin(constrain)) {
		assert(!node.empty);
		node.next = node.next.next;
	}
	void insertAfter(N)(N* node, N* newNode) if(mixin(constrain)) {
		newNode.next	= node.next;
		node.next	= newNode;
	}
	void redirect(N)(N* node, N* newNode) if(mixin(constrain)) {
		node.next = newNode;
	}
}
public {
	Iterator!(N) iterator(N)(N* node) if(mixin(constrain)){
		return Iterator!(N)(node);
	}
	private struct Iterator(N) if(mixin(constrain)){
		private N* node;
		@disable this();
		this(N* node) {
			this.node = node;
		}
		@property bool empty() {
			return node.empty;
		}
		@property N* front() {
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



private enum constrain = "hasMember!(N,\"next\")&&is(typeof(N.next):N*) && hasMember!(N,\"payload\")";


