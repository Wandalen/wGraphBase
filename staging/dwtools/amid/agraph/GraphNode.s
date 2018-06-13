( function _GraphNode_s_( ) {

'use strict';

var _ = _global_.wTools;
var _hasOwnProperty = Object.hasOwnProperty;

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wProto' );

}

/*

= statements

- node can have only one down
- terminal node have no element
- branch node can have no or many elements

*/

//

function _mixin( cls )
{

  var proto = cls.prototype;

  _.assert( arguments.length === 1 );
  _.assert( _.routineIs( cls ) );
  _.assert( _.mixinHas( proto,'wCopyable' ),'wGraphNode : wCopyable should be mixed in first' );

  _.mixinApply
  ({
    dstProto : proto,
    descriptor : Self,
  });

  _.assert( Object.hasOwnProperty.call( proto,'cloneEmpty' ) );

}

//

function cloneEmpty()
{
  var self = this;
  _.assert( arguments.length === 0 );
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

  down[ elementsSymbol ] = _.arrayRemoveOnceStrictly( down[ elementsSymbol ].slice(),self );

  return self;
}

//

function nodeEach( o )
{
  var self = this;

  _.assert( o === undefined || _.mapIs( o ) || _.routineIs( o ) );

  if( _.routineIs( arguments[ 0 ] ) )
  o = { onUp : arguments[ 1 ] };

  o.node = self;

  o.elementsGet = function( node ){ return node.elements || []; };
  o.nameGet = function( node ){ return node.nickName; };

  return _.graph.eachNode( o );
}

//

function downAttachAfter( down )
{
  var self = this;
  var system = self.system;

  _.assert( arguments.length === 1 );
  _.assert( !self.down );
  _.assert( down );
  _.assert( !self.finitedIs() );

  //console.log( 'down added',self.nickName,'to',down.nickName );

  self.down = down;

  _.assert( self.down.elements.indexOf( self ) !== -1 );
  _.assert( self !== down )

  system.systemAttachNodesAfter( down,self );

}

//

function downDetachBefore()
{
  var self = this;
  var system = self.system;

  //console.log( 'down removed',self.nickName,'from',( self.down ? self.down.nickName : '' ) );

  _.assert( arguments.length === 0 );
  _.assert( self.down );
  _.assert( self.down.elements.indexOf( self ) !== -1 );

  var down = self.down;

  system.systemDetachNodesBefore( down,self );

  self.down = null;

}

// --
// relationships
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
// proto
// --

var Supplement =
{

  cloneEmpty : cloneEmpty,

  detach : detach,
  downAttachAfter : downAttachAfter,
  downDetachBefore : downDetachBefore,



  //

  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,

}

//

var Self =
{

  _mixin : _mixin,
  supplement : Supplement,
  name : 'wGraphNode',
  nameShort : 'GraphNode',

}

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.nameShort ] = _.mixinMake( Self );

})();
