( function _IncludeBase_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../../wtools/Tools.s' );

  _.include( 'wProto' );
  _.include( 'wCopyable' );
  // _.include( 'wMathMatrix' );

  // require( './UseAbstractBase.s' );

}

//

let _ = _global_.wTools;
let Parent = null;
let Self = _global_.wTools.graph = _global_.wTools.graph || Object.create( null );

//

})();
