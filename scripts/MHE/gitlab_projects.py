#!/usr/local/Caskroom/miniconda/base/bin/python

#import os
#import gitlab
#
#def list_group(group):
#    # Print group name and path
#    print(f"Group: {group.name}, Path: {group.path}")
#
#    # List repositories under the group
#    repositories = group.projects.list(all=True)
#    for repository in repositories:
#        print(f"  Repository: {repository.name}")
#
#    # List subgroups recursively
#    subgroups = group.subgroups.list(all=True)
#    for subgroup in subgroups:
#        list_group(subgroup)
#
#
## Gitlab server ulr
#gitlab_url = 'https://gitlab.devops.telekom.de'
#
## Get the gitlab access token from os env variables
#access_token = os.environ.get('GITLAB_ACCESS_TOKEN')
#
#if not access_token:
#    raise ValueError("Gitlab env variable for token not found. Export the env.")
#
## Create the gitlab client instance
#gl = gitlab.Gitlab(gitlab_url, private_token=access_token)
#
## Authenticate with gitlab server
#gl.auth()
#
## Group path 
#group_path = 'mhe'
#
## Get the group by it's path
#group = gl.groups.get(group_path)
#
## List projects under the group
##projects = group.projects.list(all=True)
## List repositories recursively
#list_group(group)
#

import os
import gitlab

def list_group(group):
    # Print group name and path
    print(f"Group: {group.name}, Path: {group.path}")

    # List repositories under the group
    repositories = group.repositories.list(all=True)
    for repository in repositories:
        print(f"  Repository: {repository.name}")

    # List subgroups recursively
    subgroups = group.subgroups.list(all=True)
    for subgroup in subgroups:
        list_group(subgroup)

# Define GitLab server URL
gitlab_url = 'https://gitlab.devops.telekom.de'

# Get the GitLab access token from the environment variable
access_token = os.environ.get('GITLAB_ACCESS_TOKEN')

if not access_token:
    raise ValueError("GitLab access token not found. Please set the GITLAB_ACCESS_TOKEN environment variable.")

# Create GitLab client instance
gl = gitlab.Gitlab(gitlab_url, private_token=access_token)

# Authenticate with GitLab server
gl.auth()

# Get the top-level group
group_path = 'mhe'
group = gl.groups.get(group_path)

# List groups and subgroups recursively
list_group(group)
