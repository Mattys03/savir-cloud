# 🎓 Relatório Técnico: Configuração SSH da AWS e Evidências Visuais (Itens 7, 8, 9 e 10)

Este documento registra as explicações, configurações de rede/segurança na AWS e as evidências de execução da aplicação **Savir Cloud** para o seminário de Métodos Avançados de Programação (MAP).

---

## 🔑 1. Configuração e Acesso via SSH (Item 7)

### Contexto da Chave
* **Nome oficial da Chave na AWS:** **`vockey`** (par de chaves padrão criado automaticamente pelas contas de estudante do *AWS Academy Learner Lab*).
* **Nome do arquivo baixado:** **`labsuser.pem`** (o arquivo contendo a chave privada necessária para realizar a criptografia e autenticação do terminal com a instância EC2).

### Configurações de Arquivos Locais
Os arquivos de configuração do Elastic Beanstalk do projeto foram atualizados de `null` para referenciar a chave oficial:
* **Caminho dos arquivos modificados:**
  * [savir-sistemas/.elasticbeanstalk/config.yml](file:///E:/video%20prontos/codig%20cri/savir-sistemas/.elasticbeanstalk/config.yml)
  * [savir-sistemas-java/.elasticbeanstalk/config.yml](file:///E:/video%20prontos/codig%20cri/savir-sistemas-java/.elasticbeanstalk/config.yml)
* **Snippet configurado:**
  ```yaml
  global:
    default_ec2_keyname: vockey
  ```

### Comando Exato de Acesso SSH
Para acessar o sistema operacional da instância EC2 pela linha de comando:
```bash
# 1. Ajustar as permissões de leitura da chave privada (segurança obrigatória do SSH)
chmod 400 labsuser.pem

# 2. Conectar à instância utilizando o usuário padrão da AWS e o DNS público do Beanstalk
ssh -i "labsuser.pem" ec2-user@savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com
```

---

## 💻 2. Execução em Ambiente Local (Item 8)

### Inicialização e Compilação dos Microserviços
A inicialização local foi automatizada com scripts orquestradores que configuram o proxy e sobem os containers Java:
* **No Windows:** Executar o script [iniciar.bat](file:///E:/video%20prontos/codig%20cri/savir-sistemas-java/iniciar.bat)
* **No Linux Mint:** Executar o script [iniciar.sh](file:///E:/video%20prontos/codig%20cri/savir-sistemas-java/iniciar.sh)

> **Evidência Visual (Tela de login da aplicação acessando o servidor AWS):**
> ![Tela de Login](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_login_aws.png)

---

## ☁️ 3. Execução em Ambiente de Nuvem na AWS (Item 9)

### Acesso pelo DNS Público do Elastic Beanstalk
O frontend da aplicação web e as APIs dos microserviços estão unificados e rodando em instâncias de produção da AWS sob demanda (sa-east-1).

* **DNS Público:** `http://savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com/`

> **Evidência Visual (Dashboard do sistema logado como Administrador Principal na AWS):**
> ![Dashboard logado na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_dashboard.png)

### Listagem de Clientes na Nuvem
Os dados dos clientes são persistidos no MongoDB Atlas e carregados em tempo real pelo frontend Angular.

> **Evidência Visual (Lista de Clientes com dados reais do banco de dados na nuvem):**
> ![Lista de Clientes na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_clients_page.png)

### Listagem de Produtos na Nuvem
O catálogo de produtos com preços, descrições e estoque é gerenciado pelo `catalog-service` (Spring Boot).

> **Evidência Visual (Lista de Produtos com dados reais na nuvem):**
> ![Lista de Produtos na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_products_page.png)

---

## 🧪 4. Testes de Integração e Payload da API REST (Item 10)

### Teste de Endpoint REST Direto na Nuvem
Para comprovar o funcionamento da API REST independente da interface frontend, foi realizada uma requisição `GET` ao endpoint `/api/clients` usando o DNS público do Elastic Beanstalk. O resultado foi um retorno HTTP `200 OK` com o JSON completo.

* **DNS do Endpoint:** `http://savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com/api/clients`
* **Resultado:** Código HTTP `200 OK` e o JSON com a coleção completa de dados do banco MongoDB Atlas.

> **Evidência Visual (Requisição GET real ao endpoint da API na nuvem):**
> ![Teste de API real](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_api_formatted.png)

### Gestão de Usuários e Controle de Permissões
O sistema implementa controle de acesso baseado em papéis (RBAC). O perfil "Administrador" possui permissão total para gerenciar todos os registros, enquanto o perfil "Usuário" possui acesso restrito.

> **Evidência Visual (Painel de gestão de usuários com perfis e ações CRUD):**
> ![Gestão de Usuários](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_users_page.png)
