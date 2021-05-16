#!/#bin/bash

export AWS_PROFILE=homeos-aws-prd
repo_names=(`aws ecr describe-repositories --profile homeos-aws-prd  | grep repositoryName | awk '{print$2}' | sed -e s/\"//g -e s/,//g`)
repo_with_findings=()
repo_failed_scans=()

#findings=`aws ecr describe-images --profile homeos-aws-prd --repository-name $i --query 'sort_by(imageDetails,& imagePushedAt)[-1]'  | grep findingSeverityCounts | awk '{print$2}'`
for i in "${repo_names[@]}"
do
echo "Scanning repo: $i"
result=`aws ecr describe-images --profile homeos-aws-prd  --repository-name $i --query 'sort_by(imageDetails,& imagePushedAt)[-1]'  | grep findingSeverityCounts | awk '{print $2}'`
if [[ $result == "{" ]]
then
    repo_with_findings+=($i)
    findings=`aws ecr describe-images --profile homeos-aws-prd  --repository-name $i --query 'sort_by(imageDetails,& imagePushedAt)[-1]' | jq {imageScanFindingsSummary}`
    echo "###################################" >> ./Vulnerabilities
    echo "Repo name: $i"  >> ./Vulnerabilities
    echo "$findings"  >> ./Vulnerabilities
    echo "___________________________________" >> ./Vulnerabilities

elif  [[ $result != "{}" ]]
then
    repo_failed_scans+=($i)
fi
done

echo "all_repos=${#repo_names[@]}"
echo "repo_with_findings=${#repo_with_findings[@]}"
echo "failed scanned repos=${#repo_failed_scans[@]}"
echo ${repo_names[@]} | sed 's/ /\n/g' > repo_names.txt
echo ${repo_failed_scans[@]} | sed 's/ /\n/g' > repo_failed_scans.txt
