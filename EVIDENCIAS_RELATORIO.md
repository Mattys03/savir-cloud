# 📋 Evidências de Execução e Configuração AWS - Savir Cloud

Este documento contém as evidências reais de execução e o comando exato configurado conforme exigido pela rubrica de avaliação do seminário de MAP.

---

## 7. Comando de Acesso via SSH

Para acessar a instância EC2 que executa o ambiente do Elastic Beanstalk na AWS Academy (que utiliza o par de chaves padrão `vockey`), utilize o seguinte comando. 

> **IMPORTANTE:** Certifique-se de que o arquivo privado `labsuser.pem` (baixado diretamente do painel da AWS Academy) esteja na mesma pasta em que você abrir o terminal.

```bash
# 1. Defina as permissões corretas para o arquivo da chave privada (obrigatório no Linux/macOS)
chmod 400 labsuser.pem

# 2. Comando de conexão SSH usando o DNS público da instância EC2 (ou o DNS do Beanstalk)
ssh -i "labsuser.pem" ec2-user@savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com
```

* **Chave privada:** `labsuser.pem` (gerada pela AWS Academy).
* **Usuário padrão:** `ec2-user` (padrão das imagens Amazon Linux 2 / Amazon Linux 2023 usadas pelo Beanstalk).
* **Host de acesso:** `savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com` (aponta direto para a instância da EC2).

---

## 8. Prints da Aplicação Rodando Localmente

### A. Inicialização e Compilação Local dos Microserviços
Quando executado localmente através dos scripts orquestradores (`iniciar.bat` para Windows ou `./iniciar.sh` para Linux Mint), o sistema compila os JARs do Spring Boot e inicializa o gateway Nginx local.

> **NOTA:** Abaixo está a evidência da tela inicial da aplicação rodando com sucesso no ambiente local (`http://localhost/` ou `http://127.0.0.1/`):
> ![Aplicação Rodando Localmente](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_login_aws.png)

---

## 9. Prints da Aplicação Rodando na EC2 (AWS Cloud)

### A. Acesso pelo DNS Público do Elastic Beanstalk
A aplicação web foi implantada com sucesso no Elastic Beanstalk da AWS e está acessível através do DNS público em sa-east-1 (São Paulo).

> **NOTA:** Abaixo está a evidência do dashboard do sistema logado como Administrador Principal acessando o DNS oficial da AWS:
> **DNS:** `http://savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com/`
> ![Dashboard logado na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_dashboard.png)

### B. Listagem de Clientes Cadastrados na Nuvem
Navegação para a rota `/#/clients` do sistema SPA, exibindo os registros reais salvos no MongoDB Atlas.

> **NOTA:** Evidência da lista de clientes carregada diretamente do banco de dados na nuvem:
> ![Lista de Clientes na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_clients_page.png)

### C. Listagem de Produtos Cadastrados na Nuvem
Navegação para a rota `/#/products` do sistema, exibindo o catálogo de produtos com preços e estoque.

> **NOTA:** Evidência da lista de produtos no sistema em produção:
> ![Lista de Produtos na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_products_page.png)

---

## 10. Prints dos Testes de Payload no Postman e Navegador

### A. Teste de Endpoint e Retorno JSON da API REST (Diretamente na Nuvem)
Para comprovar o funcionamento da API REST independente da interface frontend, foi realizada uma requisição `GET` ao endpoint `/api/clients` usando o DNS público da nuvem. O resultado foi um retorno HTTP `200 OK` com o payload JSON completo dos clientes cadastrados no MongoDB Atlas.

* **DNS do Endpoint:** `http://savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com/api/clients`
* **Resultado:** Código HTTP `200 OK` com JSON formatado.

> **Evidência Visual (Requisição GET real ao endpoint da API na AWS):**
> ![Teste de API real no navegador](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_api_formatted.png)

### B. Gestão de Usuários e Controle de Permissões (CRUD)
A página de usuários mostra o sistema completo de gerenciamento com perfis de Administrador e Usuário, comprovando as operações CRUD e o controle de acesso baseado em papéis.

> **NOTA:** Evidência visual da lista de usuários com perfis e ações de edição/exclusão:
> ![Gestão de Usuários na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_users_page.png)
