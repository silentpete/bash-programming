#!/bin/bash
#
# Need to a sript to get a group name, and all folders and repos and then check them out.
#
# References
# - https://docs.gitlab.com/ee/api/rest/
#
# General Curl Example to get a GitLab Group ID
# $ curl -s --header "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" "${GITLAB_SERVER_URL}/api/v4/groups?search=${GITLAB_GROUP_NAME}"
#
# From that response, get the GitLab Repos in that group
# $ curl -s --header "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" "${GITLAB_SERVER_URL}/api/v4/groups/${GITLAB_GROUP_ID}/projects"

# ASK BING CHAT: can you please write me a bash script that can take in a gitlab group name and then git clone all the repos in it

# Set GitLab Vars
GITLAB_GROUP_NAME=${1-'test'}
GITLAB_SERVER_URL=${2-'https://gitlab.com'}

# Get the GitLab group ID
GITLAB_GROUP_ID="$(curl -s --header "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" "${GITLAB_SERVER_URL}/api/v4/groups?search=${GITLAB_GROUP_NAME}" | jq '.[0].id')"

# Clone all the repositories in the group
for REPO in $(curl -s --header "PRIVATE-TOKEN: ${GITLAB_PRIVATE_TOKEN}" "${GITLAB_SERVER_URL}/api/v4/groups/${GITLAB_GROUP_ID}/projects" | jq -r '.[].ssh_url_to_repo'); do
  git clone "${REPO}"
done
