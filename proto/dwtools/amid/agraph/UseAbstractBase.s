( function _UseAbstractBase_s_( ) {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wCopyable' );

}

//

/**
 * @summary Collection of abstract data structures and algorithms to process graphs.
 * @namespace "wTools.graph"
 * @mebmerof module:Tools/mid/AbstractGraphs
*/

var _ = _global_.wTools;
var Parent = null;
var Self = _global_.wTools.graph = _global_.wTools.graph || Object.create( null );

//

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
