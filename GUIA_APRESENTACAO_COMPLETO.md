# 🎓 Guia Master de Apresentação — Savir Cloud
## APS de Métodos Avançados de Programação (MAP)
**Professor Examinador:** Ms. Domingos Bruno  
**Instituição:** UNIFAN  
**Sistema:** Savir Cloud (Arquitetura de Microserviços Java + Angular SPA + DevOps AWS/Docker)

---

## 🗺️ Mapa Arquitetural de Pastas e Componentes
Para qualquer questionamento do professor sobre "onde está tal arquivo no projeto", consulte esta tabela de referência rápida:

| Componente | Função | Caminho Absoluto / Relativo no Workspace |
| :--- | :--- | :--- |
| **Orquestração Geral** | Docker Compose do ecossistema | `savir-sistemas-java/docker-compose.yml` |
| **Nginx (Gateway)** | Configuração de Rotas e Reverse Proxy | `savir-sistemas-java/nginx/nginx.conf` |
| **Nginx (Gateway)** | Arquivo de montagem da imagem Docker | `savir-sistemas-java/nginx/Dockerfile` |
| **Frontend SPA** | Interface do usuário (HTML/CSS/JS) | `savir-sistemas-java/frontend/` |
| **Frontend SPA** | Script de Rotas SPA (Angular/Hash) | `savir-sistemas-java/frontend/js/app.js` |
| **Auth Microservice** | Código-fonte Java do serviço de autenticação | `savir-sistemas-java/auth-service/` |
| **Auth Microservice** | Controller REST de Autenticação | `savir-sistemas-java/auth-service/src/main/java/com/savir/auth/controller/AuthController.java` |
| **Auth Microservice** | Controller REST de Usuários | `savir-sistemas-java/auth-service/src/main/java/com/savir/auth/controller/UserController.java` |
| **Auth Microservice** | Regras de Negócio (Service) | `savir-sistemas-java/auth-service/src/main/java/com/savir/auth/service/UserService.java` |
| **Auth Microservice** | Entidade MongoDB (Model) | `savir-sistemas-java/auth-service/src/main/java/com/savir/auth/model/User.java` |
| **Auth Microservice** | Configuração do Banco no MongoDB Atlas | `savir-sistemas-java/auth-service/src/main/resources/application.yml` |
| **Catalog Microservice** | Código-fonte Java do catálogo de negócios | `savir-sistemas-java/catalog-service/` |
| **Catalog Microservice** | Controller REST de Clientes | `savir-sistemas-java/catalog-service/src/main/java/com/savir/catalog/controller/ClientController.java` |
| **Catalog Microservice** | Controller REST de Produtos | `savir-sistemas-java/catalog-service/src/main/java/com/savir/catalog/controller/ProductController.java` |
| **Catalog Microservice** | Cliente de Comunicação HTTP RestTemplate | `savir-sistemas-java/catalog-service/src/main/java/com/savir/catalog/service/AuthClient.java` |
| **Catalog Microservice** | Configuração de Portas e DB Atlas | `savir-sistemas-java/catalog-service/src/main/resources/application.yml` |
| **Scripts Locais** | Inicializador de 1 clique (Windows) | `savir-sistemas-java/iniciar.bat` |
| **Scripts Locais** | Inicializador de 1 clique (Linux Mint) | `savir-sistemas-java/iniciar.sh` |

---

## 🚀 Roteiro de Apresentação Passo a Passo (Até 20 Minutos)

### 📌 ITEM 1: Apresentação do Tema Escolhido
* **O que falar:** 
  > *"Boa noite, professor Domingos e colegas. Nosso grupo escolheu desenvolver o **Savir Cloud**, um sistema ERP corporativo moderno de gestão interna para micro e pequenas empresas. O foco do sistema é a gestão de usuários com permissões específicas (RBAC), catálogo de produtos e gerenciamento completo de clientes.
  > 
  > O grande diferencial do nosso projeto é que ele não é um monólito genérico. Ele foi projetado para simular cenários reais do mercado corporativo internacional: escalabilidade horizontal, alta coesão, baixo acoplamento e tolerância a falhas através de uma **Arquitetura de Microserviços distribuída**, orquestrada em containers **Docker** e implantada na nuvem utilizando **AWS Elastic Beanstalk** e banco de dados NoSQL **MongoDB Atlas**."*
* **Explicação Técnica Profunda:**
  O sistema é dividido em domínios de negócio para evitar que uma falha em uma parte do código derrube a aplicação inteira (Resiliência de Sistemas).

---

### 📌 ITEM 2: Explicação se foi feita API ou Site Web
* **O que falar:**
  > *"Se o senhor analisar o escopo do Savir Cloud, nós desenvolvemos **ambos de forma totalmente dissociada**:
  > 1. **Site Web (Frontend SPA):** Uma aplicação rica de página única (Single Page Application - SPA) desenvolvida com foco em performance pura (HTML5, CSS3 moderno com Glassmorphism e JavaScript Vanilla/Angular reativo).
  > 2. **APIs REST (Backend Java):** Duas APIs REST totalmente autônomas construídas em **Java 17** com **Spring Boot**, que expõem endpoints seguros para envio e recebimento de payloads em formato **JSON**."*
* **Por que fizemos isso? (Justificativa de Arquitetura):**
  A dissociação completa permite o desenvolvimento paralelo. O frontend pode ser alterado esteticamente sem que o Java precise de recompilação. As APIs REST podem servir simultaneamente a aplicação web, aplicativos móveis (Android/iOS) e integrações com terceiros de maneira transparente.

---

### 📌 ITEM 3: Demonstração da Aplicação Funcionando
* **O que fazer na hora:** 
  Abra o navegador e faça a demonstração prática seguindo esta ordem de cliques (que funciona 100% no servidor da AWS):
  1. **Acessar a tela de login:** Explicar a interface estilizada com tema escuro e transições premium de CSS.
  2. **Login com Usuário Administrador (`admin` / `123`):** 
     - Mostrar que o administrador tem controle total de acessos.
     - Navegar até a lista de **Usuários** (`/#/users`), criar um usuário de teste, editá-lo e excluí-lo.
     - Navegar até a lista de **Clientes** (`/#/clients`) e **Produtos** (`/#/products`). Fazer um CRUD (cadastro, edição, listagem e exclusão) provando que os dados persistem em tempo real no MongoDB Atlas na nuvem.
  3. **Explicar o Controle de Acesso (RBAC - Role-Based Access Control):**
     - Fazer logout.
     - Fazer login com o Usuário Comum (`joao` / `123`).
     - Ir na tela de **Usuários**. Mostrar que o campo de "Perfil de Acesso" está visualmente travado (desabilitado) e que ele não possui permissão para editar outros usuários, apenas seu próprio perfil.
     - Tentar excluir um produto ou cliente. Mostrar a validação tanto visual no navegador quanto a validação de segurança HTTP.
* **Onde encontrar a lógica de Controle de Permissão no código Java?**
  Exiba o arquivo `catalog-service/.../AuthClient.java` para o professor, mostrando como o serviço de catálogo consome o serviço de autenticação para validar se o usuário é administrador antes de autorizar ações de exclusão:
  ```java
  public boolean isAdministrator(String userId) {
      Map<String, Object> user = getUserById(userId);
      return user != null && "Administrador".equals(user.get("profile"));
  }
  ```

---

### 📌 ITEM 4: Demonstração do Acesso pelo IP Público da EC2
* **O que falar e mostrar:**
  > *"Para comprovar que a aplicação está implantada na nuvem em ambiente real e não rodando de forma simulada no localhost, nós a implantamos na **AWS (Amazon Web Services)**. 
  > 
  > O nosso ponto de acesso público oficial é o DNS provido pelo Elastic Beanstalk, que resolve diretamente para o IP público da nossa instância EC2 na região `sa-east-1` (São Paulo):"*
* **URL Oficial para mostrar na tela:** 
  `http://savir-prod.eba-pakzjb39.sa-east-1.elasticbeanstalk.com/`
* **Explicar a Redireção do Nginx:**
  Explique ao professor que ao acessar a URL na porta `80`, o tráfego atinge a placa de rede da instância EC2. O Docker direciona o tráfego da porta `80` física da EC2 para o container do **Nginx (Gateway)**. O Nginx por sua vez serve os arquivos HTML/JS estáticos do frontend e delega as APIs de forma transparente.

---

### 📌 ITEM 5: Explicação da Instância Criada
* **O que falar:**
  > *"Utilizamos o serviço **AWS Elastic Beanstalk** para provisionar nossa infraestrutura. Ele criou e configurou de forma automática uma instância **Amazon EC2** do tipo **`t2.micro`** rodando em ambiente Linux otimizado para Docker (Amazon Linux 2023).
  > 
  > A instância possui **1 vCPU** (processador virtual Intel Xeon) e **1 GB de Memória RAM**, o que está perfeitamente alinhado com a cota gratuita (AWS Free Tier) e se mostra suficiente para suportar nossos microserviços otimizados graças ao uso de containers leves."*
* **Explicação DevOps (Containers e Orquestração):**
  Explique que, dentro dessa única instância EC2, a tecnologia **Docker** executa 3 microcontainers isolados em uma rede virtual interna criada pelo Docker Compose:
  1. **Container Nginx (Porta 80):** Escuta o tráfego público e atua como o Gateway de entrada.
  2. **Container auth-service (Porta interna 8081):** Executa o ambiente Java Runtime (JRE 17 Alpine) rodando o microserviço Spring Boot de autenticação.
  3. **Container catalog-service (Porta interna 8082):** Executa o Spring Boot de controle de catálogo de clientes/produtos.

---

### 📌 ITEM 6: Explicação do Security Group
* **O que falar:**
  > *"O **Security Group (SG)** na AWS funciona como um firewall de rede com estado (stateful firewall) no nível de instância. Ele dita quais portas estão abertas para receber tráfego externo (regras de Ingress/Inbound) e quais portas a instância pode usar para enviar dados ao exterior (regras de Egress/Outbound)."*
* **Quais regras configuramos na prática (Labs Security Group):**
  - **Regra de Entrada 1 (Porta 80 - HTTP):** Aberta para qualquer origem (`0.0.0.0/0`), permitindo que qualquer usuário no planeta acesse a interface web do Savir Cloud pelo navegador.
  - **Regra de Entrada 2 (Porta 22 - SSH):** Aberta para permitir a conexão remota criptografada para administração do servidor via terminal.
  - **Regras de Saída (Outbound):** Liberadas para todas as portas, permitindo que os microserviços acessem a internet pública para se conectarem ao banco de dados clusterizado **MongoDB Atlas** e baixar dependências necessárias.

---

### 📌 ITEM 7: Justificativa das Portas Liberadas
* **O que falar (Ponto crítico que o professor adora):**
  > *"A nossa arquitetura de portas foi planejada focando estritamente no **princípio do menor privilégio** e na **segurança multicamadas**:
  > 1. **Apenas a Porta 80 (HTTP) e a Porta 22 (SSH) estão públicas no Security Group da EC2.**
  > 2. **Por que as portas 8081 (auth-service) e 8082 (catalog-service) não estão abertas na nuvem?**
  >    Porque expor os servidores Java Spring Boot diretamente para a internet pública criaria uma superfície de ataque imensa (como ataques de injeção direta de rotas ou varreduras de vulnerabilidade de frameworks).
  > 3. **Como o tráfego chega aos microserviços então?**
  >    Toda requisição externa passa pelo Nginx na porta 80. O Nginx analisa a rota:
  >    - Se a requisição for para `/api/auth/` ou `/api/users/`, o Nginx faz o **Proxy Reverso** interno e envia para `http://auth-service:8081` dentro do Docker.
  >    - Se for para `/api/clients/` ou `/api/products/`, ele envia para `http://catalog-service:8082`.
  >    Desta forma, os servidores Spring Boot ficam completamente blindados e isolados por trás do gateway."*

---

### 📌 ITEM 8: Explicação dos Cuidados de Segurança Adotados
* **O que falar:**
  > *"Nossa aplicação adota 5 pilares fundamentais de segurança da informação corporativa:"*
* **Os 5 Pilares de Segurança a Detalhar:**
  1. **Acesso SSH Criptografado por Chaves Privadas Assimétricas:** O acesso à EC2 só é concedido através da chave `labsuser.pem` (par de chaves `vockey` na AWS). Não há login por senha no SSH do servidor, impossibilitando ataques de força bruta. Além disso, as permissões do arquivo da chave são restritas (`chmod 400 labsuser.pem`) para impedir leitura por outros usuários locais.
  2. **Isolamento de Redes em Containers Docker:** As portas das APIs Spring Boot (`8081` e `8082`) estão configuradas como `expose` e não `ports` no `docker-compose.yml`. Isso significa que elas são invisíveis até mesmo para a placa de rede física da EC2, estando limitadas apenas à rede virtual interna criada pelo Docker Daemon.
  3. **Segurança de Credenciais e Segredos (Sem Hardcode):** Não colocamos senhas em texto puro expostas no código do GitHub. As credenciais do banco de dados MongoDB Atlas são injetadas em variáveis de ambiente em tempo de execução no Docker (`MONGODB_URI`).
  4. **Proteção no MongoDB Atlas (IP Access List):** O banco de dados clusterizado na nuvem possui uma lista de controle de acesso por IP, garantindo que somente conexões originadas de endereços IPs autorizados (como a nossa EC2 da AWS) consigam realizar transações no banco.
  5. **Controle de Acesso Baseado em Perfis (RBAC) no Backend:** A verificação de permissões do usuário ocorre de maneira duplicada. O frontend esconde visualmente botões de ação para usuários comuns, mas o backend Spring Boot faz a validação real enviando requisições internas GET via `RestTemplate` para impedir que requisições falsificadas (via Postman) executem ações destrutivas (como exclusão de registros).

---

### 📌 ITEM 9: Participação de Todos os Integrantes
* **O que falar:**
  > *"A adoção de uma **Arquitetura Modular de Microserviços** e versionamento profissional com **Git e GitHub** foi o segredo do sucesso e da coesão do nosso grupo.
  > 
  > Como os domínios do sistema foram separados fisicamente, nossos integrantes puderam trabalhar de forma paralela sem travar o desenvolvimento uns dos outros:
  > - **Parte do Grupo** focou na modelagem de dados, conexão com o MongoDB Atlas e regras de negócio de cadastro de usuários e criptografia de credenciais no **`auth-service`**.
  > - **Outra parte** focou no desenvolvimento dos controladores e regras de negócio do catálogo de produtos e cadastros do **`catalog-service`**, além de implementar a comunicação síncrona via `RestTemplate`.
  > - **E os demais integrantes** trabalharam no desenvolvimento e refinamento estético da interface web em **Angular SPA (Frontend)** e na elaboração da infraestrutura de contêineres Docker, orquestração de rede do Nginx e deploy na AWS Academy."*

---

## 🧠 FAQ da Banca: Gotchas e Perguntas Críticas do Professor Domingos

Prepare-se para estas perguntas clássicas que o professor pode fazer na arguição. Responda com firmeza usando os roteiros abaixo:

### ❓ Pergunta 1: *"Por que vocês escolheram utilizar o Nginx como Proxy Reverso em vez de expor os microserviços Spring Boot diretamente nas portas 8081 e 8082?"*
* **Resposta de Impacto:**  
  > *"Por dois motivos fundamentais: **Segurança** e **Unificação de Ponto de Entrada**. 
  > 
  > Primeiro, expor as portas do Spring Boot diretamente na EC2 abriria o servidor para ataques focados no Tomcat. Com o Nginx na frente, o atacante externo só consegue enxergar o servidor web de alto desempenho Nginx na porta 80.
  > 
  > Segundo, isso resolve o problema do **CORS (Cross-Origin Resource Sharing)**. Como tanto os arquivos estáticos do frontend quanto as chamadas de API passam pelo Nginx na porta 80 sob o mesmo domínio, o navegador entende tudo como uma origem única, eliminando a necessidade de configurar regras complexas e inseguras de CORS nas nossas aplicações Java."*

---

### ❓ Pergunta 2: *"Como o microserviço `catalog-service` sabe se o usuário que está tentando deletar um cliente no banco de dados tem perfil de Administrador se a base de usuários fica no `auth-service`?"*
* **Resposta de Impacto:**  
  > *"Essa é a beleza da nossa comunicação síncrona de microserviços, professor. 
  > 
  > No `catalog-service`, criamos um serviço especializado chamado **`AuthClient.java`**. Quando o controller de clientes recebe uma requisição de exclusão, ele não consulta o banco diretamente. Em vez disso, ele usa a classe **`RestTemplate`** do Spring para enviar uma chamada HTTP GET interna para o endpoint `/api/users/{id}` do `auth-service`. 
  > 
  > O `auth-service` pesquisa o ID no MongoDB, valida o perfil e responde com o JSON do usuário. A classe `AuthClient` então intercepta o campo `profile` e verifica se o valor é exatamente `'Administrador'`. Caso não seja, a exclusão é imediatamente barrada e o backend retorna o código de erro HTTP `403 Forbidden`."*

---

### ❓ Pergunta 3: *"Se a instância EC2 da AWS Academy for reiniciada, os dados cadastrados de clientes e produtos são perdidos?"*
* **Resposta de Impacto:**  
  > *"Não, professor, os dados estão 100% seguros. 
  > 
  > Como adotamos o banco de dados NoSQL cloud-native **MongoDB Atlas**, nossos dados não residem no disco rígido local da instância EC2 (que é efêmero nas instâncias de laboratório da AWS). A conexão é efetuada por meio de uma string de conexão encriptada (`mongodb+srv://...`) apontando diretamente para um cluster multi-região gerenciado pela própria MongoDB. 
  > 
  > Se a EC2 explodir ou for desligada, basta subirmos os containers Docker em qualquer outro servidor do planeta que todas as informações continuarão intactas e prontas para consumo."*

---

### ❓ Pergunta 4: *"Onde no código-fonte Java estão declaradas as anotações do MVC e do Banco NoSQL?"*
* **Resposta de Impacto:**  
  Aponte para o código na tela ou explique as classes exatas:
  - **No SQL MongoDB Entity (`User.java` e `Client.java`):** Usamos a anotação **`@Document(collection = "users")`** do Spring Data MongoDB para mapear a classe diretamente para uma coleção do MongoDB, e o atributo chave é marcado com **`@Id`**.
  - **REST Controllers (`ClientController.java`):** Usamos as anotações **`@RestController`** para expor a classe como um serviço de API RESTful, **`@RequestMapping("/api/clients")`** para definir a rota base de acesso, e os verbos específicos **`@GetMapping`**, **`@PostMapping`**, **`@PutMapping`** e **`@DeleteMapping`** para direcionar os métodos de CRUD correspondentes.
  - **Injeção de Dependências (GRASP Controller/Information Expert):** Usamos a anotação **`@Autowired`** ou preferencialmente a injeção via construtor do Spring para acoplar os Repositories e Services, garantindo baixo acoplamento e testabilidade.
