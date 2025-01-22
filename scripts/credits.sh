#!/bin/bash

# Author and project metadata
export AUTHOR_NAME="Randolph William Aarseth II"
export AUTHOR_EMAIL="randolph@divine.games"
export PROJECT_NAME="Blazium Engine"
export DESCRIPTION="Deployment system for web-exported games using Nginx and Docker."
export ORGANIZATION="Divine Games"
export COPYRIGHT_YEAR=$(date +"%Y")

# Display the credits (optional)
cat <<EOF
Author: $AUTHOR_NAME
Email: $AUTHOR_EMAIL
Project: $PROJECT_NAME
Description: $DESCRIPTION
Organization: $ORGANIZATION
Copyright: © 2024 - $COPYRIGHT_YEAR $ORGANIZATION
EOF
