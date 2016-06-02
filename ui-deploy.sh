#! /bin/bash

git add public
git commit -m "Latest UI deploy"
ggpush
git push heroku master
heroku restart
