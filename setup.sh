#sudo usermod -aG docker $USER && newgrp docker;
minikube delete
minikube start --driver=docker;

eval $(minikube docker-env);

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml;
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml;
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)";

kubectl apply -f ./metallb/config.yaml;
docker build -t hello_python ./app/dummy/;
docker build -t scale_python ./app/master/;

kubectl apply -f ./app/dummy/deployment.yaml;
kubectl apply -f ./master/deployment.yaml;

minikube addons enable dashboard
minikube addons enable ingress
minikube addons enable metrics-server

minikube dashboard
