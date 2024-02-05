#!/bin/sh
group_name=mhe
group_id=41110
#1. list groups id of subgroups
#2. check if the id is subgroup or project
#3. if it project create a file with the project name and paste inside the only the group runners


#!/bin/bash

## Function to list projects in a subgroup
#list_projects_in_group() {
#    local group_id="$1"
#    local group_name="$2"
#
#    # List projects in the current subgroup and suppress output
#    local projects=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/projects" | jq -r '.[].name')
#
#    # Print projects in the current subgroup
#    echo "Projects in $group_name:"
#    echo "$projects"
#
#    # Get subgroups of the current group and suppress output
#    local subgroups=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/subgroups" | jq -r '.[].id')
#
#    # Recursively list projects in subgroups
#    for subgroup_id in $subgroups; do
#        local subgroup_name=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$subgroup_id" | jq -r '.name')
#        list_projects_in_group "$subgroup_id" "$subgroup_name"
#    done
#}


# Start listing projects and runners from the top-level group
#!/bin/bash

# Function to list projects and their tags in a subgroup
#!/bin/bash

# Function to list projects and their tags in a subgroup
#list_projects_in_group() {
#    local group_id="$1"
#    local group_name="$2"
#
#    # List projects in the current subgroup and suppress output
#    local projects=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/projects" | jq -r '.[].name')
#
#    # Print projects in the current subgroup
#    echo "Projects in $group_name:"
#    echo "$projects"
#
#    # Get subgroups of the current group and suppress output
#    local subgroups=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/subgroups" | jq -r '.[].id')
#
#    # Recursively list projects and their tags in subgroups
#    for project in $projects; do
#        local project_id=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/projects?search=$project" | jq -r '.[0].id')
#        #local gitlab_ci_file=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/projects/$project_id/repository/files/.gitlab-ci.yml/raw"| grep -A2 tags)
#        curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/projects/$project_id/repository/files/.gitlab-ci.yml/raw"| grep -A2 tags | grep aks
#        #local tag=$(echo "$gitlab_ci_file" | jq -r '. | select(.tags) | .tags | join(", ")')
#        
#        echo "Tags for project $project:"
#        echo "$tag"
#    done
#
#    # Recursively list projects and their tags in subgroups
#    for subgroup_id in $subgroups; do
#        local subgroup_name=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$subgroup_id" | jq -r '.name')
#        list_projects_in_group "$subgroup_id" "$subgroup_name"
#    done
#}

#!/bin/bash

# Function to list projects and their tags in a subgroup
#!/bin/bash

# Function to list projects and their tags in a subgroup
list_projects_in_group() {
    local group_id="$1"
    local group_name="$2"

    # List projects in the current subgroup and suppress output
    local projects=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/projects" | jq -r '.[].name')

    # Print projects in the current subgroup
    echo "Projects in $group_name:"
    echo "$projects"

    # Get subgroups of the current group and suppress output
    local subgroups=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/subgroups" | jq -r '.[].id')

    # Recursively list projects and their tags in subgroups
    for project in $projects; do
        local project_id=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/projects?search=$project" | jq -r '.[] | select(.name == "'"$project"'") | .id')
        local gitlab_ci_file=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/projects/$project_id/repository/files/.gitlab-ci.yml/raw")
        local tag=$(echo "$gitlab_ci_file" | jq -r '. | select(.tags) | .tags | join(", ")')
        
        echo "Tags for project \"$project\":"
        echo "$tag"
    done

    # Recursively list projects and their tags in subgroups
    for subgroup_id in $subgroups; do
        local subgroup_name=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$subgroup_id" | jq -r '.name')
        list_projects_in_group "$subgroup_id" "$subgroup_name"
    done
}

# Start listing projects and tags from the top-level group


top_level_group_id=$group_id  # Replace with the ID of the top-level group
top_level_group_name=$group_name  # Replace with the name of the top-level group
list_projects_in_group "$top_level_group_id" "$top_level_group_name"
#list_projects_in_group "$top_level_group_id" "$top_level_group_name"
