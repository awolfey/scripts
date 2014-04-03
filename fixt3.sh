# bash fixt3
# Update T3 local

echo 'Starting update TFA T3 dev site.'

cd /home/awolfey/www/tfa/t3
pwd


echo 'Updating site configuration for development environment.'
drush -y dis googleanalytics page_title workbench_moderation > /dev/null 2>&1
drush -y en devel views_ui> /dev/null 2>&1

drush -y vset preprocess_css 0 > /dev/null 2>&1
drush -y vset preprocess_js 0 > /dev/null 2>&1
drush -y vset error_level 2 > /dev/null 2>&1


drush php-eval "variable_set('site_name', 'DEV TFA - '. variable_get('site_name', ''));" > /dev/null 2>&1

drush php-eval "user_role_grant_permissions(3, array('restore from backup') );" > /dev/null 2>&1


echo 'All done!'
