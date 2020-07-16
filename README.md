# pure-database-volumes
The container reports Oracle database space usage for Pure FlashArray Volumes which have been 'tagged' duing the Ansible **ORCA** (*Oracle Rapid Clone Automation*) process. 

You can learn all about [ORCA](https://ronekins.com/2020/07/15/oracle-database-volume-tagging-with-purity-6-0/) at my Blog

# Build Docker Container
Run `./build_docker.sh` to build database-volumes container
 
Confirm docker image has been created ok with:
```
$ docker images 
REPOSITORY                              TAG                 IMAGE ID            CREATED             SIZE
database-volumes                        latest              7f85efa3be09        2 minutes ago       981MB
python                                  3                   ea8c3fb3cd86        2 days ago          934MB
```

# Run Container
The docker image can be run with `./run_docker.sh`

The containter accepts a number of options which can be listed with *--help*

The example below provides API Token, FlashArray and Wait Time to the container
```
docker run -it --name database-volumes \
-v /Users/rekins/pureBuilders/log:/log database-volumes \
--token 5d8ad02f-547d-fc24-bb51-fa0d2b0de973 \
--server 10.225.112.80 \
--wait_time 5
```

# List All Container Options
```
$ docker run -ti database-volumes --help
Usage: database_volumes.py [options]

Please contact ron@purestorage.com for any assistance.

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  -d DEBUG_LEVEL, --debug=DEBUG_LEVEL
                        Debug level, used for HTTP debugging
  -p PASSWORD, --password=PASSWORD
                        Pure password
  -s FLASHARRAY, --server=FLASHARRAY
                        Pure FlashArray
  -w WAIT_TIME, --wait_time=WAIT_TIME
                        Wait Time in minutes [default: 60]
  -t API_TOKEN, --token=API_TOKEN
                        Pure Api Token
  -V API_VERSION, --apiversion=API_VERSION
                        Pure FlashArray API Version
  -u USER, --user=USER  Pure user name
  -v, --verbose         Verbose [default: False]
```
# Connect to running container
`$ docker exec -it database-volumes "/bin/bash"`

# For use with Kubernetes
For use with Kubernetes we first need to tag our Docker image using `docker tag <image> <registry>` e.g.

`$ docker tag 7f85efa3be09 registry:32000/database-volumes`

We can the push into the registry with `docker push registry` e.g

`$ docker push registry:32000/database-volumes`

# Create Namespace
`$ kubectl create namespace pure-namespace`

# Create configMap
`$ kubectl create configmap cm --from-env-file=database_volumes.properties -n pure-namespace`

# Create StatefulSet
`$ kubectl apply -f database_volumes.yaml`

# Connect to running pod
`$ kubectl exec -it database-volumes-0  -n pure-namespace -- /bin/bash`
