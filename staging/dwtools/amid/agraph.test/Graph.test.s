( function Graph_test_s( ) {

'use strict';

var isBrowser = true;

if( typeof module !== 'undefined' )
{

  isBrowser = false;

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );
}

var _global = _global_; var _ = _global_.wTools;
var Self = {};

function trivial( test )
{
  test.identical( 1,1 );
}

//

var Proto =
{

  name : 'Tools/mid/graph',
  silencing : 1,

  tests :
  {

    trivial : trivial

  },

}

_.mapExtend( Self,Proto );

//

Self = wTestSuite( Self );

if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self )

})();
