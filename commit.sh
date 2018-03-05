rm hosts
rm *.retry
git config --global user.name "Sander"
git config --global user.email sander@revenberg.info

git add -A *
git commit -m "update"

git push origin master
