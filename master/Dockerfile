FROM python:3.7

RUN mkdir /app
WORKDIR /app
ADD . /app/
RUN mkdir -p ~/.kube/
RUN mkdir -p ~/.minikube/profiles/minikube/
RUN mv ./config ~/.kube/
RUN mv ./ca.crt ~/.kube/
RUN mv ./client.crt ~/.kube/
RUN mv ./client.key ~/.kube/
RUN pip install -r requirements.txt

EXPOSE 5000
CMD ["python3", "/app/main.py"]
