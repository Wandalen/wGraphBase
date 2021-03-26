( function _IncludeBase_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  // let _ = require( '../../../../wtools/Tools.s' );
  let _ = require( '../../../Tools.s' );

  _.include( 'wProto' );
  _.include( 'wCopyable' );
  // _.include( 'wMathMatrix' );

  // require( './UseAbstractBase.s' );

}

//

const _ = _global_.wTools;
let Parent = null;
const Self = _global_.wTools.graph = _global_.wTools.graph || Object.create( null );

//

})();
