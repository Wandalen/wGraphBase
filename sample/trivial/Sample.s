
require( 'wgraphextra' );
// require( '..' );

let _ = wTools;

var a = { name : 'a', nodes : [] } // 1
var b = { name : 'b', nodes : [] } // 2
var c = { name : 'c', nodes : [] } // 3
var d = { name : 'd', nodes : [] } // 4
var e = { name : 'e', nodes : [] } // 5

a.nodes.push( b ); // 1
b.nodes.push( e, d ); // 2
c.nodes.push( b ); // 3
d.nodes.push( a, e ); // 4
e.nodes.push( a, c, d ); // 5

var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
var group = sys.groupMake();
group.nodesAdd([ a, b, c, d, e ]);

console.log( 'Tree' );
console.log( group.nodesInfoExportAsTree([ a ]) );

/* output :

Tree
 +-- a
   +-- b
     +-- e
     | +-- c
     | +-- d
     +-- d
       +-- e
         +-- c
*/
