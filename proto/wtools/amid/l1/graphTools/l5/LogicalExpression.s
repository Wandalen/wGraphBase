( function _LogicalExpression_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  // require( '../../../node_modules/Tools' );
  require( 'Tools' );

  const _ = _global_.wTools;

  _.include( 'wGraphBasic' );
  // require( '../UseBase.s' );

}

const _ObjectHasOwnProperty = Object.hasOwnProperty;

//

const _ = _global_.wTools;
const Parent = null;
const Self = wLogicalExpression;
function wLogicalExpression( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'LogicalExpression';

// --
// implementation
// --

function init( o )
{
  var logic = this;

  _.assert( arguments.length === 0 || arguments.length === 1 );

  _.workpiece.initFields( logic );
  Object.preventExtensions( logic );

  if( o )
  logic.copy( o );

  if( logic.Self === Self )
  logic.form();

  return logic;
}

//

function form()
{
  var logic = this;

  if( logic.branchOriginalToAliasMap === null )
  logic.branchOriginalToAliasMap = logic.DefaultBranchOriginalToAliasMap;
  if( logic.terminalOriginalToAliasMap === null )
  logic.terminalOriginalToAliasMap = logic.DefaultTerminalOriginalToAliasMap;
  if( logic.defaultBranchType === null )
  logic.defaultBranchType = logic.DefaultBranch;

  if( logic.branchAliasToOriginalMap === null )
  logic.branchAliasToOriginalMap = _.mapInvert( logic.branchOriginalToAliasMap );
  if( logic.terminalAliasToOriginalMap === null )
  logic.terminalAliasToOriginalMap = _.mapInvert( logic.terminalOriginalToAliasMap );
  if( logic.branchOriginalToAliasMap === null )
  logic.branchOriginalToAliasMap = _.mapInvert( logic.branchAliasToOriginalMap );
  if( logic.terminalOriginalToAliasMap === null )
  logic.terminalOriginalToAliasMap = _.mapInvert( logic.terminalAliasToOriginalMap );

  _.assert( arguments.length === 0, 'Expects no arguments' );
  _.map.assertHasAll( logic.branchOriginalToAliasMap, logic.DefaultBranchOriginalToAliasMap );
  _.map.assertHasOnly( logic.branchOriginalToAliasMap, logic.DefaultBranchOriginalToAliasMap );
  _.assert( !!logic.branchOriginalToAliasMap[ logic.defaultBranchType ] );

  Object.freeze( logic.branchOriginalToAliasMap );
  Object.freeze( logic.terminalOriginalToAliasMap );
  Object.freeze( logic );

  return logic;
}

//

function nodeKindGet( node )
{
  var logic = this;
  _.assert( arguments.length === 1, 'Expects single argument' );

  for( var b in logic.branchOriginalToAliasMap )
  if( logic.branchOriginalToAliasMap[ b ] in node )
  return b;

  return;
}

//

function nodeIsBranch( node )
{
  var logic = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( _.object.isBasic( node ) )
  return true;
  return false;
}

//

function nodeIsNormalizedBranch( node )
{
  var logic = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  if( !logic.nodeIsBranch( node ) )
  return false;
  var keys = _.props.keys( node );
  if( keys.length !== 1 )
  return false;
  if( !logic.branchAliasToOriginalMap[ keys[ 0 ] ] )
  return false;
  return true;
}

//

function nodeIsTerminal( node )
{
  var logic = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  return !logic.nodeIsBranch( node );
}

//

function _branchElements( branchNode )
{
  var logic = this;
  _.assert( logic.nodeIsNormalizedBranch( branchNode ) );
  return _.props.pairs( branchNode )[ 0 ][ 1 ];
}

//

function _branchMake( type )
{
  var logic = this;
  var result = Object.create( null );

  _.assert( arguments.length === 1, 'Expects single argument' );
  _.assert( logic.branchAliasToOriginalMap[ type ] );

  result[ type ] = [];

  return result;
}

//

function _branchDescriptor( branchNode, wasShortchut )
{
  var logic = this;
  var result = Object.create( null );

  _.assert( arguments.length === 2, 'Expects exactly two arguments' );
  _.assert( logic.nodeIsNormalizedBranch( branchNode ) );

  result.kind = 'branch';
  result.alias = _.props.pairs( branchNode )[ 0 ][ 0 ];
  result.type = logic.branchAliasToOriginalMap[ result.alias ];
  result.elements = branchNode[ result.alias ];
  result.node = branchNode;
  result.wasShortchut = !!wasShortchut;

  return result;
}

//

function _terminalDescriptor( branchNode )
{
  var logic = this;
  var result = Object.create( null );

  _.assert( logic.nodeIsTerminal( branchNode ) );

  result.kind = 'terminal';
  result.node = branchNode;

  return result;
}

//

function terminalsAreIdentical( node1, node2 )
{
  var logic = this;
  _.assert( arguments.length === 1, 'Expects single argument' );
  return logic.onTerminalsAreIdentical( node1, node2 );
}

//

function onTerminalsAreIdentical( node1, node2 )
{
  return node1 === node2;
}

// --
//
// --

function traverse( o )
{
  var o = _.look.head( traverse, arguments );
  var result = _.look( o );
  return result;
}

traverse.defaults =
{
  src : null,
  dst : null,
  onUp : null,
  onDown : null,
}

//

function normalize()
{
  var logic = this;

  var o = _.routine.options_( normalize, arguments );

  // var exp1 = { all : [ 'a', 'b', 'c' ], any : [ 'c', 'd', 'e' ], none : [ 'c', 'f', 'g' ] }
  // var got = logic.normalize( exp1 );

  function handleUp( e, k, it )
  {

    if( logic.nodeIsBranch( it.src ) )
    {
      _.assert( logic.nodeIsNormalizedBranch( it.src ) );
      it.dst = _.props.extend( null, it.src );
      it.dst = logic._branchDescriptor( it.dst, 0 );
    }
    else
    {
      it.dst = it.src;
      it.dst = logic._terminalDescriptor( it.dst );
    }

    // debugger;
    // if( _.arrayIs( it.src ) )
    // {
    //   it.dst = it.down.dst;
    //   return;
    // }
    // else if( logic.nodeIsBranch( it.src ) )
    // {
    //   if( logic.nodeIsNormalizedBranch( it.src ) )
    //   {
    //     debugger;
    //     it.dst = _.props.extend( null, it.src );
    //     it.dst = logic._branchDescriptor( it.dst, 0 );
    //   }
    //   else
    //   {
    //     it.dst = logic._normalizeRoot( it );
    //     it.dst = logic._branchDescriptor( it.dst, 1 );
    //   }
    // }
    // else
    // {
    //   it.dst = it.src;
    //   it.dst = logic._terminalDescriptor( it.dst );
    // }
    //
    // if( it.down.dst )
    // {
    //   if( it.down.dst.wasShortchut )
    //   {
    //     _.assert( _.strIs( it.down.key ) );
    //     it.down.dst.elements.push( logic._branchMake( it.down.key ) );
    //   }
    //   else
    //   {
    //     debugger;
    //     _.assert( _.arrayIs( it.down.dst.elements ) );
    //     it.down.dst.elements.push( it.dst );
    //   }
    // }

  }

  var src = o.src;
  if( logic.nodeIsBranch( src ) )
  {
    if( !logic.nodeIsNormalizedBranch( src ) )
    {
      src = logic._normalizeRoot( src );
    }
  }

  var r = logic.traverse
  ({
    src : o.src,
    dst : null,
    onUp : handleUp,
  });

  return src;
}

normalize.defaults =
{
  src : null,
}

//

function _normalizeRoot( src )
{
  var logic = this;
  _.assert( _.object.isBasic( src ) );
  var result = logic._branchMake( logic.defaultBranchType );
  result[ logic.defaultBranchType ] = src;
  return result;
}

//

function rebase( o )
{


}

rebase.defaults =
{
  src : null,
  base : 'and',
}

//

function and()
{
}

and.defaults =
{
  src : null,
  base : 'or',
}

// --
// vars
// --

var DefaultBranch = 'all';

var DefaultBranchOriginalToAliasMap =
{
  any : 'any',
  all : 'all',
  none : 'none',
  not : 'not',
}

Object.freeze( DefaultBranchOriginalToAliasMap );

var DefaultTerminalOriginalToAliasMap =
{
}

Object.freeze( DefaultTerminalOriginalToAliasMap );

// var files = _.fileProvider.filesFind
// ({
//   filePath : o.filePath,
//   filter :
//   {
//     mask : { not : { any : [ /\.manual(\.|\/|$)/i, /\.exclude(\.|\/|$)/i ] } },
//   },
// });

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

  branchOriginalToAliasMap : null,
  terminalOriginalToAliasMap : null,

  branchAliasToOriginalMap : null,
  terminalAliasToOriginalMap : null,

  defaultBranchType : null,

  onTerminalsAreIdentical,

}

var Restricts =
{
}

var Optionals =
{
}

var Statics =
{
  DefaultBranch,
  DefaultBranchOriginalToAliasMap,
  DefaultTerminalOriginalToAliasMap,
}

// --
// declare
// --

var Extension =
{

  init,
  form,

  //

  nodeKindGet,
  nodeIsBranch,
  nodeIsNormalizedBranch,
  nodeIsTerminal,
  _branchElements,
  _branchMake,
  _branchDescriptor,
  _terminalDescriptor,
  terminalsAreIdentical,
  onTerminalsAreIdentical,

  //

  traverse,
  normalize,
  _normalizeRoot,
  rebase,

  //

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Optionals,
  Statics,

}

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extension,
});

_.Copyable.mixin( Self );

var instance = new Self();

//

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;
_global_[ Self.name ] = _[ Self.shortName ] = Self;

_.assert( !_.graph.logic );
_.graph.logic = Self;

})();
