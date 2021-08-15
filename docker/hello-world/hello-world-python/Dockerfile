FROM python:alpine3.10
WORKDIR /app
COPY reuirements.txt /app/reuirements.txt
RUN pip install -r reuirements.txt
EXPOSE 5000
COPY . /app
ENTRYPOINT ["python", "./launch.py"]

# COPY reuirements.txt /app/reuirements.txt
# ENTRYPOINT ["python", "./launch.py"]