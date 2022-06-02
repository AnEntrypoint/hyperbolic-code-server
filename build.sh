echo "tag image with arm or amd64:"
echo "arm | amd64"
read platform

docker build -t "av8ta/hyperbolic-grain:main-$platform" .
