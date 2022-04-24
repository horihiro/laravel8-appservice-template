#!/bin/bash

cp /home/site/wwwroot/scripts/default /etc/nginx/sites-available/default
service nginx reload
