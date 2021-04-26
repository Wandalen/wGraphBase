( function _LiveSystem_s_()
{

'use strict';

const _ObjectHasOwnProperty = Object.hasOwnProperty;
const _ = _global_.wTools;
const Parent = null;
const Self = wLiveSystem;
function wLiveSystem( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'LiveSystem';

// --
// inter
// --

function init( o )
{
  var system = this;

  _.workpiece.initFields( system );

  Object.preventExtensions( system );

  if( o )
  system.copy( o );

}

//

function finit()
{
  var system = this;

  while( system.nodes.length )
  {
    system.nodes.finit();
  }

  _.Copyable.prototype.finit.call( system );
}

//

function out( o )
{
  var system = this;

  if( _.strIs( o ) )
  o = { name : o || null };

  _.routine.options_( out, o );
  _.assert( arguments.length === 1, 'Expects single argument' );

  var result = system.nodesMap[ o.name ];
  if( !result )
  {
    o.kind = 'out';
    o.system = system;
    result = new system.Out( o );

    if( system.currentOut )
    {
      _.assert( result.down === null );
      system.currentOut.elementAppend( result );
      _.assert( result.down === system.currentOut );
    }

  }

  return result;
}

out.defaults =
{
  name : null,
}

//

function outBegin( o )
{
  var system = this;
  var out = system.out.apply( system, arguments );

  system.fieldPush({ currentOut : out });

  return out;
}

outBegin.defaults = out.defaults;

//

function outEnd( o )
{
  var system = this;
  var out = system.out.apply( system, arguments );

  system.fieldPop({ currentOut : out });

  return out;
}

outEnd.defaults = out.defaults;

//

function outDefine( o )
{
  var system = this;
  var out = system.currentOut;

  _.assert( out instanceof system.Out );

  _.props.extend( out, o );

  return out;
}

//

function inMake( o )
{
  var system = this;

  _.assert( _.strIs( o.key ) || _.numberIs( o.key ) );
  _.assert( _.longIs( o.container ) || _.objectLike( o.container ) );

  o.system = system;

  var result = new system.In( o );

  _.assert( result.down === system.currentOut );

  return result;
}

// --
// relations
// --

var Composes =
{

  name : null,
  containers : _.define.own( [] ),

  nodes : _.define.own( [] ),
  nodesMap : _.define.own( {} ),

  roots : _.define.own( [] ),
  rootsMap : _.define.own( {} ),

  onTextMake : null,
  onExists : null,

}

var Aggregates =
{
}

var Associates =
{
}

var Restricts =
{
  currentOut : null,
}

var Statics =
{
}

// --
// declare
// --

const Proto =
{

  // routine

  init,

  out,
  outBegin,
  outEnd,
  outDefine,

  inMake,

  /*
    systemMakeNodeAfter : systemMakeNodeAfter,
    systemUnmakeNodeAfter : systemUnmakeNodeAfter,
  */

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
    System : Self,
    Node : null,
    In : null,
    Out : null,
  },
});

_.Copyable.mixin( Self );
_.graph.GraphSystem.mixin( Self );
_.FieldsStack.mixin( Self );

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

if( Config.interpreter !== 'browser' )
{
  require( './LiveNode.s' );
  require( './LiveNodeIn.s' );
  require( './LiveNodeOut.s' );
}

})();
