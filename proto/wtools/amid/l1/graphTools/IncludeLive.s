( function _IncludeLive_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  // const _ = require( '../../../../node_modules/Tools' );
  const _ = require( 'Tools' );

  require( './IncludeBase.s' );

  require( './l5_live/LiveNode.s' );
  require( './l5_live/LiveNodeIn.s' );
  require( './l5_live/LiveNodeOut.s' );
  require( './l5_live/LiveSystem.s' );

}

})();
