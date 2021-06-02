( function _IncludeBase_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  // const _ = require( '../../../../node_modules/Tools' );
  const _ = require( 'Tools' );

  _.include( 'wProto' );
  _.include( 'wCopyable' );
  // _.include( 'wMathMatrix' );

  // require( './UseAbstractBase.s' );

}

//

const _ = _global_.wTools;
const Parent = null;
const Self = _.graph = _.graph || Object.create( null );

//

})();
