( function _UseAbstractMid_s_( ) {

'use strict';

/**
 * Collection of abstract data structures and algorithms to process graphs. The module does not bound to any specific format of a graph, so providing adapters toy may use it with anyone. It implements depth-first search, breadth-first search, extracting strongly connected components, topological sort, shortest path search, and others.
  @module Tools/mid/AbstractGraphs
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../Tools.s' );

  require( './IncludeBasic.s' );

  require( './l1/Abstract.s' );
  require( './l3/NodesGroup.s' );
  require( './l3/System.s' );

}

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools.graph;

})();
