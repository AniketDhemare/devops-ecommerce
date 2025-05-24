#!/bin/bash

# File to ignore (relative or absolute path)
IGNORE_FILE="./complete-deploy.yaml"

echo "Applying all Kubernetes manifests from: $(pwd)"
echo "Ignoring: $IGNORE_FILE"

# Find and apply all .yaml/.yml files except the one to ignore
find . -type f \( -iname "*.yaml" -o -iname "*.yml" \) | while read -r file; do
  # Skip the ignore file
  if [[ "$file" == "$IGNORE_FILE" ]]; then
    echo "Skipping: $file"
    continue
  fi

  echo "Applying: $file"
  kubectl apply -f "$file"
done

echo "✅ Done applying all manifests (except ignored file $IGNORE_FILE)."
