<?php
/***************************************************************
*  Copyright notice
*
*  (c) 2010 Dieter Bunkerd <dieter.bunkerd@typo3-asia.com>
*  All rights reserved
*
*  Based on the "Introduction Package" by
*  (c) 2009 Peter Beernink <p.beernink@drecomm.nl>
*
*  This script is part of the TYPO3 project. The TYPO3 project is
*  free software; you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation; either version 2 of the License, or
*  (at your option) any later version.
*
*  The GNU General Public License can be found at
*  http://www.gnu.org/copyleft/gpl.html.
*  A copy is found in the textfile GPL.txt and important notices to the license
*  from the author is found in LICENSE.txt distributed with these scripts.
*
*
*  This script is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  This copyright notice MUST APPEAR in all copies of the script!
***************************************************************/
/**
 * Configuration of the yamltv package
 *
 * @author      Peter Beernink <p.beernink@drecomm.nl>
 *
 */

if (!defined ("TYPO3_MODE"))    die ('Access denied.');

if (TYPO3_MODE == 'BE') {
	$TYPO3_CONF_VARS['SC_OPTIONS']['ext/install/mod/class.tx_install.php']['stepOutput'][] = 'EXT:'.$_EXTKEY.'/Classes/Controller/Controller.php:&tx_yamltv_controller';
	$TYPO3_CONF_VARS['SC_OPTIONS']['ext/install/mod/class.tx_install.php']['additionalSteps'][] = 'EXT:'.$_EXTKEY.'/Classes/Controller/AdditionalStepsController.php:&tx_yamltv_additionalstepscontroller';
}
?>