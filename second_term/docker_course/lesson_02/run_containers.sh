# first part
docker run --rm -d python > /dev/null
docker run --rm -d python > /dev/null
docker run --rm -d nginx > /dev/null
docker run --rm -d postgres > /dev/null
docker run --rm -d redis > /dev/null
docker run --rm -d golang > /dev/null
docker run --rm -d node > /dev/null

# second part
docker run --name python_1 -d python > /dev/null
docker run --name python_2 -d python > /dev/null
docker run --name nginx -d nginx > /dev/null

docker stop $(docker ps -q) > /dev/null
docker start python_1