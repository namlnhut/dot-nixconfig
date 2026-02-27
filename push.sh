#!/usr/bin/env bash

set -e  # Exit immediately if a command fails

# -------- CONFIG --------
SSH_KEY_PATH="$HOME/.ssh/id_rsa_namlnhut_github"      # Change if using a different key
BRANCH="main"                         # Change if needed
# ------------------------

if [ -z "$1" ]; then
  echo "Usage: ./push.sh \"commit message\""
  exit 1
fi

COMMIT_MESSAGE="$1"

echo "▶ Running agent evaluation..."
$EVAL_COMMAND

echo "▶ Starting ssh-agent..."
eval "$(ssh-agent -s)"

echo "▶ Adding SSH key..."
ssh-add "$SSH_KEY_PATH"

echo "▶ Adding changes..."
git add .

echo "▶ Committing..."
git commit -m "$COMMIT_MESSAGE" || echo "Nothing to commit"

echo "▶ Pushing to $BRANCH..."
git push origin "$BRANCH"

echo "✅ Done!"
