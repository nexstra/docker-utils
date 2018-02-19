#!/bin/echo YOU MUST SOURCE THIS FILE $0
#

ECR=${ECR:-$AWS_ECR}
repos() 
{ 
  docker images --format "{{.Repository}}" |sort -u
}
images () 
{ 
  docker images --format "{{.Repository}}:{{.Tag}}"  |grep -v '<none>' |sort -u
}

lastimage() {
   docker images --format '{ "date" : "{{.CreatedAt}}", "image":"{{.Repository}}","id":"{{.ID}}","tag":"{{.Tag}}"}' "$1" | 
   jq  -s 'sort_by(.date)|.[]|select(.tag != "latest")|select(.tag != "")| select(.tag != "<none>")' | jq -s -r '.[0]' #|(.id+" "+.image+":"+.tag)'
}
imagelike()
{
  docker images --format "{{.ID}} {{.Tag}} {{.Repository}}"  |  grep "$1"
}

rmlike() {
  imagelike "$1"|
   while read id tag repo ; do
    printf "Removing $id $tag $reo\n" >&2
    docker rmi "$id"
  done
}

ours(){
  while IFS== read x r eol ; do
    echo $r
  done < build/versions.properties
}      

tagours() {
  for r in $(ours) ; do 
    docker tag "$r" "$ECR/$r" 
  done
}
push() {
  local r="$1"
  echo "pushing $r" >&2
  docker tag "$r" "$ECR/$r" 
  docker push "$ECR/$r"
  docker rmi "$ECR/$r"
}

pushours() {
  for r in $(ours) ; do
    docker tag "$r" "$ECR/$r" 
      docker push "$ECR/$r"
    done
  }

createrepo() {
  aws ecr create-repository --repository-name "${1%%:*}"
}
createours() {
 for r in $(ours) ; do
    createrepo $r
 done
}
