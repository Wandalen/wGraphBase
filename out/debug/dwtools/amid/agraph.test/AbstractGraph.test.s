( function _AbstractGraph_test_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  var _ = require( '../../../Tools.s' );

  _.include( 'wTesting' );

  require( '../graphBasic/IncludeTop.s' );

}

var _ = wTools;

//

function makeByNodes( test )
{

  test.case = 'init, add, delete, finit';

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.groupMake();
  test.identical( group.nodes, [] );

  test.is( sys === group.sys );
  test.identical( sys.groups.length, 1 );

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  d.nodes.push();
  e.nodes.push( c );

  test.identical( group.nodeHas( a ), false );
  test.identical( sys.nodeHas( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( group.nodeHas( a ), true );
  test.identical( sys.nodeHas( a ), true );

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.nodeDelete( d );
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 4 );
  test.identical( sys.nodeToIdHash.size, 4 );
  test.identical( group.nodes.length, 4 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 5 ] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.sys.groups.length, 0 );
  sys.finit();

  /* */

  test.case = 'nodesDelete';

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.groupMake();

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  d.nodes.push();
  e.nodes.push( c );

  test.identical( group.nodeHas( a ), false );
  test.identical( sys.nodeHas( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.nodesDelete([ a, d, e ]);
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 2 );
  test.identical( sys.nodeToIdHash.size, 2 );
  test.identical( group.nodes.length, 2 );
  test.identical( group.nodesToIds( group.nodes ), [ 2, 3 ] );
  logger.log( group.exportInfo() );

  group.nodesDelete();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.nodes.length, 0 );
  test.identical( group.nodesToIds( group.nodes ), [] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  sys.finit();

}

//

function makeByNodesWithInts( test )
{

  test.case = 'init, add, delete, finit';

  function onNodeNameGet( node ){ return node };
  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : onNodeNameGet });
  var group = sys.groupMake();

  group.onOutNodesFor = function onOutNodesFor( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+nodes.length );
    let result = nodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  test.is( sys === group.sys );
  test.identical( sys.groups.length, 1 );

  var a = 11;
  var b = 12;
  var c = 13;
  var d = 14;
  var e = 15;

  var nodes = [];
  nodes[ 0 ] = [ b, c ];
  nodes[ 1 ] = [ a ];
  nodes[ 2 ] = [ a, e ];
  nodes[ 3 ] = [];
  nodes[ 4 ] = [ c ];

  test.identical( group.nodeHas( a ), false );
  test.identical( sys.nodeHas( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( group.nodeHas( a ), true );
  test.identical( sys.nodeHas( a ), true );

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.nodeDelete( d );
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 4 );
  test.identical( sys.nodeToIdHash.size, 4 );
  test.identical( group.nodes.length, 4 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 5 ] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.sys.groups.length, 0 );
  sys.finit();

  /* */

  test.case = 'nodesDelete';

  function onNodeNameGet( node ){ return node };
  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : onNodeNameGet });
  var group = sys.groupMake();

  test.is( sys.onNodeNameGet === onNodeNameGet );
  test.is( group.onNodeNameGet === onNodeNameGet );

  group.onOutNodesFor = function onOutNodesFor( node )
  {
    _.assert( arguments.length === 1 );
    _.assert( 11 <= node && node < 11+nodes.length );
    let result = nodes[ node-11 ];
    _.assert( _.arrayIs( result ) );
    return result;
  }

  test.is( sys === group.sys );
  test.identical( sys.groups.length, 1 );

  var a = 11;
  var b = 12;
  var c = 13;
  var d = 14;
  var e = 15;

  var nodes = [];
  nodes[ 0 ] = [ b, c ];
  nodes[ 1 ] = [ a ];
  nodes[ 2 ] = [ a, e ];
  nodes[ 3 ] = [];
  nodes[ 4 ] = [ c ];

  test.identical( group.nodeHas( a ), false );
  test.identical( sys.nodeHas( a ), false );

  group.nodesAdd([ a, b, c, d, e ]);

  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.nodesDelete([ a, d, e ]);
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 2 );
  test.identical( sys.nodeToIdHash.size, 2 );
  test.identical( group.nodes.length, 2 );
  test.identical( group.nodesToIds( group.nodes ), [ 2, 3 ] );
  logger.log( group.exportInfo() );

  group.nodesDelete();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( group.nodes.length, 0 );
  test.identical( group.nodesToIds( group.nodes ), [] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  sys.finit();

}

//

function clone( test )
{

  test.case = 'trivial';

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  e.nodes.push( c );

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 2, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( sys.groups.length, 1 );

  group2.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( sys.groups.length, 0 );

  sys.finit();

  /* */

  test.case = 'node delete';

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, e );
  e.nodes.push( c );

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  group.nodeDelete( a );
  group2.nodeDelete( b );

  test.identical( group.nodeHas( a ), false );
  test.identical( group.nodeHas( b ), true );
  test.identical( group2.nodeHas( a ), true );
  test.identical( group2.nodeHas( b ), false );
  test.identical( sys.nodeHas( a ), true );
  test.identical( sys.nodeHas( b ), true );

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 4 );
  test.identical( group2.nodes.length, 4 );
  test.identical( sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ), [ 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group2.nodeDelete( a )
  group.nodeDelete( b );

  test.identical( group.nodeHas( a ), false );
  test.identical( group.nodeHas( b ), false );
  test.identical( group2.nodeHas( a ), false );
  test.identical( group2.nodeHas( b ), false );
  test.identical( sys.nodeHas( a ), false );
  test.identical( sys.nodeHas( b ), false );

  test.identical( sys.nodeDescriptorsHash.size, 3 );
  test.identical( sys.idToNodeHash.size, 3 );
  test.identical( sys.nodeToIdHash.size, 3 );
  test.identical( group.nodes.length, 3 );
  test.identical( group2.nodes.length, 3 );
  test.identical( sys.groups.length, 2 );
  test.identical( group.nodesToIds( group.nodes ), [ 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 3, 4, 5 ] );
  logger.log( group.exportInfo() );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 3 );
  test.identical( sys.idToNodeHash.size, 3 );
  test.identical( sys.nodeToIdHash.size, 3 );
  test.identical( sys.groups.length, 1 );

  group2.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( sys.groups.length, 0 );

  sys.finit();

}

//

function reverse( test )
{

  test.case = 'trivial';

  var a = { name : 'a', nodes : [] }
  var b = { name : 'b', nodes : [] }
  var c = { name : 'c', nodes : [] }
  var d = { name : 'd', nodes : [] }
  var e = { name : 'e', nodes : [] }

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( e );
  e.nodes.push( b );

  var sys = new _.graph.AbstractGraphSystem();
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e ]);
  var group2 = group.clone();

  group2.cacheInNodesFromOutNodes();
  group2.reverse();

  logger.log( 'direct' );
  logger.log( group.exportInfo() );
  logger.log( 'reverse' );
  logger.log( group2.exportInfo() );

  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 2, 3, 4, 5 ] );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group.nodesOutNodesFor( group.nodes ).map( ( nodes ) => group.nodesToIds( nodes ) );
  test.identical( outNodes, expected );
  var expected = [ [ 2 ], [ 1, 5 ], [ 1 ], [], [ 3 ] ];
  var outNodes = group2.nodesOutNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( outNodes, expected );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group2.nodesInNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( outNodes, expected );

  group2.reverse();
  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( group.nodes.length, 5 );
  test.identical( group2.nodes.length, 5 );
  test.identical( sys.groups.length, 2 );
  test.is( group.nodes !== group2.nodes );
  test.identical( group.nodesToIds( group.nodes ), [ 1, 2, 3, 4, 5 ] );
  test.identical( group2.nodesToIds( group2.nodes ), [ 1, 2, 3, 4, 5 ] );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group.nodesOutNodesFor( group.nodes ).map( ( nodes ) => group.nodesToIds( nodes ) );
  test.identical( outNodes, expected );
  var expected = [ [ 2, 3 ], [ 1 ], [ 5 ], [], [ 2 ] ];
  var outNodes = group2.nodesOutNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( outNodes, expected );
  var expected = [ [ 2 ], [ 1, 5 ], [ 1 ], [], [ 3 ] ];
  var outNodes = group2.nodesInNodesFor( group2.nodes ).map( ( nodes ) => group2.nodesToIds( nodes ) );
  test.identical( outNodes, expected );

  group.finit();
  test.identical( sys.nodeDescriptorsHash.size, 5 );
  test.identical( sys.idToNodeHash.size, 5 );
  test.identical( sys.nodeToIdHash.size, 5 );
  test.identical( sys.groups.length, 1 );

  group2.finit();
  test.identical( sys.nodeDescriptorsHash.size, 0 );
  test.identical( sys.idToNodeHash.size, 0 );
  test.identical( sys.nodeToIdHash.size, 0 );
  test.identical( sys.groups.length, 0 );

  sys.finit();

}

//

function sinksOnlyAmong( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  var got = group.sinksOnlyAmong();
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

}

//

function sourcesOnlyAmong( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  var got = group.sourcesOnlyAmong();
  var expected = [ 'd', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

}

//

function leastMostDegreeAmong( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);

  test.case = 'all nodes';

  var got = group.leastIndegreeAmong();
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong();
  var expected = [ 'd', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostIndegreeAmong();
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong();
  var expected = [ 'h' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.leastOutdegreeAmong();
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong();
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostOutdegreeAmong();
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong();
  var expected = [ 'e' ];
  test.identical( group.nodesToNames( got ), expected );

  test.case = 'no least indegree';

  var got = group.leastIndegreeAmong([ a, b, c, e, f, g, h, i ]);
  var expected = 1;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ a, b, c, e, f, g, h, i ]);
  var expected = [ 'c', 'e', 'g', 'i' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostIndegreeAmong([ a, b, c, e, f, g, h, i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ a, b, c, e, f, g, h, i ]);
  var expected = [ 'h' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.leastOutdegreeAmong([ a, b, c, e, f, g, h, i ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ a, b, c, e, f, g, h, i ]);
  var expected = [ 'f' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostOutdegreeAmong([ a, b, c, e, f, g, h, i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ a, b, c, e, f, g, h, i ]);
  var expected = [ 'e' ];
  test.identical( group.nodesToNames( got ), expected );

  test.case = 'no most indegree';

  var got = group.leastIndegreeAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = [ 'd', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostIndegreeAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = 2;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = [ 'a', 'b', 'f' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.leastOutdegreeAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostOutdegreeAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ a, b, c, d, e, f, g, i, j ]);
  var expected = [ 'e' ];
  test.identical( group.nodesToNames( got ), expected );

  test.case = 'no leasr outdegree';

  var got = group.leastIndegreeAmong([ a, b, c, d, e, g, h, i ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ a, b, c, d, e, g, h, i ]);
  var expected = [ 'd' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostIndegreeAmong([ a, b, c, d, e, g, h, i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ a, b, c, d, e, g, h, i ]);
  var expected = [ 'h' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.leastOutdegreeAmong([ a, b, c, d, e, g, h, i ]);
  var expected = 1;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ a, b, c, d, e, g, h, i ]);
  var expected = [ 'a', 'c', 'g', 'h' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostOutdegreeAmong([ a, b, c, d, e, g, h, i ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ a, b, c, d, e, g, h, i ]);
  var expected = [ 'e' ];
  test.identical( group.nodesToNames( got ), expected );

  test.case = 'no most outdegree';

  var got = group.leastIndegreeAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastIndegreeOnlyAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = [ 'd', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostIndegreeAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = 3;
  test.identical( got, expected );
  var got = group.mostIndegreeOnlyAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = [ 'h' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.leastOutdegreeAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = 0;
  test.identical( got, expected );
  var got = group.leastOutdegreeOnlyAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = [ 'f', 'j' ];
  test.identical( group.nodesToNames( got ), expected );

  var got = group.mostOutdegreeAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = 2;
  test.identical( got, expected );
  var got = group.mostOutdegreeOnlyAmong([ a, b, c, d, f, g, h, i, j ]);
  var expected = [ 'b', 'd', 'i' ];
  test.identical( group.nodesToNames( got ), expected );

}

//

function lookBfs( test )
{

  var nds = [];
  var ups = [];
  var dws = [];
  var lups = [];
  var ldws = [];

  function clean()
  {
    nds = [];
    ups = [];
    dws = [];
    lups = [];
    ldws = [];
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onLayerUp( nodes, it )
  {
    lups.push( group.nodesToNames( nodes ) );
  }

  function onLayerDown( nodes, it )
  {
    ldws.push( group.nodesToNames( nodes ) );
  }

/*
  1 : 2
  2 : 6
  3 : 2
  4 : 1 7
  5 : 1 3 8
  6 :
  7 : 8
  8 : 9
  9 : 6 8
  10 :
*/

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  test.identical( group.nodes.length, 10 );
  logger.log( group.exportInfo() );

  /* */

  test.case = 'all';

  clean();
  var layers = group.lookBfs({ nodes : group.nodes, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected = [ [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ] ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedUps = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedDws = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ];
  var expectedLups =
  [
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ],
    [ 'b', 'e', 'f', 'b', 'a', 'g', 'a', 'c', 'h', 'h', 'i', 'f', 'h' ],
  ];
  var expectedLdws =
  [
    [],
    [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j' ],
  ];

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'only a';

  clean();
  var layers = group.lookBfs({ nodes : a, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected = [ [ 'a' ], [ 'b' ], [ 'e', 'f' ], [ 'c', 'h' ], [ 'i' ] ];
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedUps = [ 'a', 'b', 'e', 'f', 'c', 'h', 'i' ];
  var expectedDws = [ 'i', 'c', 'h', 'e', 'f', 'b', 'a' ];
  var expectedLups =
  [
    [ 'a' ],
    [ 'b' ],
    [ 'e', 'f' ],
    [ 'a', 'c', 'h' ],
    [ 'b', 'i' ],
    [ 'f', 'h' ]
  ];
  var expectedLdws =
  [
    [],
    [ 'i' ],
    [ 'c', 'h' ],
    [ 'e', 'f' ],
    [ 'b' ],
    [ 'a' ]
  ];

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'only d';

  clean();
  var layers = group.lookBfs({ nodes : d, onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'c', 'e', 'f', 'i', 'b', 'h', 'a', 'g', 'd' ];
  var expectedLups =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'a', 'c', 'h', 'f', 'h' ],
    [ 'b' ]
  ]
  var expectedLdws =
  [
    [],
    [ 'c' ],
    [ 'e', 'f', 'i' ],
    [ 'b', 'h' ],
    [ 'a', 'g' ],
    [ 'd' ]
  ]

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  test.case = 'd and a';

  clean();
  var layers = group.lookBfs({ nodes : [ d, a ], onNode, onUp, onDown, onLayerUp, onLayerDown });

  var expected =
  [
    [ 'd', 'a' ],
    [ 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'c' ]
  ]
  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  var expectedNds = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedUps = [ 'd', 'a', 'g', 'b', 'h', 'e', 'f', 'i', 'c' ];
  var expectedDws = [ 'i', 'c', 'h', 'e', 'f', 'g', 'b', 'd', 'a' ];
  var expectedLups =
  [
    [ 'd', 'a' ],
    [ 'a', 'g', 'b' ],
    [ 'h', 'e', 'f' ],
    [ 'i', 'a', 'c', 'h' ],
    [ 'f', 'h', 'b' ]
  ]
  var expectedLdws =
  [
    [],
    [ 'i', 'c' ],
    [ 'h', 'e', 'f' ],
    [ 'g', 'b' ],
    [ 'd', 'a' ]
  ]

  test.identical( nds, expectedNds );
  test.identical( ups, expectedUps );
  test.identical( dws, expectedDws );
  test.identical( lups, expectedLups );
  test.identical( ldws, expectedLdws );

  /* */

  sys.finit();

} /* end of lookBfs */

//

function lookBfsRevisiting( test )
{

  var nds = [];
  var ups = [];
  var dws = [];
  var lups = [];
  var ldws = [];

  function clean()
  {
    nds = [];
    ups = [];
    dws = [];
    lups = [];
    ldws = [];
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  function onUp( node, it )
  {
    if( it.level > 4 )
    it.continueUp = 0;
    ups.push( group.nodesToNames( node ) );
  }

  function onUp2( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onLayerUp( nodes, it )
  {
    lups.push( group.nodesToNames( nodes ) );
  }

  function onLayerUp2( nodes, it )
  {
    if( it.level > 4 )
    it.continueUp = 0;
    lups.push( group.nodesToNames( nodes ) );
  }

  function onLayerDown( nodes, it )
  {
    ldws.push( group.nodesToNames( nodes ) );
  }

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];

    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ],
      [ 'b', 'd', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'a', 'e', 'f' ],
      [ 'c', 'd' ],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      nodes : e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups =
    [
      [ 'e' ],
      []
    ]
    var expectedLdws =
    [
      [],
      [ 'e' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      nodes : f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedNds = [ 'f' ];
    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    var expectedLups =
    [
      [ 'f' ],
      [ 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'f' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 0' );

    test.open( 'revisiting : 1' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];

    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ],
      [ 'b', 'd', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'a', 'e', 'f' ],
      [ 'c', 'd' ],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      nodes : e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups =
    [
      [ 'e' ],
      []
    ]
    var expectedLdws =
    [
      [],
      [ 'e' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      nodes : f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedNds = [ 'f' ];
    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    var expectedLups =
    [
      [ 'f' ],
      [ 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'f' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 1' );

    test.open( 'revisiting : 2' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f' ];
    var expectedDws = [ 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'f' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'd', 'f' ];
    var expectedDws = [ 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b' ];

    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ],
      [ 'b', 'd', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'a', 'e', 'f' ],
      [ 'c', 'd' ],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      nodes : e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups =
    [
      [ 'e' ],
      []
    ]
    var expectedLdws =
    [
      [],
      [ 'e' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      nodes : f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedNds = [ 'f', 'f' ];
    var expectedUps = [ 'f', 'f' ];
    var expectedDws = [ 'f', 'f' ];

    var expectedLups =
    [
      [ 'f' ],
      [ 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'f' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 2' );

    test.open( 'revisiting : 3' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedDws = [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'b' ];

    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      nodes : e,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups =
    [
      [ 'e' ],
      []
    ]
    var expectedLdws =
    [
      [],
      [ 'e' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      nodes : f,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f' ];

    var expectedLups =
    [
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ]


    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 3' );

    test.open( 'revisiting : 3, with onLayerUp' );

    /* - */

    test.case = 'only a';

    clean();
    var got = group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ];
    var expectedDws = [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'a' ];

    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'f' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
      [ 'b', 'd' ],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b';

    clean();
    var got = group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'd', 'b', 'b' ];

    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'a', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'c', 'd', 'b', 'c', 'e', 'f', 'b', 'd', 'f', 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'b', 'd', 'a', 'f', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f', 'c', 'd', 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only e';

    clean();
    var got = group.lookBfs
    ({
      nodes : e,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'e' ];
    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    var expectedLups =
    [
      [ 'e' ],
      []
    ]
    var expectedLdws =
    [
      [],
      [ 'e' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only f';

    clean();
    var got = group.lookBfs
    ({
      nodes : f,
      onNode,
      onUp : onUp2,
      onDown,
      onLayerUp : onLayerUp2,
      onLayerDown,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedNds = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f' ];

    var expectedLups =
    [
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ],
      [ 'f' ]
    ]


    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'revisiting : 3, with onLayerUp' );

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookBfsRevisiting */

//

function lookBfsExcluding( test )
{

  var nds = [];
  var ups = [];
  var dws = [];
  var lups = [];
  var ldws = [];

  function clean()
  {
    nds = [];
    ups = [];
    dws = [];
    lups = [];
    ldws = [];
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  function onUp( node, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( group.nodesToNames( node ) );
  }

  function onUp2( node, it )
  {
    if( it.level > 0 )
    it.continueUp = 0;
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    if( it.continueNode )
    dws.push( group.nodesToNames( node ) );
  }

  function onDown2( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onLayerUp( nodes, it )
  {
    lups.push( group.nodesToNames( nodes ) );
  }

  function onLayerUp3( nodes, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    lups.push( group.nodesToNames( nodes ) );
  }

  function onLayerUp4( nodes, it )
  {
    if( it.level > 0 )
    it.continueUp = 0;
    lups.push( group.nodesToNames( nodes ) );
  }

  function onLayerDown( nodes, it )
  {
    ldws.push( group.nodesToNames( nodes ) );
  }

  function onLayerDown3( nodes, it )
  {
    if( it.continueNode )
    ldws.push( group.nodesToNames( nodes ) );
  }

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding elements';

    clean();
    group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
      [ 'c', 'd', 'b', 'c', 'e', 'f' ],
    ]
    var expectedLdws =
    [
      [],
      [ 'b', 'd' ],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, excluding elements';

    clean();
    group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp,
      onDown,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
      [ 'a', 'c', 'e', 'f' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'c', 'd' ],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only a, not visiting elements';

    clean();
    group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp : onUp2,
      onDown : onDown2,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
    ]
    var expectedLdws =
    [
      [],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, not visiting elements';

    clean();
    group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp : onUp2,
      onDown : onDown2,
      onLayerUp,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only a, excluding layers';

    clean();
    group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp3,
      onLayerDown : onLayerDown3,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
    ]
    var expectedLdws =
    [
      [ 'b', 'd' ],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, excluding layers';

    clean();
    group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp3,
      onLayerDown : onLayerDown3,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ],
    ]
    var expectedLdws =
    [
      [ 'c', 'd' ],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only a, not visiting layers';

    clean();
    group.lookBfs
    ({
      nodes : a,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp4,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];
    var expectedLups =
    [
      [ 'a' ],
      [ 'b', 'd' ],
    ]
    var expectedLdws =
    [
      [],
      [ 'a' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* */

    test.case = 'only b, not visiting layers';

    clean();
    group.lookBfs
    ({
      nodes : b,
      onNode,
      onUp,
      onDown,
      onLayerUp : onLayerUp4,
      onLayerDown,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];
    var expectedLups =
    [
      [ 'b' ],
      [ 'c', 'd', 'b' ]
    ]
    var expectedLdws =
    [
      [],
      [ 'b' ]
    ]

    test.identical( nds, expectedNds );
    test.identical( ups, expectedUps );
    test.identical( dws, expectedDws );
    test.identical( lups, expectedLups );
    test.identical( ldws, expectedLdws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookBfsExcluding */

//

function lookDfs( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

/*
  1 : 2
  2 : 6
  3 : 2
  4 : 1 7
  5 : 1 3 8
  6 :
  7 : 8
  8 : 9
  9 : 6 8
  10 :
*/

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  test.identical( group.nodes.length, 10 );
  logger.log( group.exportInfo() );

  test.case = 'all'; /* */

  clean();
  group.lookDfs({ nodes : group.nodes, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  a  b  e  c  h  i  f  d  g  j
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6, 4, 7, 10 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4, 10 ];
  //                  c  f  i  h  e  b  a  g  d  j

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  test.case = 'only a'; /* */

  clean();
  group.lookDfs({ nodes : a, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  a  b  e  c  h  i  f
  var expectedUps = [ 1, 2, 5, 3, 8, 9, 6 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1 ];
  //                  c  f  i  h  e  b  a

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  test.case = 'only d'; /* */

  clean();
  group.lookDfs({ nodes : d, onUp : onUp, onDown : onDown, onNode : onNode });

  //                  d  a  b  e  c  h  i  f  g
  var expectedUps = [ 4, 1, 2, 5, 3, 8, 9, 6, 7 ];
  var expectedDws = [ 3, 6, 9, 8, 5, 2, 1, 7, 4 ];
  //                  c  f  i  h  e  b  a  g  d

  test.identical( group.nodesToIds( ups ), expectedUps );
  test.identical( group.nodesToIds( dws ), expectedDws );

  /* */

  sys.finit();

} /* end of lookDfs */

//

function lookDfsRevisiting( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 7 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  // group.nodesAdd([ a, b, c, d, e ]);
  // test.identical( group.nodes.length, 10 );
  // logger.log( group.exportInfo() );

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
    var expectedDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
    var expectedDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 0' );
    test.open( 'revisiting : 1' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'c', 'd', 'c', 'e', 'f', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'c', 'e', 'f', 'd', 'b', 'c', 'e', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'd', 'e', 'f', 'd', 'c', 'a', 'e', 'f' ];
    var expectedDws = [ 'e', 'f', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'd', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 1' );

    test.open( 'revisiting : 2' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

 /* var expectedUps = [ 'a', 'b', 'c',      'd', 'c',      'e', 'f',           'd', 'c',      'e', 'f'      ]; */
    var expectedUps = [ 'a', 'b', 'c', 'a', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'd', 'c', 'a', 'e', 'f', 'f' ];
    var expectedDws = [ 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'b', 'd', 'c', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'b' ];
    var expectedDws = [ 'b', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f' ];
    var expectedDws = [ 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 2' );

    test.open( 'revisiting : 3' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ]
    var expectedDws = [ 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only b';

    clean();
    group.lookDfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'e', 'f', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b', 'd', 'c', 'a', 'e', 'f', 'f', 'd', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'e', 'f', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'c', 'd', 'b', 'd', 'c', 'e', 'f', 'd', 'c', 'a', 'b', 'd', 'e', 'f', 'f', 'f', 'b', 'c', 'a', 'b', 'd', 'd', 'c', 'a', 'e', 'f', 'f', 'b', 'c', 'a', 'd', 'c', 'e', 'f', 'b', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only e';

    clean();
    group.lookDfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only f';

    clean();
    group.lookDfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* - */

    test.close( 'revisiting : 3' );

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDfsRevisiting */

//

function lookDfsExcluding( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function handleUp2( nodeHandle, it )
  {
    if( it.level > 0 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function handleDown2( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding';

    clean();
    group.lookDfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, excluding';

    clean();
    group.lookDfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only a, not visiting';

    clean();
    group.lookDfs
    ({
      nodes : a,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, not visiting';

    clean();
    group.lookDfs
    ({
      nodes : b,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDfsExcluding */

//

function lookDbfsRevisiting( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 7 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  // group.nodesAdd([ a, b, c, d, e ]);
  // test.identical( group.nodes.length, 10 );
  // logger.log( group.exportInfo() );

  run({ fast : 0 });
  run({ fast : 1 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    test.open( 'revisiting : 0' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
    var expectedDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 0,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 0' );

    test.open( 'revisiting : 1' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'c', 'e', 'f', 'c', 'e', 'f' ];
    var expectedDws = [ 'c', 'c', 'e', 'f', 'd', 'b', 'c', 'e', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'a', 'd', 'e', 'f', 'c', 'e', 'f', 'a' ];
    var expectedDws = [ 'e', 'f', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'd', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 1,
      fast : o.fast,
    });

    var expectedUps = [ 'f' ];
    var expectedDws = [ 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 1' );

    test.open( 'revisiting : 2' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'f' ];
    var expectedDws = [ 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f' ];
    var expectedDws = [ 'b', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'd', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 2,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f' ];
    var expectedDws = [ 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'revisiting : 2' );

    test.open( 'revisiting : 3' );

    /* - */

    test.case = 'only a';

    clean();
    group.lookDbfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'a' ];
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only b';

    clean();
    group.lookDbfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'b', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b', 'c', 'e', 'f', 'a', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'f', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'd', 'b', 'c', 'e', 'f', 'c', 'e', 'f', 'a', 'b', 'd', 'f', 'f', 'c', 'd', 'b', 'a', 'b', 'd', 'c', 'e', 'f', 'a', 'f', 'c', 'd', 'b', 'a', 'c', 'e', 'f', 'c', 'd', 'b' ];
    var expectedDws = [ 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'a', 'c', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'f', 'd', 'c', 'd', 'b', 'b', 'c', 'e', 'f', 'd', 'a', 'c', 'b', 'd', 'a', 'c', 'e', 'f', 'f', 'f', 'd', 'b', 'd', 'a', 'c', 'a', 'c', 'e', 'f', 'f', 'd', 'a', 'c', 'c', 'e', 'f', 'd', 'c', 'd', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b', 'b' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only e';

    clean();
    group.lookDbfs
    ({
      nodes : e,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'e' ];
    var expectedDws = [ 'e' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* */

    test.case = 'only f';

    clean();
    group.lookDbfs
    ({
      nodes : f,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      revisiting : 3,
      fast : o.fast,
    });

    var expectedUps = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];
    var expectedDws = [ 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f', 'f' ];

    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );
    test.identical( expectedUps.length, expectedDws.length );

    /* - */

    test.close( 'revisiting : 3' );

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDbfsRevisiting */

//

function lookDbfsExcluding( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( nodeHandle, it )
  {
    if( it.level > 1 )
    it.continueNode = 0;
    if( it.continueNode )
    ups.push( nodeHandle );
  }

  function onDown( nodeHandle, it )
  {
    if( it.continueNode )
    dws.push( nodeHandle );
  }

  function handleUp2( nodeHandle, it )
  {
    if( it.level > 0 )
    it.continueUp = 0;
    ups.push( nodeHandle );
  }

  function handleDown2( nodeHandle, it )
  {
    dws.push( nodeHandle );
  }

  function onNode( nodeHandle, it )
  {
    nds.push( nodeHandle );
  }

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  run({ fast : 1 });
  run({ fast : 0 });

  /* - */

  sys.finit();

  function run( o )
  {

    test.open( 'fast : ' + o.fast );

    /* - */

    test.case = 'only a, excluding';

    clean();
    group.lookDbfs
    ({
      nodes : a,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, excluding';

    clean();
    group.lookDbfs
    ({
      nodes : b,
      onUp : onUp,
      onDown : onDown,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only a, not visiting';

    clean();
    group.lookDbfs
    ({
      nodes : a,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'a', 'b', 'd' ];
    var expectedUps = [ 'a', 'b', 'd' ];
    var expectedDws = [ 'b', 'd', 'a' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* */

    test.case = 'only b, not visiting';

    clean();
    group.lookDbfs
    ({
      nodes : b,
      onUp : handleUp2,
      onDown : handleDown2,
      onNode : onNode,
      fast : o.fast,
    });

    var expectedNds = [ 'b', 'c', 'd' ];
    var expectedUps = [ 'b', 'c', 'd' ];
    var expectedDws = [ 'c', 'd', 'b' ];

    test.identical( group.nodesToNames( nds ), expectedNds );
    test.identical( group.nodesToNames( ups ), expectedUps );
    test.identical( group.nodesToNames( dws ), expectedDws );

    /* - */

    test.close( 'fast : ' + o.fast );
  }

} /* end of lookDbfsExcluding */

//

function eachBfs( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  /* - */

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'e', 'f', 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, e';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'c', 'a', 'd', 'f' ];
  var expUps = [ 'c', 'a', 'd', 'f' ];
  var expDws = [ 'c', 'a', 'd', 'f' ];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'mandatory : 1, f';
  clean();
  var exp = [];
  var expNds = [];
  var expUps = [];
  var expDws = [];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'recursive : 1, a';
  clean();
  var exp = [ 'a', 'b', 'd' ];
  var expNds = [ 'a', 'b', 'd' ];
  var expUps = [ 'a', 'b', 'd' ];
  var expDws = [ 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, b';
  clean();
  var exp = [ 'b', 'c', 'd' ];
  var expNds = [ 'b', 'c', 'd' ];
  var expUps = [ 'b', 'c', 'd' ];
  var expDws = [ 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, a';
  clean();
  var exp = [ 'a' ];
  var expNds = [ 'a' ];
  var expUps = [ 'a' ];
  var expDws = [ 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : a, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, b';
  clean();
  var exp = [ 'b' ];
  var expNds = [ 'b' ];
  var expUps = [ 'b' ];
  var expDws = [ 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : b, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : e, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookBfs', nodes : f, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

} /* end of eachBfs */

//

function eachDfs( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  /* - */

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, b';
  clean();
  var exp = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, a';
  clean();
  var exp = [ 'a', 'b', 'c', 'd', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, b';
  clean();
  var exp = [ 'b', 'c', 'a', 'd', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, a';
  clean();
  var exp = [ 'b', 'c', 'd', 'f' ];
  var expNds = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'c', 'd', 'e', 'f' ];
  var expDws = [ 'c', 'e', 'f', 'd', 'b', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, b';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'a', 'd', 'e', 'f' ];
  var expDws = [ 'e', 'f', 'd', 'a', 'c', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, e';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'c', 'a', 'd', 'f' ];
  var expUps = [ 'c', 'a', 'd', 'f' ];
  var expDws = [ 'c', 'a', 'd', 'f' ];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'mandatory : 1, f';
  clean();
  var exp = [];
  var expNds = [];
  var expUps = [];
  var expDws = [];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'recursive : 1, a';
  clean();
  var exp = [ 'a', 'b', 'd' ];
  var expNds = [ 'a', 'b', 'd' ];
  var expUps = [ 'a', 'b', 'd' ];
  var expDws = [ 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, b';
  clean();
  var exp = [ 'b', 'c', 'd' ];
  var expNds = [ 'b', 'c', 'd' ];
  var expUps = [ 'b', 'c', 'd' ];
  var expDws = [ 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, a';
  clean();
  var exp = [ 'a' ];
  var expNds = [ 'a' ];
  var expUps = [ 'a' ];
  var expDws = [ 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : a, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, b';
  clean();
  var exp = [ 'b' ];
  var expNds = [ 'b' ];
  var expUps = [ 'b' ];
  var expDws = [ 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : b, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : e, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDfs', nodes : f, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

} /* end of eachDfs */

//

function eachDbfs( test )
{

  var ups = [];
  var dws = [];
  var nds = [];

  function clean()
  {
    ups = [];
    dws = [];
    nds = [];
  }

  function onUp( node, it )
  {
    ups.push( group.nodesToNames( node ) );
  }

  function onDown( node, it )
  {
    dws.push( group.nodesToNames( node ) );
  }

  function onNode( node, it )
  {
    nds.push( group.nodesToNames( node ) );
  }

  /* - */

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, d ); // 1
  b.nodes.push( c, d, b ); // 2
  c.nodes.push( a ); // 3
  d.nodes.push( c, e, f ); // 4
  e.nodes.push(); // 5
  f.nodes.push( f ); // 6

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  /* */

  test.case = 'default, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'default, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'e', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'e', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, a';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, b';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'includingBranches : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f, includingBranches : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, a';
  clean();
  var exp = [ 'a', 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, b';
  clean();
  var exp = [ 'b', 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f, withTerminals : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, e';
  clean();
  var exp = [];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'withTerminals : 0, withStem/*maybe withTransient*/ : 0, f';
  clean();
  var exp = [];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, a';
  clean();
  var exp = [ 'b', 'd', 'c', 'f' ];
  var expNds = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expUps = [ 'a', 'b', 'd', 'c', 'e', 'f' ];
  var expDws = [ 'c', 'b', 'e', 'f', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, b';
  clean();
  var exp = [ 'c', 'd', 'a', 'f' ];
  var expNds = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expUps = [ 'b', 'c', 'd', 'a', 'e', 'f' ];
  var expDws = [ 'a', 'c', 'e', 'f', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'mandatory : 1, e';
  clean();
  var exp = [ 'c', 'a', 'd', 'f' ];
  var expNds = [ 'c', 'a', 'd', 'f' ];
  var expUps = [ 'c', 'a', 'd', 'f' ];
  var expDws = [ 'c', 'a', 'd', 'f' ];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'mandatory : 1, f';
  clean();
  var exp = [];
  var expNds = [];
  var expUps = [];
  var expDws = [];
  test.shouldThrowErrorSync( () =>
  {
    var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f, withTerminals : 0, withStem/*maybe withTransient*/ : 0, mandatory : 1 });
    test.identical( group.nodesToNames( got ), exp );
    test.identical( nds, expNds );
    test.identical( ups, expUps );
    test.identical( dws, expDws );
  });

  /* */

  test.case = 'recursive : 1, a';
  clean();
  var exp = [ 'a', 'b', 'd' ];
  var expNds = [ 'a', 'b', 'd' ];
  var expUps = [ 'a', 'b', 'd' ];
  var expDws = [ 'b', 'd', 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, b';
  clean();
  var exp = [ 'b', 'c', 'd' ];
  var expNds = [ 'b', 'c', 'd' ];
  var expUps = [ 'b', 'c', 'd' ];
  var expDws = [ 'c', 'd', 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 1, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f, recursive : 1 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, a';
  clean();
  var exp = [ 'a' ];
  var expNds = [ 'a' ];
  var expUps = [ 'a' ];
  var expDws = [ 'a' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : a, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, b';
  clean();
  var exp = [ 'b' ];
  var expNds = [ 'b' ];
  var expUps = [ 'b' ];
  var expDws = [ 'b' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : b, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, e';
  clean();
  var exp = [ 'e' ];
  var expNds = [ 'e' ];
  var expUps = [ 'e' ];
  var expDws = [ 'e' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : e, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

  test.case = 'recursive : 0, f';
  clean();
  var exp = [ 'f' ];
  var expNds = [ 'f' ];
  var expUps = [ 'f' ];
  var expDws = [ 'f' ];
  var got = group.each({ onNode, onUp, onDown, method : 'lookDbfs', nodes : f, recursive : 0 });
  test.identical( group.nodesToNames( got ), exp );
  test.identical( nds, expNds );
  test.identical( ups, expUps );
  test.identical( dws, expDws );

  /* */

} /* end of eachDbfs */

//

function topologicalSortDfs( test )
{

  test.case = 'trivial';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6

  a.nodes.push( b, c );
  b.nodes.push( d, e );
  c.nodes.push();
  d.nodes.push( c );
  e.nodes.push( f );
  f.nodes.push();

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f ]);
  logger.log( 'DAG' )
  logger.log( group.nodesInfoExport() );

  var ordering = group.topologicalSortDfs();
  logger.log( 'Ordering' )
  logger.log( group.nodesInfoExport( ordering ) );

  var expected = [ 3, 4, 6, 5, 2, 1 ];
  test.identical( group.nodesToIds( ordering ), expected );

}

//

function topologicalSortSourceBasedBfs( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  logger.log( group.exportInfo() );

  /* */

  test.case = 'all';

  var layers = group.topologicalSortSourceBasedBfs();

  var expected =
  [
    [ 'd', 'j' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'not j';

  var layers = group.topologicalSortSourceBasedBfs([ a, b, c, d, e, f, g, h, i ]);

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'not j, not d';

  var layers = group.topologicalSortSourceBasedBfs([ a, b, c, e, f, g, h, i ]);

  var expected =
  [
    [ 'c', 'e', 'g', 'i' ],
    [ 'b', 'a', 'h', 'f' ]
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'c, e';

  var layers = group.topologicalSortSourceBasedBfs([ c, e ]);

  var expected =
  [
    [ 'c', 'e' ],
    [ 'b', 'a', 'h' ],
    [ 'f', 'i' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  sys.finit();
  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3

  a.nodes.push( b, c ); // 1
  b.nodes.push( a ); // 2
  c.nodes.push(); // 3

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c ]);
  logger.log( group.exportInfo() );

  /* */

  var layers = group.topologicalSortSourceBasedBfs();

  var expected =
  [
    [ 'a', 'b', 'c' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  sys.finit();

}

//

function topologicalSortCycledSourceBasedBfs( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  logger.log( group.exportInfo() );

  /* */

  test.case = 'all';

  var layers = group.topologicalSortCycledSourceBasedBfs();

  var expected =
  [
    [ 'j', 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'not j';

  var layers = group.topologicalSortCycledSourceBasedBfs([ a, b, c, d, e, f, g, h, i ]);

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ]

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'not j, not d';

  var layers = group.topologicalSortCycledSourceBasedBfs([ a, b, c, e, f, g, h, i ]);

  var expected =
  [
    [ 'd' ],
    [ 'a', 'g' ],
    [ 'b', 'h' ],
    [ 'e', 'f', 'i' ],
    [ 'c' ]
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  test.case = 'c, e';

  test.shouldThrowErrorSync( () => group.topologicalSortCycledSourceBasedBfs([ c, e ]) );

  var expected = [];

  /* */

  sys.finit();
  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3

  a.nodes.push( b, c ); // 1
  b.nodes.push( a ); // 2
  c.nodes.push(); // 3

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  group.nodesAdd([ a, b, c ]);
  logger.log( group.exportInfo() );

  /* */

  var layers = group.topologicalSortCycledSourceBasedBfs();

  var expected =
  [
    [ 'a', 'b' ],
    [ 'c' ],
  ];

  test.identical( layers.map( ( nodes ) => group.nodesToNames( nodes ) ), expected );

  /* */

  sys.finit();

}

//

function nodesAreConnectedDfs( test )
{

  test.case = 'setup';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  test.identical( group.nodes.length, 8 );
  logger.log( group.exportInfo() );

  test.case = 'a';

  var connected = group.nodesAreConnectedDfs( a, a );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( a, b );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( a, e );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( a, g );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( a, f );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( a, g );
  test.identical( connected, false );

  test.case = 'g';

  var connected = group.nodesAreConnectedDfs( g, g );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( g, f );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( g, b );
  test.identical( connected, false );

  var connected = group.nodesAreConnectedDfs( f, g );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( f, f );
  test.identical( connected, true );

  var connected = group.nodesAreConnectedDfs( f, b );
  test.identical( connected, false );

}

//

function groupByConnectivityDfs( test )
{

  test.case = 'setup';

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8

  a.nodes.push( b, c );
  b.nodes.push( a );
  c.nodes.push( a, d );
  d.nodes.push( c );
  f.nodes.push( g );
  g.nodes.push( f, h );
  h.nodes.push( g );

  group.nodesAdd([ a, b, c, d, e, f, g, h ]);
  test.identical( group.nodes.length, 8 );
  logger.log( group.exportInfo() );

  test.case = 'explicit';

  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  var groups = group.groupByConnectivityDfs( group.nodes );
  test.identical( groups.length, 3 );
  test.identical( groups, expected );

  test.case = 'implicit';

  var expected = [ [ 1, 2, 3, 4 ], [ 5 ], [ 6, 7, 8 ] ];
  var groups = group.groupByConnectivityDfs();
  test.identical( groups.length, 3 );
  test.identical( groups, expected );

}

//

function groupByStrongConnectivityDfs( test )
{

  test.case = 'setup';

/*
  1 : 2
  2 : 6
  3 : 2
  4 : 1 7
  5 : 1 3 8
  6 :
  7 : 8
  8 : 9
  9 : 6 8
  10 :
*/

  // 3, 2, 5, 1 -> c, b, e, a

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  test.identical( group.nodes.length, 10 );
  logger.log( group.exportInfo() );

  var expected = [ [ j ], [ f ], [ i, h ], [ g ], [ a, b, e, c ], [ d ] ];
  var groups = group.groupByStrongConnectivityDfs( group.nodes );
  test.identical( groups, expected );

  var expectedIds = [ [ 10 ], [ 6 ], [ 9, 8 ], [ 7 ], [ 1, 2, 5, 3 ], [ 4 ] ];
  var groupsIds = groups.map( ( nodes ) => group.nodesToIds( nodes ) );
  test.identical( groupsIds, expectedIds );

}

//

function stronglyConnectedTreeForDfs( test )
{

  /* - */

  test.case = 'trivial';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3

  a.nodes.push( b, c ); // 1
  b.nodes.push( a ); // 2
  c.nodes.push(); // 3

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake({});

  group.nodesAdd([ a, b, c ]);
  logger.log( 'Original' );
  logger.log( group.exportInfo() );

  /* */

  var group2 = group.stronglyConnectedTreeForDfs();

  var originalNodes = group2.nodes.map( ( node ) => sys.idsToNodes( node.originalNodes ) );
  var originalNodesNames = originalNodes.map( ( node ) => group.nodesToNames( node ) );
  var expected = [ [ 'c' ], [ 'a', 'b' ] ];
  test.identical( originalNodesNames, expected );

  var outNodes = group2.nodes.map( ( node ) => node.outNodes );
  var expected = [ [], [ 4 ] ];
  test.identical( outNodes, expected );

  logger.log( 'Tree' );
  logger.log( group2.exportInfo() );

  sys.finit();

  /* - */

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);
  logger.log( 'Original' );
  logger.log( group.exportInfo() );

  /* */

  var group2 = group.stronglyConnectedTreeForDfs();

  var originalNodes = group2.nodes.map( ( node ) => sys.idsToNodes( node.originalNodes ) );
  var originalNodesNames = originalNodes.map( ( node ) => group.nodesToNames( node ) );
  var expected =
  [
    [ 'j' ], // 11
    [ 'f' ], // 12
    [ 'i', 'h' ], // 13
    [ 'g' ], // 14
    [ 'a', 'b', 'e', 'c' ], // 15
    [ 'd' ], // 16
  ]
  test.identical( originalNodesNames, expected );

  var outNodes = group2.nodes.map( ( node ) => node.outNodes );
  var expected =
  [
    [],
    [],
    [ 12 ],
    [ 13 ],
    [ 12, 13 ],
    [ 15, 14 ]
  ];
  test.identical( outNodes, expected );

  logger.log( 'Tree' );
  logger.log( group2.exportInfo() );

  sys.finit();

  /* - */

}

//

function nodesExportInfoTree( test )
{

  test.case = 'trivial';

  var a = { name : 'a', nodes : [] } // 1
  var b = { name : 'b', nodes : [] } // 2
  var c = { name : 'c', nodes : [] } // 3
  var d = { name : 'd', nodes : [] } // 4
  var e = { name : 'e', nodes : [] } // 5
  var f = { name : 'f', nodes : [] } // 6
  var g = { name : 'g', nodes : [] } // 7
  var h = { name : 'h', nodes : [] } // 8
  var i = { name : 'i', nodes : [] } // 9
  var j = { name : 'j', nodes : [] } // 10

  a.nodes.push( b ); // 1
  b.nodes.push( e, f ); // 2
  c.nodes.push( b ); // 3
  d.nodes.push( a, g ); // 4
  e.nodes.push( a, c, h ); // 5
  f.nodes.push(); // 6
  g.nodes.push( h ); // 7
  h.nodes.push( i ); // 8
  i.nodes.push( f, h ); // 9
  j.nodes.push(); // 10

  var sys = new _.graph.AbstractGraphSystem({ onNodeNameGet : ( node ) => node.name });
  var group = sys.groupMake();
  group.nodesAdd([ a, b, c, d, e, f, g, h, i, j ]);

  // logger.log( 'DAG' )
  // logger.log( group.nodesInfoExport() );

  test.case = 'single a';
  var expected =
  `+-- a
     +-- b
       +-- e
       | +-- c
       | +-- h
       |   +-- i
       |     +-- f
       +-- f
  `
  var infoAsTree = group.nodesExportInfoTree([ a ]);
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.case = 'single b';
  var expected =
  `+-- b
     +-- e
     | +-- a
     | +-- c
     | +-- h
     |   +-- i
     |     +-- f
     +-- f
  `
  var infoAsTree = group.nodesExportInfoTree([ b ]);
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.case = 'multiple: a, b, c';
  var expected =
  `+-- a
     | +-- b
     |   +-- e
     |   | +-- c
     |   | +-- h
     |   |   +-- i
     |   |     +-- f
     |   +-- f
     |
     +-- b
     | +-- e
     | | +-- a
     | | +-- c
     | | +-- h
     | |   +-- i
     | |     +-- f
     | +-- f
     |
     +-- c
       +-- b
         +-- e
         | +-- a
         | +-- h
         |   +-- i
         |     +-- f
         +-- f
  `
  var infoAsTree = group.nodesExportInfoTree([ a, b, c ]);
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

  test.case = 'multiple, topsDelimiting : 0';
  var expected =
  `+-- a
     | +-- b
     |   +-- e
     |   | +-- c
     |   | +-- h
     |   |   +-- i
     |   |     +-- f
     |   +-- f
     +-- b
     | +-- e
     | | +-- a
     | | +-- c
     | | +-- h
     | |   +-- i
     | |     +-- f
     | +-- f
     +-- c
       +-- b
         +-- e
         | +-- a
         | +-- h
         |   +-- i
         |     +-- f
         +-- f
  `
  var infoAsTree = group.nodesExportInfoTree( [ a, b, c ], { topsDelimiting : 0 } );
  test.equivalent( infoAsTree, expected );
  logger.log( 'Tree' );
  logger.log( infoAsTree );

}

//

var Self =
{

  name : 'Tools.mid.AbstractGraph',
  silencing : 1,

  tests :
  {

    makeByNodes,
    makeByNodesWithInts,
    clone,
    reverse,

    sinksOnlyAmong,
    sourcesOnlyAmong,
    leastMostDegreeAmong,

    lookBfs,
    lookBfsRevisiting,
    lookBfsExcluding,

    lookDfs,
    lookDfsRevisiting,
    lookDfsExcluding,

    lookDbfsRevisiting,
    lookDbfsExcluding,

    eachBfs,
    eachDfs,
    eachDbfs,

    topologicalSortDfs,
    topologicalSortSourceBasedBfs,
    topologicalSortCycledSourceBasedBfs,

    nodesAreConnectedDfs,
    groupByConnectivityDfs,
    groupByStrongConnectivityDfs,
    stronglyConnectedTreeForDfs,

    nodesExportInfoTree,

  },

}

//

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
