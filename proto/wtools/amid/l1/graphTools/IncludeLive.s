( function _IncludeLive_s_( )
{

'use strict';

if( typeof module !== 'undefined' )
{

  // let _ = require( '../../../../wtools/Tools.s' );
  let _ = require( '../../../Tools.s' );

  require( './IncludeBase.s' );

  require( './l5_live/LiveNode.s' );
  require( './l5_live/LiveNodeIn.s' );
  require( './l5_live/LiveNodeOut.s' );
  require( './l5_live/LiveSystem.s' );

}

})();
