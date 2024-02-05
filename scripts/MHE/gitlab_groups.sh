#!/bin/bash
group_name=mhe
group_id=41110
#1. list groups id of subgroups
#2. check if the id is subgroup or project
#3. if it project create a file with the project name and paste inside the only the group runners



#list_groups
#
#group_id () {
#    
#    groupids=$(curl --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups?search=$group_name" | jq '.[].id')
#    #curl --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id" | jq '.[].id'
#    # Convert the space-separated list of IDs into an array
#   # Capture the output of the curl command in a variable
#
#    # Convert the space-separated list of IDs into an array using a while loop
#    group_ids_array=()
#    while IFS='\n' read -r id; do
#        echo "1"
#        group_ids_array+=("$id")
#    done <<< "$group_ids"
#}
#
#subgroup_ids () {
##Check if it is a subgroup or project
#    curl --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id/subgroups" | jq '.[].id'
#}
#
##group_id
#groupids=$(curl --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups?search=$group_name" | jq '.[].id')
#    #curl --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups/$group_id" | jq '.[].id'
#    # Convert the space-separated list of IDs into an array
#   # Capture the output of the curl command in a variable
#
#    # Convert the space-separated list of IDs into an array using a while loop
#    group_ids_array=()
#    while IFS= read -r id; do
#        echo "1"
#        group_ids_array+=("$id")
#    done <<< "$group_ids"
#for id in "${group_ids_array[@]}"; do
#    echo "$id"
#done
#
#!/bin/bash

# Capture the output of the curl command in a variable
group_ids=$(curl --header "Private-Token:$GITLAB_ACCESS_TOKEN" "https://gitlab.devops.telekom.de/api/v4/groups?search=$group_name" | jq -r '.[].id')

echo "Group IDs:"
echo "$group_ids"

# Convert the newline-separated list of IDs into an array using a while loop
group_ids_array=()
while IFS= read -r id; do
    echo "Adding ID: $id to the array"
    group_ids_array+=("$id")
done <<< "$group_ids"

# Output the array contents
echo "Array contents:"
for id in "${group_ids_array[@]}"; do
    echo "$id"
done
