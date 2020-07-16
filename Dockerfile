# ------------------------------------------------------------------------------
# Dockerfile to build database_volumes image
# ------------------------------------------------------------------------------

FROM python:3
# File Author / Maintainer
# Use LABEL rather than deprecated MAINTAINER
LABEL maintainer="ron@purestorage.com"

# Set the working directory to /app
WORKDIR /app

# Copy python script to container at /app
ADD database_volumes.py /app

RUN pip install py-pure-client

ENTRYPOINT ["python3", "database_volumes.py"]

# END
