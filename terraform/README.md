deploy-ec2-terraform
Os comandos para iniciar o deploy da infraestrutura da VPC:
$ terraform init # irá preparar a pasta do projeto para iniciar o deploy; neste momento também será realizado o download do "source" declarado nos resources.

$ terraform plan -out tfplan # O Terraform irá exibir aquilo que será alterado no seu ambiente Cloud; O '-out tfplan' é opcional.

$ terraform apply "tfplan" # Nesse momento tudo que foi preparado no "plan" será aplicado no seu ambiente Cloud.

$ terraform output -raw private_key_pem > privkey.pem # O output private_key_pem "salvou" no tfplan a chave privada e colocaremos em um arquivo. *Lembre-se de ajustar as permissões para 'chmod 400'.

Após isso, conecte-se a instância:

$ ssh -i privkey.pem ubuntu@[IP]

Testou, validou, conectou? Massa!! E agora será que podemos deletar o ambiente que realizamos o deploy? Sim!

$ terraform destroy
