echo "---------------hexo g---------------"
hexo g
echo "---------------finished hexo g---------------"
echo "---------------hexo d---------------"
hexo d
echo "---------------finished hexo d---------------"
echo "========= All Done ========"
curl -H 'Content-Type:text/plain' --data-binary @urls.txt "http://data.zz.baidu.com/urls?site=blog.huangyz.name&token=UIrLz1shlCNhoLSx"
echo " "
echo "-------- Push Site to Baidu --------"
git checkout sources
git add . && git commit -m "added new materials"
git push
echo "-------- Push to Github --------"
