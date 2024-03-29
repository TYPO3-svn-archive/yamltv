#!/bin/sh
TABLES="be_groups be_users_shadow fe_groups fe_users index_fulltext index_grlist index_phash index_rel index_section index_stat_word index_words pages pages_language_overlay static_countries static_country_zones static_currencies static_languages static_territories static_tsconfig_help sys_be_shortcuts sys_filemounts sys_language sys_refindex sys_template tt_content tt_news tt_news_cat tt_news_cat_mm tx_realurl_pathcache tx_realurl_uniqalias tx_realurl_urldecodecache tx_realurl_urlencodecache tx_staticinfotables_hotlist tx_templavoila_datastructure tx_templavoila_tmplobj"

# Tables which have a field deleted. Used to clean up deleted records before exporting
CLEANUP_TABLES="be_groups be_users_shadow fe_groups fe_users pages pages_language_overlay sys_filemounts sys_news sys_refindex sys_template tt_content tt_news tt_news_cat"
DATABASE=typo3
OUTPUTFILE=yamltv.sql
USER=dbuser
PASSWORD=password

# Only dump the backend users we need
mysql -u ${USER} --password=${PASSWORD} ${DATABASE} -e 'DROP TABLE IF EXISTS be_users_shadow; CREATE TABLE be_users_shadow SELECT * FROM be_users WHERE uid IN(2,3,4); ALTER TABLE be_users_shadow ADD PRIMARY KEY (uid), ADD KEY parent (pid), ADD KEY username (username);ALTER TABLE be_users_shadow CHANGE uid uid INT(11) unsigned NOT NULL auto_increment;'

# Remove deleted records
for table in ${CLEANUP_TABLES}
do
	mysql -u ${USER} --password=${PASSWORD} ${DATABASE} -e "DELETE FROM ${table} WHERE deleted=1;"
done

# Dump the tables we need
mysqldump -u ${USER} -p${PASSWORD} --disable-keys --skip-quote-names ${DATABASE} ${TABLES} | sed 's/AUTO_INCREMENT=[0-9]* //' > ${OUTPUTFILE}_dump

# Cleanup temporary table
mysql -u ${USER} --password=${PASSWORD} ${DATABASE} -e 'DROP TABLE IF EXISTS be_users_shadow;'

# Rename table be_users_shadow to be_users
sed "s/be_users_shadow/be_users/g" ${OUTPUTFILE}_dump > ${OUTPUTFILE}_shadow

# Remove character set from table copy
sed "s/ CHARACTER SET utf8//g" ${OUTPUTFILE}_shadow > ${OUTPUTFILE}_character
sed "s/ DEFAULT CHARSET=latin1/ DEFAULT CHARSET=utf8/g" ${OUTPUTFILE}_character > ${OUTPUTFILE}_character2

# Comment absRefPrefix
sed "s/absRefPrefix/\# absRefPrefix/g" ${OUTPUTFILE}_character2 > ${OUTPUTFILE}_absRefPrefix

# Replace ENABLE REALURL
sed "s/tx_realurl_enable = [1|0]/tx_realurl_enable = \#\#\#ENABLE_REALURL\#\#\#/g" ${OUTPUTFILE}_absRefPrefix > ${OUTPUTFILE}_realURL

# Replace Site path
sed "s/domain = [^\\]*/domain = ###HOSTNAME_AND_PATH###/g" ${OUTPUTFILE}_realURL > ${OUTPUTFILE}

# Cleanup
rm ${OUTPUTFILE}_absRefPrefix ${OUTPUTFILE}_character ${OUTPUTFILE}_character2 ${OUTPUTFILE}_dump ${OUTPUTFILE}_realURL ${OUTPUTFILE}_shadow
