<?php
$GLOBALS['TYPO3_CONF_VARS']['EXTCONF']['realurl']=array (
  '_DEFAULT' => array (
    'init' => array (
      'enableCHashCache' => true,
      'appendMissingSlash' => 'ifNotFile,redirect',
      'adminJumpToBackend' => true,
      'enableUrlDecodeCache' => true,
      'enableUrlEncodeCache' => true,
      'emptyUrlReturnValue' => '/',
    ),
    'preVars' => array (
      0 => array (
        'GETvar' => 'L',
        'valueMap' => 
        array (
          'de' => '1',
        ),
        'noMatch' => 'bypass',
      ),
    ),
    'pagePath' => array (
      'type' => 'user',
      'userFunc' => 'EXT:realurl/class.tx_realurl_advanced.php:&tx_realurl_advanced->main',
      'spaceCharacter' => '-',
      'languageGetVar' => 'L',
			'rootpage_id' => 1,
			'expireDays' => 3,
    ),
    'fixedPostVars' => array (
      '_DEFAULT' => array (
        array (
          'GETvar' => 'no_cache',
          'valueMap' => array (
            'nc'  => 1
          ),
          'noMatch' => 'bypass',
        ),
      ),
    ),
    'postVarSets' => array (
      '_DEFAULT' => array (
        'article' => array (
          array (
            'GETvar' => 'tx_ttnews[tt_news]',
            'lookUpTable' => array (
              'table' => 'tt_news',
              'id_field' => 'uid',
              'alias_field' => 'title',
              'addWhereClause' => ' AND NOT deleted AND NOT hidden',
              'useUniqueCache' => 1,
              'useUniqueCache_conf' => array (
                'strtolower' => 1,
                'spaceCharacter' => '-',
              ),
            ),
          ),
        ),
      ),
    ),
    'fileName' => array (
      'defaultToHTMLsuffixOnPrev' => 0,
      'acceptHTMLsuffix' => 1,
      'index' => array (
        'print' => array (
          'keyValues' => array (
            'type' => 98,
          ),
        ),
      ),
    ),
  ),
);
?>
