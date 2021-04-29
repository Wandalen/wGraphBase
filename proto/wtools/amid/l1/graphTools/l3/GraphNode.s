( function _GraphNode_s_( )
{

'use strict';

const _ = _global_.wTools;
const _ObjectHasOwnProperty = Object.hasOwnProperty;

// if( typeof module !== 'undefined' )
// {
//
//   require( '../UseBase.s' );
//
// }

/*

= statements

- node can have only one down
- terminal node have no element
- branch node can have no or many elements

*/

//

function onMixinApply( mixinDescriptor, dstClass )
{

  var dstPrototype = dstClass.prototype;

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( _.routineIs( dstClass ) );
  _.assert( _.mixinHas( dstPrototype, 'wCopyable' ), 'wGraphNode : wCopyable should be mixed in first' );

  _.mixinApply( this, dstPrototype );
  // _.mixinApply
  // ({
  //   dstPrototype : dstPrototype,
  //   descriptor : Self,
  // });

  _.assert( Object.hasOwnProperty.call( dstPrototype, 'cloneEmpty' ) );

}

//

function cloneEmpty()
{
  var self = this;
  _.assert( arguments.length === 0, 'Expects no arguments' );
  var result = self.clone();
  return result;
}

//

function detach()
{
  var self = this;
  var down = self.down;

  _.assert( self.instanceIs() );

  if( !down )
  return self;

  self.downDetachBefore();

  down[ elementsSymbol ] = _.arrayRemoveElementOnceStrictly( down[ elementsSymbol ].slice(), self );

  return self;
}

//

function nodeEach( o )
{
  var self = this;

  _.assert( o === undefined || _.mapIs( o ) || _.routineIs( o ) );

  if( _.routineIs( arguments[ 0 ] ) )
  o = { onUp : ( arguments.length > 1 ? arguments[ 1 ] : null ) };

  o.node = self;

  o.elementsGet = function( node ){ return node.elements || []; };
  o.nameGet = function( node ){ return node.qualifiedName; };

  return _.graph.nodeEach( o );
}

//

function downAttachAfter( down )
{
  var self = this;
  var system = self.system;

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( !self.down );
  _.assert( _.object.isBasic( down ) );
  _.assert( !self.isFinited() );

  //console.log( 'down added', self.qualifiedName, 'to',down.qualifiedName );

  self.down = down;

  _.assert( self.down.elements.indexOf( self ) !== -1 );
  _.assert( self !== down )

  system.systemAttachNodesAfter( down, self );

}

//

function downDetachBefore()
{
  var self = this;
  var system = self.system;

  //console.log( 'down removed', self.qualifiedName, 'from',( self.down ? self.down.qualifiedName : '' ) );

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.assert( self.down );
  _.assert( self.down.elements.indexOf( self ) !== -1 );

  var down = self.down;

  system.systemDetachNodesBefore( down, self );

  self.down = null;

}

// --
// relations
// --

var elementsSymbol = Symbol.for( 'elements' );

var Composes =
{
}

var Aggregates =
{
}

var Associates =
{
  // system : null,
}

var Restricts =
{
}

var Statics =
{
}

// --
// declare
// --

var Supplement =
{

  cloneEmpty,

  detach,
  downAttachAfter,
  downDetachBefore,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,

}

//

const Self =
{

  onMixinApply,
  supplement : Supplement,
  name : 'wGraphNode',
  shortName : 'GraphNode',

}

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = _.mixinDelcare( Self );

})();
