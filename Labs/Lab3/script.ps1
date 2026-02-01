docker build -t bloq-luiz-app:latest .

docker run -d -p 80:80 --name bloq-luiz-app:latest

az login

#Create Resource Group
az group create --name containerappslab3 --location eastus2

#Register Container Registry Provider
az provider register --namespace Microsoft.ContainerRegistry

#Create Container Registry
az acr create --resource-group containerappslab3 --name bloqluizregistry --sku Basic

#Login to ACR
az acr login --name bloqluizregistry

#Tag the image
docker tag bloq-luiz-app:latest bloqluizregistry.azurecr.io/bloq-luiz-app:latest

#Publish the image to ACR
docker push bloqluizregistry.azurecr.io/bloq-luiz-app:latest

#ContainerID = bloqluizregistry.azurecr.io/bloq-luiz-app:latest
#User = bloqluizregistry
#Password = EpnEF2iLimHINsarQZwvpGv7yx2fXIeLa4HaqqeanNzVqvPTMkAcJQQJ99CAACHYHv6Eqg7NAAACAZCR16YE

#Create Environment for Container Apps - pendente para executar.
az containerapp env create --name env-bloqluiz --resource-group containerappslab3 --location eastus2

#Create Container App
az containerapp create --name bloqluizapp --resource-group containerappslab3 --location eastus2 --environment env-bloqluiz --image bloqluizregistry.azurecr.io/bloq-luiz-app:latest --cpu 0.5 --memory 1Gi --registry-login-server bloqluizregistry.azurecr.io --registry-username bloqluizregistry --registry-password EpnEF2iLimHINsarQZwvpGv7yx2fXIeLa4HaqqeanNzVqvPTMkAcJQQJ99CAACHYHv6Eqg7NAAACAZCR16YE --ingress 'external' --target-port 80
