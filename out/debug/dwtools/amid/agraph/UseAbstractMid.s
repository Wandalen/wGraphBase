( function _UseAbstractMid_s_( ) {

'use strict';

/**
 * Collection of abstract data structures and algorithms to process graphs. The module does not bound to any specific format of a graph, so providing adapters toy may use it with anyone. It implements depth-first search, breadth-first search, extracting strongly connected components, topological sort, shortest path search, and others.
  @module Tools/mid/AbstractGraphs
*/

if( typeof module !== 'undefined' )
{

  let _ = require( '../../Tools.s' );

  require( './UseAbstractBase.s' );

  require( './l1/AbstractGroup.s' );
  require( './l1/AbstractSystem.s' );

}

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = wTools.graph;

})();
