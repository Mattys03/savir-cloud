# 🎓 Relatório Técnico Final: Computação em Nuvem (AWS)
## Sistema: Savir Cloud — ERP de Gestão Corporativa Modular
**Disciplina:** Computação em Nuvem  
**Professor Orientador:** Ms. Domingos Bruno  
**Instituição:** UNIFAN  

---

### b. Relatório em PDF (15 Requisitos Obrigatórios)

---

### 1. Nome e Matrícula dos Integrantes
* **Integrante 1:** Matheus R. (Matrícula: `[Inserir Matrícula Aqui]`)
* **Integrante 2:** `[Inserir Nome Integrante 2]` (Matrícula: `[Inserir Matrícula]`)
* **Integrante 3:** `[Inserir Nome Integrante 3]` (Matrícula: `[Inserir Matrícula]`)

---

### 2. Tipo de Aplicação Escolhida: API ou Site Web
A aplicação **Savir Cloud** foi desenvolvida utilizando uma **arquitetura moderna desacoplada**, contemplando ambas as vertentes:
1. **API REST (Backend):** Dois microserviços totalmente independentes construídos em **Java 17** com o framework **Spring Boot** (`auth-service` na porta interna `8081` e `catalog-service` na porta interna `8082`). Eles se comunicam entre si via chamadas HTTP síncronas (`RestTemplate`) e respondem em formato padronizado **JSON**.
2. **Site Web (Frontend SPA):** Uma aplicação rica de página única (Single Page Application - SPA) desenvolvida com foco em performance e experiência do usuário, utilizando HTML5, CSS3 moderno com efeitos de Glassmorphism e JavaScript Vanilla/Angular reativo, rodando de forma assíncrona no cliente.

---

### 3. Tema e Objetivo da Aplicação
* **Tema:** ERP (Enterprise Resource Planning) de Gestão Interna Empresarial.
* **Objetivo:** Oferecer uma plataforma web corporativa centralizada para micro e pequenas empresas gerenciarem seus recursos. O sistema fornece controle completo de acessos baseado em perfis (RBAC - Role-Based Access Control), gerenciamento cadastral (CRUD) de clientes, cadastro de catálogo de produtos com controle de estoque e auditoria básica de ações dos usuários.

---

### 4. Tecnologias Utilizadas
O ecossistema do Savir Cloud foi projetado utilizando tecnologias líderes de mercado em desenvolvimento e infraestrutura:
* **Linguagem Backend:** Java 17 (JDK LTS).
* **Framework Backend:** Spring Boot 3.x (Spring Web, Spring Data MongoDB).
* **Frontend:** HTML5, CSS3 (Glassmorphism), JavaScript (SPA Router).
* **Servidor Web e Gateway:** Nginx (Proxy Reverso e Servidor Estático).
* **Conteinerização:** Docker e Docker Compose.
* **Provedor de Nuvem:** Amazon Web Services (AWS) via AWS Elastic Beanstalk.
* **Instância Computacional:** Amazon EC2.
* **Banco de Dados:** MongoDB Atlas (NoSQL cloud-native clusterizado).
* **Acesso Remoto:** SSH com criptografia assimétrica de chaves públicas/privadas.

---

### 5. Descrição da Instância EC2 Criada
A infraestrutura foi provisionada de forma automatizada pelo Elastic Beanstalk na região **América do Sul (São Paulo - `sa-east-1`)**:
* **Serviço de Host:** Amazon Elastic Compute Cloud (EC2).
* **Tipo de Instância:** `t2.micro` (dentro da cota gratuita da AWS).
* **Recursos de Hardware:** 1 vCPU (processador virtual Intel Xeon) e 1 GB de Memória RAM.
* **Sistema Operacional:** Linux (Amazon Linux 2023 - AL2023).
* **Ambiente de Runtime:** Docker Community Edition pré-instalado.
* **Orquestração Interna:** Docker Compose gerenciando 3 containers paralelos (`nginx`, `auth-service`, `catalog-service`) em rede isolada de alto desempenho.

---

### 6. Explicação do IP Público e do Acesso Externo
A instância EC2 criada possui um **IP público dinâmico IPv4** associado e está atrelada a um **DNS Público** amigável provido automaticamente pelo Elastic Beanstalk.
* **DNS de Entrada:** `http://savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com/`
* **Mecanismo de Roteamento:**
  1. O usuário digita o DNS no navegador na porta padrão `80` (HTTP).
  2. O tráfego de rede atinge o IP público da placa de rede da instância EC2.
  3. O Docker intercepta a porta física `80` e a direciona para a porta `80` interna do container do **Nginx Gateway**.
  4. O Nginx atua como **Proxy Reverso**: ele mesmo serve os arquivos estáticos do frontend Angular e repassa as chamadas de rotas de API (`/api/*`) internamente para os respectivos containers Java (`auth-service` ou `catalog-service`) sem expor os microserviços Java diretamente para a internet.

---

### 7. Comando de Acesso via SSH
Para administração remota do sistema operacional Linux da instância EC2 de forma segura, o acesso é feito por meio de criptografia SSH assimétrica utilizando a chave privada (`labsuser.pem` / par de chaves padrão `vockey` do AWS Academy):

```bash
# 1. Aplicar permissões restritas à chave privada (exigência de segurança SSH)
chmod 400 labsuser.pem

# 2. Conectar via SSH à instância EC2 usando o usuário padrão Amazon Linux e o domínio público
ssh -i "labsuser.pem" ec2-user@savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com
```

---

### 8. Prints da Aplicação Rodando Localmente
A aplicação foi validada e executada localmente de forma automatizada por meio de scripts orquestradores (`iniciar.bat` no Windows e `./iniciar.sh` no Linux Mint) compilando os JARs do Spring Boot e subindo o ecossistema local na porta `80`.

> **Evidência Visual: Tela de Login Acessada Localmente**
> ![Aplicação Rodando Localmente](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_login_aws.png)

---

### 9. Prints da Aplicação Rodando na EC2 (AWS Cloud)

#### A. Painel de Integridade do AWS Elastic Beanstalk (`sa-east-1` - São Paulo)
Abaixo está o console oficial do AWS Beanstalk na conta do usuário, comprovando que o ambiente está com integridade **Ok** (saudável) e operacional na região de São Paulo.
* **Nome do Ambiente:** `savir-java-env` (Hospedando microserviços Docker)

> **Evidência Visual: Console AWS Elastic Beanstalk**
> ![Elastic Beanstalk Console](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/aws_eb_sa_east_1.png)

#### B. Instâncias EC2 Ativas e Saudáveis na AWS (`sa-east-1` - São Paulo)
Abaixo está a listagem de instâncias EC2 rodando em tempo real na conta do usuário (**MatheusR023**), mostrando a máquina ativa com status **"Executando"** e IP associado.

> **Evidência Visual: Instâncias EC2 no Console AWS**
> ![EC2 Console](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/aws_ec2_sa_east_1.png)

#### C. Dashboard da Aplicação Logada na AWS (Savir Cloud)
Visualização real do sistema rodando diretamente sob o DNS oficial da nuvem da AWS, provando a renderização correta de cards e métricas dinâmicas.

> **Evidência Visual: Painel de Controle Rodando na AWS**
> ![Dashboard na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_dashboard.png)

---

### 10. Prints dos Testes no Navegador, Postman, Swagger, Insomnia ou cURL

#### A. Validação Direta da API REST (Retorno de Payload JSON)
Para comprovar o pleno funcionamento da API REST de forma desacoplada do frontend, foi efetuado um teste direto na nuvem consumindo o endpoint `/api/clients` do catálogo, retornando o código HTTP `200 OK` e o JSON com a coleção completa de dados do MongoDB Atlas.

* **URL de Teste:** `http://savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com/api/clients`

> **Evidência Visual: Retorno JSON da API na Nuvem**
> ![Teste de API no Navegador](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_api_formatted.png)

#### B. CRUD e Persistência de Dados na Nuvem (Tela de Clientes)
Captura de tela demonstrando o frontend exibindo os clientes cadastrados em tempo real, cujas transações de banco são processadas na EC2 e persistidas no cluster do MongoDB Atlas.

> **Evidência Visual: Listagem de Clientes Realizada na Nuvem**
> ![CRUD de Clientes na AWS](file:///C:/Users/jv05g/.gemini/antigravity-ide/brain/cc720ead-c53d-4051-88bf-6ae8c5f3e221/real_clients_page.png)

---

### 11. Descrição das Portas Liberadas no Security Group
O **Security Group (SG)** configurado na AWS atua como o firewall de rede da nossa instância EC2. Foram definidas regras estritas de entrada e saída (Inbound/Outbound Rules):
* **Porta de Entrada 80 (HTTP):** Aberta para qualquer IP de origem (`0.0.0.0/0`), permitindo conexões públicas de navegadores de usuários à interface web.
* **Porta de Entrada 22 (SSH):** Liberada para permitir o tráfego administrativo criptografado do console CLI (terminal).
* **Portas de Saída (Todas):** Liberadas de forma irrestrita, permitindo que os containers da instância iniciem conexões externas para consumir a API do MongoDB Atlas (`porta 27017`) e baixar pacotes do repositório Linux.

---

### 12. Justificativa das Regras de Segurança
Seguindo o **princípio do menor privilégio (least privilege)** e segurança em profundidade:
1. **Blindagem dos Microserviços:** As portas de escuta internas dos servidores Spring Boot (Java `8081` e `8082`) **não estão expostas** no Security Group. Elas não são acessíveis pela internet física. O único ponto de contato público é a porta `80` do Nginx, minimizando drasticamente a superfície de ataque e tentativas de injeção de payloads diretos em frameworks.
2. **Isolamento de Redes via Docker:** A rede virtual interna criada pelo Docker Compose impossibilita que qualquer processo externo acesse os microserviços backend sem passar pelas regras rígidas de proxy reverso e autenticação do Nginx.

---

### 13. Explicação da Responsabilidade Compartilhada
De acordo com o **Modelo de Responsabilidade Compartilhada da AWS**, a segurança na nuvem é dividida entre o provedor (AWS) e o cliente (nosso grupo):

```
       ┌───────────────────────────────────────────────────────────┐
       │             Modelo de Responsabilidade Compartilhada      │
       └─────────────────────────────┬─────────────────────────────┘
                                     │
         ┌───────────────────────────┴───────────────────────────┐
         │                                                       │
 ┌───────▼──────────────────────────────┐ ┌──────────────────────▼──────────────┐
 │    AWS: Segurança DA Nuvem           │ │   Nosso Grupo: Segurança NA Nuvem   │
 ├──────────────────────────────────────┤ ├─────────────────────────────────────┤
 │ • Redes Globais e Datacenters        │ │ • Configuração do Sistema Operacional│
 │ • Segurança Física das Instalações   │ │ • Regras de Firewall (Security Group)│
 │ • Hipervisores de Virtualização      │ │ • Código Backend Java e APIs        │
 │ • Gerenciamento do Hardware Físico   │ │ • Proteção de Credenciais e Dados   │
 └──────────────────────────────────────┘ └─────────────────────────────────────┘
```

* **AWS (Segurança DA Nuvem):** Responsável por garantir o funcionamento físico dos datacenters, gerenciar o hipervisor de virtualização do EC2, a estabilidade de energia elétrica nos racks e a segurança física das redes globais de telecomunicação da AWS.
* **Nosso Grupo (Segurança NA Nuvem):** Responsável por aplicar atualizações de segurança no sistema operacional Linux convidado, configurar corretamente as portas fechadas no Security Group, gerenciar as credenciais criptografadas sem expô-las em texto puro (variáveis de ambiente), codificar autenticações seguras no backend Java e proteger o banco de dados via IP Access List no MongoDB Atlas.

---

### 14. Dificuldades Encontradas e Soluções Adotadas
1. **Dificuldade 1: Bloqueios de CORS (Cross-Origin Resource Sharing)**
   * *Problema:* Como os microserviços (`auth` e `catalog`) rodavam em portas internas diferentes das do frontend Angular, o navegador barrava requisições assíncronas por motivos de segurança cross-origin.
   * *Solução:* Implementamos o **Nginx como Gateway**. Ele unificou o frontend e todas as APIs na porta única `80`. O navegador entende as chamadas como mesma origem (Same-Origin), eliminando a necessidade de permissões CORS inseguras no Spring Boot.
2. **Dificuldade 2: Discos Rígidos Efêmeros da AWS Academy**
   * *Problema:* Se a instância EC2 do laboratório fosse interrompida ou recriada pelo Elastic Beanstalk, todas as informações de clientes e produtos cadastradas localmente seriam sumariamente apagadas.
   * *Solução:* Adotamos o banco de dados **MongoDB Atlas** rodando em cluster gerenciado na nuvem. A EC2 apenas processa as regras de negócio e os dados persistem de forma totalmente externa e segura contra desligamentos acidentais.

---

### 15. Conclusão do Grupo
A implantação bem-sucedida do **Savir Cloud** na AWS consolidou de forma prática os conceitos teóricos de Computação em Nuvem e Arquitetura de Software. O uso de uma arquitetura modular baseada em microserviços e contêineres Docker provou ser altamente flexível e ideal para deploy contínuo em ambientes Cloud-Native. 

A plataforma da AWS, especificamente o Elastic Beanstalk, demonstrou o poder da automação de infraestrutura em nuvem (IaaS/PaaS), permitindo focar estritamente na lógica do negócio e segurança da aplicação, enquanto o provedor absorve a carga operacional de provisionamento. O resultado final é um sistema resiliente, escalável e pronto para simular as exigências de mercado das maiores corporações de tecnologia do mundo.
