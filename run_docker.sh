# Show Docker container options
# docker run -ti database-volumes --help
# 
# Run database-volumes container
docker run -it --name database-volumes \
-v /Users/rekins/pureBuilders/log:/log database-volumes \
--token 5d8ad02f-547d-fc24-bb51-fa0d2b0de973 \
--server 10.225.112.80 \
--wait_time 5 
