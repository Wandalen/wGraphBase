( function _LiveNode_s_()
{

'use strict';

const _ObjectHasOwnProperty = Object.hasOwnProperty;
const _ = _global_.wTools;
const Parent = null;
const Self = wLiveNode;
function wLiveNode( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'LiveNode';

// --
// inter
// --

function init( o )
{
  var node = this;

  node._nodeCounter[ 0 ] += 1;

  _.workpiece.initFields( node );

  Object.preventExtensions( node );

  if( o )
  {
    // debugger;
    node.copy( o );
    // debugger;
    if( o.container !== undefined )
    _.assert( node.container === o.container );
  }

  if( node.name === null )
  node.name = 'node-' + node._nodeCounter[ 0 ];

  _.assert( _.strDefined( node.name ) );
  _.assert( _.object.isBasic( node.system ), 'each live node should be associated with system' );

  node.system.systemMakeNodeAfter( node );

}

//

function finit()
{
  var node = this;
  var system = node.system;

  system.systemUnmakeNodeAfter( node );

  _.Copyable.prototype.finit.call( node );
}

//

function _exists( iteration, iterator )
{
  var node = this;
  var result = true;

  if( node.onExists )
  {
    result = node.onExists( node, iteration, iterator );
  }

  return result;
}

//

function _textMake( iteration, iterator )
{
  var node = this;
  var result = '';

  // if( !node._doesExist )
  // debugger;

  if( !node._doesExist )
  return result;

  if( node.onText )
  {
    result = node.onText( node, iteration, iterator );
  }

  return result;
}


//

function textMake( o )
{
  var node = this;

  o = o || Object.create( null );

  _.routine.options_( textMake, o );

  var iterator = node.iteratorNew();

  if( !node._exists( iterator ) )
  return;

  var result = node._textMake( iterator );

  return result;
}

textMake.defaults =
{
}

//

function iteratorationNew( o )
{
  var node = this;
  var result = Object.create( null );

  _.routine.options_( iteratorationNew, o );

  // result.value = null;
  // tesult.key = null;

  return result;
}

iteratorationNew.defaults =
{
  iterator : null,
}

//

function iteratorNew( o )
{
  var node = this;
  var result = Object.create( null );

  _.routine.options_( iteratorNew, o );

  // result.value = null;
  // tesult.key = null;

  return result;
}

iteratorNew.defaults =
{
}

//

function uniqGet()
{
  var node = this;
  return node.name;
}

// --
// relations
// --

var Composes =
{
  name : null,
  kind : null,
  onExists : null,
  onText : null,
}

var Aggregates =
{
}

var Associates =
{
  a : null,
  system : null,
}

var Restricts =
{
  _doesExist : null,
  down : null,
}

var Statics =
{
  _nodeCounter : [ 0 ],
}

// --
// declare
// --

const Proto =
{

  // routine

  init,
  finit,

  _exists,
  _textMake,
  textMake,

  iteratorationNew,
  iteratorNew,

  uniqGet,


  // relations


  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Proto,
});

_.prototypeCrossRefer
({
  name : 'LiveSystem',
  entities :
  {
    System : null,
    Node : Self,
    In : null,
    Out : null,
  },
});

_.Copyable.mixin( Self );
_.graph.GraphNode.mixin( Self );

//

_.accessor.declare
({

  object : Self.prototype,
  writable : 0,
  names :
  {
    uniq : 'uniq',
  }

});

//

_.accessor.forbid
({
  object : Self.prototype,
  names :
  {
  }
});

//

_global_[ Self.name ] = _[ Self.shortName ] = Self;

})();
