#!/#bin/bash
#create a list with all the repo names
#
#aws ecr describe-repositories --profile homeos-aws-prd  | grep repositoryName | awk '{print$2}' | sed -e s/\"//g -e s/,//g
#
#create a dictionary with the repo name and the latest image
#aws ecr describe-images --profile homeos-aws-prd  --repository-name homeos-ara --query 'sort_by(imageDetails,& imagePushedAt)[-1]'
#check for common images and include them only once
#create a list with the images that have valnerabiliteis
#list the varnelability of the images
export AWS_PROFILE=homeos-aws-prd
repo_names=(`aws ecr describe-repositories --profile homeos-aws-prd  | grep repositoryName | awk '{print$2}' | sed -e s/\"//g -e s/,//g`)
repo_with_findings=()
repo_failed_scans=()§
#findings=`aws ecr describe-images --profile homeos-aws-prd --repository-name $i --query 'sort_by(imageDetails,& imagePushedAt)[-1]'  | grep findingSeverityCounts | awk '{print$2}'`
for i in "${repo_names[@]}"
do
echo "Scanning repo: $i"
result=`aws ecr describe-images --profile homeos-aws-prd  --repository-name $i --query 'sort_by(imageDetails,& imagePushedAt)[-1]'  | grep findingSeverityCounts | awk '{print $2}'`
if [[ $result == "{}" ]]
then
    repo_with_findings+=($i)
else
    repo_failed_scans+=($i)
fi
done

echo "all_repos=${#repo_names[@]}"
echo "repo_with_findings=${#repo_with_findings[@]}"
echo "failed scanned repos=${#repo_failed_scans[@]}"



