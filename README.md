# Build theme
Build theme using wp-cli's command "scaffold \_s".
This command run after vagrant up.

## What is your theme name?
Enter your theme name. ex. My awesome theme :P.

## What is your theme slug?
Enter your theme slug. ex. my-awesome-theme

## Set task runner
Then this command get package.json from "git@github.com:marushu/package.git" repo.
And set browser-sync's proxy from your hostname at site.yml. (Default vccw.dev)

### And run these commands.
* npm install
* npm run watch:all

Scss(node-sass), browser-sync, imagemin, etc... :)
