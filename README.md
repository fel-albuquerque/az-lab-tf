Esses arquivos com terraform, são para criação de uma topologia Hub and Spoke. 

Para que possa fazer testes de conectividade entre as VMS para internet atráves do Azure Firewall.

A ideia deste repositório é ter diversos laboratórios, onde possa ser mais facil de criar elementos na Azure tanto para estudo como para demonstrações. 

Para criação destes laboratórios estou utilizando workspace para que possa facilitar a utilização. 


Antes de executar os comandos terraform, é preciso fazer o login na Azure.

Comandos.
$ az login  ou az login --use-device-code 

Após realizar o login, selecionar a subscription desejada.

Mas primeiro podemos listar as subscriptions que desejamos.
$ az account list -o table

Após listar, agora fazer com que ela seja a nossa subscrition desejada.
$ az account set --subscription "numero-da-sua-sub"

Comandos para criar o workspace do terraform.
$ terraform workspace new NOME_DO_WORKSPACE

Listar o workspace criado 

$ terraform workspace list

O que estivar com o * na frente do nome criado é o workspace que está utiliazndo.

Iniciando o terraform 
$ terraform init 

Criando o plano ( Com o plano será mostrado o que o terraform irá criar na Azure)
$ terraform plan 

Comando apply do terraform (por ser um laboratorio estou utilizando o -auto-approve) NÃO FAÇO ISSO EM AMBIENTE DE PRD. 
$ terraform apply -auto-approve

Para destruir o laboratório (por ser um laboratorio estou utilizando o --auto-approve) NÃO FAÇO ISSO EM AMBIENTE DE PRD. 
$ terraform destroy -auto-approve

