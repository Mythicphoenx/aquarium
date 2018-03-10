rm hosts 2>/dev/null
rm *.retry 2>/dev/null
rm *.log 2>/dev/null
rm nohup.out 2>/dev/null

git config --global user.name "Sander"
git config --global user.email "sander@revenberg.info"

git add -A *
git add -u
git commit -m "update"

git push origin master
