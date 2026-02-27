#!/usr/bin/env bash

set -e  # exit on error

BRANCH="main"   # change if needed
REMOTE="origin"

echo "▶ Checking if inside a git repository..."
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "❌ Not inside a git repository."
  exit 1
fi

echo "▶ Checking for uncommitted changes..."
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "⚠️ You have uncommitted changes."
  echo "Please commit or stash them before pulling."
  exit 1
fi

echo "▶ Fetching latest changes from $REMOTE..."
git fetch "$REMOTE"

LOCAL=$(git rev-parse @)
REMOTE_HEAD=$(git rev-parse "$REMOTE/$BRANCH")
BASE=$(git merge-base @ "$REMOTE/$BRANCH")

if [ "$LOCAL" = "$REMOTE_HEAD" ]; then
  echo "✅ Already up to date."
  exit 0
fi

if [ "$LOCAL" = "$BASE" ]; then
  echo "▶ Fast-forward merge..."
  git merge --ff-only "$REMOTE/$BRANCH"
  echo "✅ Fast-forward complete."
  exit 0
fi

if [ "$REMOTE_HEAD" = "$BASE" ]; then
  echo "⚠️ Your branch is ahead of remote."
  echo "Nothing to pull."
  exit 0
fi

echo "▶ Branches have diverged. Performing merge..."
if git merge "$REMOTE/$BRANCH"; then
  echo "✅ Merge successful."
else
  echo "❌ Merge conflicts detected!"
  echo "Resolve conflicts, then run:"
  echo "   git add ."
  echo "   git commit"
  exit 1
fi
