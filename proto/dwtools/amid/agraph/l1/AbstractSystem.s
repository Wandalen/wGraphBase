( function _AbstractSystem_s_( ) {

'use strict';

/*

Graph :: set of nodes and set of edges or arcs connecting some or all nodes.
Incident edges :: of the node, are edges connected to the node.
Connected nodes :: nodes are connected if them have edge connecting both of them.
Reachable node :: node v is reachable from u if there is a path from v to u.
DFS :: depth-first search.
BFS :: breadth-first search.
DAG :: directed acycled graph.
SCC :: Strongly connected components.
Node degree :: total number of incoming and outgoint edges of the node.
Indegree :: of the node is number of incoming edges.
Outdegree :: of the node is number of outgoing edges.
Sink node :: node with zero outdegree.
Source node :: node with zero indegree.
Universal node :: node connected to all nodes of the graph.
Terminal node :: pendant node :: leaf node :: node with degree of one.
Neighborhood :: is an enduced subgraph of the graph, formed by all nodes adjacent to v.
Neigbour nodes :: nodes which are connected to the node.
Low-link value of a node :: smallest node id reachable from the node.
Topological ordering :: linear ordered DAG.
Topological sort :: algorithm of linear ordering of DAG.
Distance between nodes :: minimal number of edges to get from one given node to another given node.
Distance layers :: array of arrays of nodes. First layer has origin or zero-distance set of nodes. Second layer has nodes on distance one from origin. And os on.

*/

/**
 * @classdesc Class to operate system of graphs.
 * @class wAbstractGraphSystem
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph
 */

let _ = _global_.wTools;
let Parent = null;
let Self = function wAbstractGraphSystem( o )
{
  return _.workpiece.construct( Self, this, arguments );
}

Self.shortName = 'AbstractGraphSystem';

// --
// routine
// --

function init( o )
{
  let sys = this;

  _.workpiece.initFields( sys );
  Object.preventExtensions( sys );

  if( o )
  sys.copy( o );

  return sys;
}

//

function finit()
{
  let sys = this;
  _.Copyable.prototype.finit.call( sys );
}

//

/**
 * @summary Declares group of nodes. Returns instance of {@link module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphGroup wTools.graph.AbstractGraphGroup}
 * @param {Object} o Options for instance.
 * @function groupMake
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphSystem
 */

function groupMake( o )
{
  let sys = this;
  _.assert( arguments.length === 0 || arguments.length === 1 );
  o = o || Object.create( null );
  if( !o.sys )
  o.sys = sys;

  _.mapSupplement( o, _.mapButNulls( _.mapOnly( sys, sys.FieldsForGroup ) ) );

  return sys.Group( o );
}

//

/**
 * @summary Returns true if entity `id` is a node id.
 * @param {} id Source entity
 * @function idIs
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphSystem
 */

function idIs( id )
{
  let sys = this;
  if( !_.numberIs( id ) )
  return false;
  if( !( id >= 0 ) )
  return false;
  if( id > sys.nodeCounter )
  return false;
  return true;
}

//

/**
 * @summary Returns true system has node with descriptor `nodeHandle`.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeHas
 * @throws {Error} If system doesn't have a node `nodeHandle`.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphSystem
 */

function nodeHas( nodeHandle )
{
  let sys = this;
  _.assert( !!nodeHandle );
  return sys.nodeToIdHash.has( nodeHandle );
}

//

/**
 * @summary Returns id of node with descriptor `nodeHandle`.
 * @description Doesn't throw error if can't get id of node.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeToIdTry
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphSystem
 */

function nodeToIdTry( nodeHandle )
{
  let sys = this;
  let id = sys.nodeToIdHash.get( nodeHandle );
  return id;
}

//

/**
 * @summary Returns id of node with descriptor `nodeHandle`.
 * @param {Object} nodeHandle Node descriptor.
 * @function nodeToId
 * @throws {Error} If node with descriptor `nodeHandle` doesn't exist in system.
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphSystem
 */

function nodeToId( nodeHandle )
{
  let sys = this;
  let id = sys.nodeToIdHash.get( nodeHandle );
  _.assert( sys.idIs( id ), 'Id for nodeHandle was not found' );
  return id;
}

//

function idToNodeTry( nodeId )
{
  let sys = this;
  let nodeHandle = sys.idToNodeHash.get( nodeId );
  return nodeHandle;
}

//

function idToNode( nodeId )
{
  let sys = this;
  let nodeHandle = sys.idToNodeHash.get( nodeId );
  _.assert( !!nodeHandle, 'Id for the node was not found' );
  return nodeHandle;
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorWithId
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphSystem
 */

function nodeDescriptorWithId( nodeId )
{
  let sys = this;

  _.assert( arguments.length === 1 );
  _.assert( sys.idIs( nodeId ) );

  let descriptor = sys.nodeDescriptorsHash.get( nodeId );
  if( descriptor === undefined )
  descriptor = null;

  return descriptor;
}

//

function nodeDescriptorWith( nodeId )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  if( !sys.idIs( nodeId ) )
  nodeId = sys.nodeToId( nodeId );

  return sys.nodeDescriptorWithId( nodeId );
}

//

/**
 * @summary Returns descriptor of node with id `nodeId`. Creates new descriptor if needed.
 * @param {Number} nodeId Id of target node.
 * @function nodeDescriptorObtain
 * @memberof module:Tools/mid/AbstractGraphs.wTools.graph.wAbstractGraphSystem
 */

function nodeDescriptorObtain( nodeId )
{
  let sys = this;

  _.assert( arguments.length === 1 );

  if( !sys.idIs( nodeId ) )
  nodeId = sys.nodeToId( nodeId );

  let descriptor = sys.nodeDescriptorsHash.get( nodeId );

  if( descriptor === undefined )
  {
    descriptor = Object.create( null );
    descriptor.count = 1;
    sys.nodeDescriptorsHash.set( nodeId, descriptor );
  }

  return descriptor;
}

//

function nodeDescriptorDelete( nodeId )
{
  let sys = this;

  _.assert( arguments.length === 1 );
  _.assert( sys.idIs( nodeId ) );

  let r = sys.nodeDescriptorsHash.delete( nodeId );

  return r;
}

// --
// relations
// --

let FieldsForGroup =
{
  onNodeNameGet : null,
  onNodeIs : null,
  onOutNodesFor : null,
  onInNodesFor : null,
  // onOutNodesIdsFor : null,
  // onInNodesIdsFor : null,
}

let Composes =
{
}

let Aggregates =
{
  onNodeNameGet : null,
  onNodeIs : null,
  onOutNodesFor : null,
  onInNodesFor : null,
  // onOutNodesIdsFor : null,
  // onInNodesIdsFor : null,
}

let Associates =
{
  groups : _.define.instanceOf( Array ),
}

let Restricts =
{
  nodeCounter : 0,
  nodeToIdHash : _.define.instanceOf( Map ),
  idToNodeHash : _.define.instanceOf( Map ),
  nodeDescriptorsHash : _.define.instanceOf( Map ),
}

let Statics =
{
  Group : _.graph.AbstractGraphGroup,
  FieldsForGroup,
}

let Forbids =
{
  onOutNodesIdsFor : 'onOutNodesIdsFor',
  onInNodesIdsFor : 'onInNodesIdsFor',
}

// --
// declare
// --

let Extend =
{

  init,
  finit,

  groupMake,

  // id

  idIs,
  idsAre : _.vectorize( idIs ),
  idsAreAll : _.vectorizeAll( idIs ),
  idsAreAny : _.vectorizeAny( idIs ),
  idsAreNone : _.vectorizeNone( idIs ),

  // node

  nodeHas,
  nodesHas : _.vectorize( nodeHas ),
  nodesHasAll : _.vectorizeAll( nodeHas ),
  nodesHasAny : _.vectorizeAny( nodeHas ),
  nodesHasNone : _.vectorizeNone( nodeHas ),

  nodeToIdTry,
  nodesToIdsTry : _.vectorize( nodeToIdTry ),
  nodeToId,
  nodesToIds : _.vectorize( nodeToId ),
  idToNodeTry,
  idsToNodesTry : _.vectorize( idToNodeTry ),
  idToNode,
  idsToNodes : _.vectorize( idToNode ),

  nodeDescriptorWithId,
  nodeDescriptorWith,
  nodeDescriptorObtain,
  nodeDescriptorDelete,

  // relations

  Composes,
  Aggregates,
  Associates,
  Restricts,
  Statics,
  Forbids,

}

//

_.classDeclare
({
  cls : Self,
  parent : Parent,
  extend : Extend,
});

_.Copyable.mixin( Self );

_.staticDeclare
({
  prototype : _.graph.AbstractGraphGroup.prototype,
  name : 'System',
  value : Self,
});

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;
_.graph[ Self.shortName ] = Self;

})();
