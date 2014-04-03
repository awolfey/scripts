# bash fixnise
# Update SB local Projects

echo 'Starting update SB local site.'

nise=/home/awolfey/www/sb/nise/docroot

#this converts argument $1 into the variable that we cd to.
subst="$1[@]"
cd ${!subst}

  echo 'The script will run in this directory;'
  echo ' '
pwd
  echo ' '

read -p "Is the right place? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
  echo 'OK, here we go.'
else
  echo 'OK, cancelling.'

  exit 0
fi

echo 'Updating site configuration for development environment.'
drush -y dis toolbar > /dev/null 2>&1
drush -y en devel devel_generate views_ui field_ui masquerade admin_menu admin_menu_toolbar > /dev/null 2>&1

# some module configurations
drush block-configure --module=masquerade --delta=masquerade --region=header --weight=1
drush ucrt testauth --mail="testauth@example.com" --password="test" > /dev/null 2>&1
drush php-eval "variable_set('masquerade_quick_switches', array(2));"
drush php-eval "user_role_grant_permissions(2, array('access administration menu'));"

# some dev helpful variable settings
drush -y vset preprocess_css 0 > /dev/null 2>&1
drush -y vset preprocess_js 0 > /dev/null 2>&1
drush -y vset error_level 2 > /dev/null 2>&1
drush -y vset admin_menu_tweak_permissions 1 > /dev/null 2>&1
drush -y vset admin_menu_tweak_modules 1 > /dev/null 2>&1
drush -y vset views_ui_show_advanced_column 1 > /dev/null 2>&1
drush -y vset views_ui_show_master_display 1 > /dev/null 2>&1
drush -y vset nise_files_source_dir /home/awolfey/www/sb/oldnise/sites/default/files > /dev/null 2>&1
drush php-eval "variable_set('site_name', 'DEV LOCAL SB - '. variable_get('site_name', ''));" > /dev/null 2>&1

echo 'All done!'
