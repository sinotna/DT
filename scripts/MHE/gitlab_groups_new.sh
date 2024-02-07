#!/bin/bash
group_name=mhe
group_id=41110
#group_id=114707


# List project inside a subgroup, search for any gitlab-ci file and search the tag fields.

list_projects () {
    local project_id="$1"
    local project_url=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$project_id/projects" | jq -r '.[].http_url_to_repo')
    #Convert subgroups_id string to an array.
    project_url_array=()
    while IFS= read -r id; do
        project_url_array+=("$id")
    done <<< "$project_url"
    for i in ${project_url_array[@]}
        do
            git clone  --depth 1 $i # Shallow clone. Clone only the latest commit.
        done
}



# List all groups and subgroups unde mhe

list_subgroups ()  {
    local subgroup_id="$1"
    echo "subgroup_id = $subgroup_id"
    local subgroups_id=$(curl --silent --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$subgroup_id/subgroups" | jq -r '.[].id')
    #Convert subgroups_id string to an array.
    subgroups_id_array=()
    while IFS= read -r id; do
        subgroups_id_array+=("$id")
    done <<< "$subgroups_id"
    ###
    
    for x in ${subgroups_id_array[@]}
        do
        list_projects "$x"
        list_subgroups "$x"        
        done

}

list_subgroups "$group_id"