
# npm run build
under package/web-server

# npm run export
under package/web-server

# build nginx image
docker image build -t mock-server ./packages/web-server/docker/static

# run mock-server with volume of static html files
docker container run --rm -p 8080:80 -it -v /home/sijoonlee/Document_2/github-action-study/lighthouse-action-playground/packages/web-server/out:/usr/share/nginx/html mock-server sh

docker container run --rm -p 11111:80 -v /home/sijoonlee/Document_2/github-action-study/lighthouse-action-playground/packages/web-server/out:/usr/share/nginx/html mock-server



# docker network

docker network create --subnet 172.20.0.0/16 --ip-range 172.20.240.0/20 lighthouse-test-network

docker container run -d --rm --name lighthouse-test-server \
-v /home/sijoonlee/Document_2/github-action-study/lighthouse-action-playground/packages/web-server/out:/usr/share/nginx/html mock-server

docker network connect --ip 172.20.128.2 lighthouse-test-network lighthouse-test-server
