echo "Cleanup your commit history"

git checkout --orphan latest_branch
git add -A
git commit -am "feat: initial commit - include config files"
git branch -D main
git branch -m main
git push -f origin main
