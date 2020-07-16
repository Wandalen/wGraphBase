( function _LiveNode_s_() {

'use strict';

var _ObjectHasOwnProperty = Object.hasOwnProperty;
let _ = _global_.wTools;
let Parent = wLiveNode;
let Self = function wLiveIn( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'wLiveIn';

// --
// inter
// --

function init( o )
{
  var node = this;
  Parent.prototype.init.call( node,o );

  _.assert( _.strDefined( node.name ) );
  _.assert( _.strIs( node.key ) || _.numberIs( node.key ) );
  _.assert( _.longIs( node.container ) || _.objectLike( node.container ) );

  var system = node.system;

  if( system.currentOut )
  system.currentOut.elementsAppend( node );

}

//

function valueGet()
{
  var node = this;
  return node.container[ node.key ];
}

// --
// relations
// --

var Composes =
{
  kind : 'in',
  key : null,
}

var Aggregates =
{
}

var Associates =
{
  container : null,
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

var Proto =
{

  // routine

  init : init,

  valueGet : valueGet,


  // relations


  Composes : Composes,
  Aggregates : Aggregates,
  Associates : Associates,
  Restricts : Restricts,
  Statics : Statics,

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
    Node : null,
    In : Self,
    Out : null,
  },
});

//

_.accessor.readOnly
({

  object : Self.prototype,
  names :
  {
    value : 'value',
  }

});

//

_.accessor.declare
({

  object : Self.prototype,
  names :
  {
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
