( function _GraphSystem_s_( )
{

'use strict';

// if( typeof module !== 'undefined' )
// {
//
//   require( '../UseBase.s' );
//
// }

const _ = _global_.wTools;
const _ObjectHasOwnProperty = Object.hasOwnProperty;

//

function onMixinApply( mixinDescriptor, dstClass )
{

  var dstPrototype = dstClass.prototype;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.routineIs( dstClass ) );

  _.mixinApply( this, dstPrototype );
  // _.mixinApply
  // ({
  //   dstPrototype : dstPrototype,
  //   descriptor : Self,
  // });

}

//

function systemMakeNodeAfter( node )
{
  var system = this;

  _.assert( node instanceof system.Node );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( node.down === null );
  _.assert( _.strIs( node.uniq ), 'Expects string { uniq }' );

  if( system.collectionMap )
  _.prototype.each( node.Self.prototype, function( proto )
  {

    var n = proto.constructor.name;
    system.collectionMap[ n ] = system.collectionMap[ n ] || [];

    _.arrayAppendOnceStrictly( system.collectionMap[ n ], node );

  });

  if( system.nodesMap )
  {
    _.assert( node.uniq !== undefined );
    _.assert( !system.nodesMap[ node.uniq ], 'node already exists', node.uniq );
    system.nodesMap[ node.uniq ] = node;
  }

  if( system.nodes )
  _.arrayAppendOnceStrictly( system.nodes, node );

  /* */

  system.systemDetachNodesBefore( null, node );

}

//

function systemUnmakeNodeAfter( node )
{
  var system = this;

  _.assert( node instanceof system.Node );
  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( node.uniq !== undefined );

  if( system.collectionMap )
  _.prototype.each( node.Self.prototype, function( proto )
  {

    var n = proto.constructor.name;
    _.arrayRemoveElementOnceStrictly( system.collectionMap[ n ], node );

  });

  if( system.nodesMap )
  {
    _.assert( node.uniq !== undefined );
    _.assert( system.nodesMap[ node.uniq ], 'node was not registered', node.uniq );
    delete system.nodesMap[ node.uniq ];
  }

  if( system.nodes )
  _.arrayRemoveElementOnceStrictly( system.nodes, node );

  system.systemAttachNodesAfter( null, node );

  _.assert( !node.elements || !node.elements.length );

}

//

function systemAttachNodesAfter( down, up )
{
  var system = this;

  // debugger;

  _.assert( down === null || down instanceof system.Node );
  _.assert( up instanceof system.Node );
  _.assert( up.uniq !== undefined );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );

  _.assert( down === null || down.elements.indexOf( up ) !== -1 );
  _.assert( up.down === down );

  if( system.roots )
  _.arrayRemoveElementOnceStrictly( system.roots, up );

  if( system.rootsMap )
  {
    _.assert( up.uniq !== undefined );
    _.assert( system.rootsMap[ up.uniq ] === up );
    delete system.rootsMap[ up.uniq ];
  }

}

//

function systemDetachNodesBefore( down, up )
{
  var system = this;

  // debugger;

  _.assert( down === null || down instanceof system.Node );
  _.assert( up instanceof system.Node );
  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( up.uniq !== undefined );

  _.assert( up.down === down );
  _.assert( down === null || down.elements.indexOf( up ) !== -1 );

  if( system.roots )
  _.arrayAppendOnceStrictly( system.roots, up );

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
  _.assert( arguments.length === 1, 'Expects single argument' );

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
  _.assert( arguments.length === 1, 'Expects single argument' );

  for( var s = 0 ; s < src.length ; s++ )
  {
    _.assert( src[ s ].system === system );
    src[ s ].finit();
    _.assert( src[ s ].down === null );
  }

}

// --
// relations
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

  collectionMap : _.define.own( {} ),

  roots : _.define.own( [] ),
  rootsMap : _.define.own( {} ),

  nodes : _.define.own( [] ),
  nodesMap : _.define.own( {} ),

}

var Statics =
{
}

// --
// declare
// --

var Supplement =
{

  systemMakeNodeAfter,
  systemUnmakeNodeAfter,

  systemAttachNodesAfter,
  systemDetachNodesBefore,

  elementsDetach,
  elementsFinit,


  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Optionals,
  Statics,

}

//

const Self =
{

  onMixinApply,
  supplement : Supplement,
  name : 'wGraphSystem',
  shortName : 'GraphSystem',

}

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = _.mixinDelcare( Self );

})();
