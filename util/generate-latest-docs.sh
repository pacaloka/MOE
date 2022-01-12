#

if [ "$TRAVIS_REPO_SLUG" == "google/MOE" ] && \
   [ "$TRAVIS_JDK_VERSION" == "oraclejdk7" ] && \
   [ "$TRAVIS_PULL_REQUEST" == "false" ] && \
   [ "$TRAVIS_BRANCH" == "master" ]; then
  echo -e "Publishing javadoc...\n"
  
  mvn javadoc:aggregate
  TARGET="$(pwd)/target"

  cd $HOME
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/google/MOE gh-pages > /dev/null
  
  cd gh-pages
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "travis-ci"
  git rm -rf api/latest 
  mv ${TARGET}/site/apidocs api/latest
  git add -A -f api/latest
  git commit -m "Latest javadoc on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
  git push -fq origin gh-pages > /dev/0

  echo -e "Published Javadoc to gh-pages.\n"
fi
