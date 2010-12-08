#!/bin/bash
# This script packages the yamltv package
# 
# Take the core trunk and the dummy
# Add the following extensions to typo3conf/ext/:
#   * yamltv
# 
# Change the typo3conf/localconf.php => extList and add:
# ,yamltv

packagename="yamltv-pre-typo3"
packageversion="4.4.4"
packagelocation="https://svn.typo3.org/TYPO3v4/Extensions/yamltv/trunk/yamltv/"

mkdir $packagename-$packageversion
cd $packagename-$packageversion

# fetch the dummy and source package
wget http://downloads.sourceforge.net/project/typo3/TYPO3%20Source%20and%20Dummy/TYPO3%20$packageversion/typo3_src+dummy-$packageversion.zip
unzip -q typo3_src+dummy-$packageversion.zip
mv typo3_src+dummy-$packageversion/* .
rm typo3_src+dummy-$packageversion.zip
rmdir typo3_src+dummy-$packageversion


# fetch yamltv package data
# see http://forge.typo3.org/projects/extension-yamltv/repository 
svn export $packagelocation typo3conf/ext/yamltv

# update localconf.php
echo "<?php
\$TYPO3_CONF_VARS['SYS']['sitename'] = 'New TYPO3 site';
// Default password is 'joh316':
\$TYPO3_CONF_VARS['BE']['installToolPassword'] = 'bacb98acf97e0b6112b1d1b650b84971';
\$TYPO3_CONF_VARS['EXT']['extList'] = 'tsconfig_help,context_help,extra_page_cm_options,impexp,sys_note,tstemplate,tstemplate_ceditor,tstemplate_info,tstemplate_objbrowser,tstemplate_analyzer,func_wizards,wizard_crpages,wizard_sortpages,lowlevel,install,belog,beuser,aboutmodules,setup,taskcenter,info_pagetsconfig,viewpage,rtehtmlarea,css_styled_content,t3skin,t3editor,reports,felogin,indexed_search,yamltv';
\$typo_db_extTableDef_script = 'extTables.php';
## INSTALL SCRIPT EDIT POINT TOKEN - all lines after this points may be changed by the install script!
?>" > typo3conf/localconf.php

# update extTables.php
echo "<?php
/**
 * Overriding $TCA
 *
 * The TYPO3 Configuration Array (TCA) is defined by the distributed tables.php and ext_tables.php files.
 * If you want to extend and/or modify its content, you can do so with scripts like this.
 * Or BETTER yet - with extensions like those found in the typo3conf/ext/ or typo3/ext/ folder.
 * Extensions are movable to other TYPO3 installations and provides a much better division between things! Use them!
 *
 * Information on how to set up tables is found in the document "Inside TYPO3" available as a PDF from where you downloaded TYPO3.
 *
 * Usage:
 * Just put this file to the location typo3conf/extTables.php and add this line to your typo3conf/localconf.php:
 * \$typo_db_extTableDef_script = 'extTables.php';
 */

\$TCA['tt_content']['columns']['colPos']['config']['items'] = array (
  '0' => array ('Main content||Main content||||||||','0'),
	'1' => array ('Side content||Side content||||||||','1'),
	'2' => array ('Special content||Special content||||||||','2'),
	'3' => array ('Ext content left||Ext content left||||||||','3'),
	'4' => array ('Ext content middle||Ext content middle||||||||','4'),
	'5' => array ('Ext content right||Ext content right||||||||','5')
);
?>" > typo3conf/extTables.php

# create .htaccess
cp misc/advanced.htaccess .htaccess

# create FIRST_INSTALL file
touch typo3conf/FIRST_INSTALL

# sanitize permissions
# chmod -R g+w typo3temp/ typo3conf/ uploads/ fileadmin/
# chgrp -R www-data fileadmin/ typo3conf/ typo3temp/ uploads/

# Zip it up
zip -9r -q ../$packagename-$packageversion.zip .htaccess *
cd ..
rm -rf $packagename-$packageversion
