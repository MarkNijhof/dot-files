#!/bin/bash

for d in `find . -maxdepth 5 -name .git -type d`; do
  cd $d/.. > /dev/null
  RESULT=$(git status 2>&1)

  if ! [[ "$RESULT" =~ (.*)'nothing to commit'(.*) ]]; then 
    echo -e "\nChanges detected in: $(pwd)"
    echo -e "$RESULT"
  fi
  
  cd - > /dev/null
done