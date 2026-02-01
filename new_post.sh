#!/bin/bash
# Usage: ./new_post.sh "My Post Title"

TITLE="$*"
DATE=$(date +%Y-%m-%d)
FILENAME="/Users/alexji/Documents/alexji.github.io/_posts/${DATE}-$(echo $TITLE | tr '[:upper:]' '[:lower:]' | tr ' ' '-').md"

cat > "$FILENAME" <<EOF
---
layout: post
title: "$TITLE"
date: $DATE
---

Write your post here...
EOF

echo "Created: $FILENAME"
# Open in your editor
emacs -nw "$FILENAME"
