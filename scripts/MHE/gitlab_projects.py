#!/usr/local/Caskroom/miniconda/base/bin/python

import os
import gitlab

# Gitlab server ulr
gitlab_url = 'https://gitlab.devops.telekom.de'

# Get the gitlab access token from os env variables
access_token = os.environ.get('GITLAB_ACCESS_TOKEN')

print(access_token)