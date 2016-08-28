#!/bin/bash
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake db:seed
RAILS_ENV=production rails server -p 3000 -b '0.0.0.0'
