( function _GraphSystem_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  require( './Base.s' );

}

var _ = _global_.wTools;
var _hasOwnProperty = Object.hasOwnProperty;

//

function _mixin( cls )
{

  var proto = cls.prototype;

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.routineIs( cls ) );

  _.mixinApply
  ({
    dstProto : proto,
    descriptor : Self,
  });

}

//

function systemMakeNodeAfter( node )
{
  var system = this;

  _.assert( node instanceof system.Node );
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( node.down === null );
  _.assert( _.strIs( node.uniq ),'expects string { uniq }' );

  if( system.collectionMap )
  _.prototypeEach( node.Self.prototype, function( proto )
  {

    var n = proto.constructor.name;
    system.collectionMap[ n ] = system.collectionMap[ n ] || [];

    _.arrayAppendOnceStrictly( system.collectionMap[ n ],node );

  });

  if( system.nodesMap )
  {
    _.assert( node.uniq !== undefined );
    _.assert( !system.nodesMap[ node.uniq ],'node already exists',node.uniq );
    system.nodesMap[ node.uniq ] = node;
  }

  if( system.nodes )
  _.arrayAppendOnceStrictly( system.nodes,node );

  /* */

  system.systemDetachNodesBefore( null,node );

}

//

function systemUnmakeNodeAfter( node )
{
  var system = this;

  _.assert( node instanceof system.Node );
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( node.uniq !== undefined );

  if( system.collectionMap )
  _.prototypeEach( node.Self.prototype, function( proto )
  {

    var n = proto.constructor.name;
    _.arrayRemoveOnceStrictly( system.collectionMap[ n ],node );

  });

  if( system.nodesMap )
  {
    _.assert( node.uniq !== undefined );
    _.assert( system.nodesMap[ node.uniq ],'node was not registered',node.uniq );
    delete system.nodesMap[ node.uniq ];
  }

  if( system.nodes )
  _.arrayRemoveOnceStrictly( system.nodes,node );

  system.systemAttachNodesAfter( null,node );

  _.assert( !node.elements || !node.elements.length );

}

//

function systemAttachNodesAfter( down,up )
{
  var system = this;

  // debugger;

  _.assert( down === null || down instanceof system.Node );
  _.assert( up instanceof system.Node );
  _.assert( up.uniq !== undefined );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  _.assert( down === null || down.elements.indexOf( up ) !== -1 );
  _.assert( up.down === down );

  if( system.roots )
  _.arrayRemoveOnceStrictly( system.roots,up );

  if( system.rootsMap )
  {
    _.assert( up.uniq !== undefined );
    _.assert( system.rootsMap[ up.uniq ] === up );
    delete system.rootsMap[ up.uniq ];
  }

}

//

function systemDetachNodesBefore( down,up )
{
  var system = this;

  // debugger;

  _.assert( down === null || down instanceof system.Node );
  _.assert( up instanceof system.Node );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( up.uniq !== undefined );

  _.assert( up.down === down );
  _.assert( down === null || down.elements.indexOf( up ) !== -1 );

  if( system.roots )
  _.arrayAppendOnceStrictly( system.roots,up );

  if( system.rootsMap )
  {
    _.assert( up.uniq !== undefined );
    _.assert( system.rootsMap[ up.uniq ] === undefined );
    system.rootsMap[ up.uniq ] = up;
  }

}

//

function elementsDetach( src )
{
  var system = this;

  _.assert( system.instanceIs() );
  _.assert( _.longIs( src ) );
  _.assert( arguments.length === 1, 'expects single argument' );

  for( var s = 0 ; s < src.length ; s++ )
  {
    _.assert( src[ s ].system === system );
    src[ s ].detach();
    _.assert( src[ s ].down === null );
  }

  // system[ elementsSymbol ] = src;

}

//

function elementsFinit( src )
{
  var system = this;

  _.assert( system.instanceIs() );
  _.assert( _.longIs( src ) );
  _.assert( arguments.length === 1, 'expects single argument' );

  for( var s = 0 ; s < src.length ; s++ )
  {
    _.assert( src[ s ].system === system );
    src[ s ].finit();
    _.assert( src[ s ].down === null );
  }

}

// --
// relationships
// --

var Composes =
{
}

var Aggregates =
{
}

var Associates =
{
}

var Restricts =
{
}

var Optionals =
{

  collectionMap : Object.create( null ),

  roots : [],
  rootsMap : Object.create( null ),

  nodes : [],
  nodesMap : Object.create( null ),

}

var Statics =
{
}

// --
// define class
// --

var Supplement =
{

  systemMakeNodeAfter : systemMakeNodeAfter,
  systemUnmakeNodeAfter : systemUnmakeNodeAfter,

  systemAttachNodesAfter : systemAttachNodesAfter,
  systemDetachNodesBefore : systemDetachNodesBefore,

  elementsDetach : elementsDetach,
  elementsFinit : elementsFinit,


  //

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Optionals  : Optionals,
  Statics : Statics,

}

//

var Self =
{

  _mixin : _mixin,
  supplement : Supplement,
  name : 'wGraphSystem',
  nameShort : 'GraphSystem',

}

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.nameShort ] = _.mixinMake( Self );

})();
