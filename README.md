# Savir Cloud - Sistema de Gestão Corporativa Backend

![Java](https://img.shields.io/badge/Java-Spring_Boot-green?style=for-the-badge&logo=spring)
![AWS](https://img.shields.io/badge/Cloud-AWS-orange?style=for-the-badge&logo=amazon-aws)
![Docker](https://img.shields.io/badge/Container-Docker-blue?style=for-the-badge&logo=docker)
[![Docker Build CI](https://github.com/Mattys03/savir-cloud/actions/workflows/docker-build.yml/badge.svg)](https://github.com/Mattys03/savir-cloud/actions/workflows/docker-build.yml)

**Savir Cloud** é um ecossistema robusto de backend desenvolvido para sistemas de gestão corporativa. Construído sobre o framework **Spring Boot** (Java), a aplicação implementa uma arquitetura corporativa focada em escalabilidade, manutenibilidade e alta disponibilidade na nuvem (AWS).

O objetivo deste sistema é demonstrar as melhores práticas do mercado em Engenharia de Software Backend, desde a modelagem do banco de dados até a orquestração e deploy via serviços de Cloud Computing.

## 📸 Interface e Integração Cloud

Embora a interface visual seja herdada do nosso protótipo original (para manter a consistência da experiência do usuário), **toda a mecânica por trás das telas foi reescrita e otimizada** para rodar em um ecossistema robusto Java + AWS.

### 0. Tela de Autenticação (Segurança)
<img src="screenshots/login_v3.png" width="800" alt="Login" />
*Autenticação corporativa utilizando **Spring Security** e emissão de JWT (JSON Web Tokens) assinados no backend. As senhas são criptografadas em banco com BCrypt, garantindo conformidade total com padrões de segurança enterprise.*

### 1. Dashboard Principal (Alta Disponibilidade)
<img src="screenshots/dashboard_v3.png" width="800" alt="Dashboard" />
*O tráfego de dados para alimentar o Dashboard passa por um **Load Balancer (AWS ELB)** que distribui as requisições entre múltiplos contêineres Docker do Spring Boot. Isso resulta em carregamento instantâneo e ausência de gargalos, mesmo em horários de pico.*

### 2. Gestão de Usuários (JPA e Paginação)
<img src="screenshots/users_v3.png" width="800" alt="Usuários" />
*A tabela é alimentada através da **Spring Data JPA**. A grande evolução aqui é que a paginação e ordenação ocorrem diretamente no motor do banco de dados Relacional, processando milhares de registros sem estourar a memória RAM da aplicação.*

### 3. Catálogo de Produtos (Auto Scaling)
<img src="screenshots/products_v3.png" width="800" alt="Produtos" />
*Módulo de estoque protegido por Controle de Acesso (RBAC) através das anotações `@PreAuthorize` do Spring. Picos de acesso a este módulo desencadeiam o Auto Scaling da infraestrutura Cloud na AWS, escalando o sistema horizontalmente para dar conta da demanda.*

### 4. Cadastro de Clientes (Transações ACID)
<img src="screenshots/clients_v3.png" width="800" alt="Clientes" />
*Operações vitais de negócio agora são amparadas pelo gerenciador de transações do Spring (`@Transactional`). Qualquer interrupção durante o salvamento de um cliente engatilha um "Rollback" imediato, erradicando a chance de dados corrompidos no banco.*
## 🏗️ Arquitetura e Escopo

O projeto transcende um simples CRUD, atuando como o núcleo (core) de regras de negócio para uma empresa moderna. Ele lida com processos distribuídos, injeção de dependências eficiente e separação de responsabilidades (*Clean Architecture* e Padrões de Projeto).

- **API RESTful Completa:** Interfaces de comunicação padronizadas, utilizando verbos HTTP corretamente e retornos estruturados via JSON.
- **Integração de Banco de Dados:** Mapeamento Objeto-Relacional (ORM) usando Hibernate/JPA, focado em queries otimizadas e relacionamentos complexos de negócio.
- **Containerização:** O ambiente é integralmente portabilizado através de imagens **Docker**, garantindo paridade total entre o desenvolvimento local e a produção.

## ☁️ Infraestrutura e Deploy (AWS)

Um dos maiores diferenciais do **Savir Cloud** é o seu ambiente de infraestrutura. A aplicação foi desenhada para viver nativamente na nuvem, utilizando serviços da **Amazon Web Services (AWS)**:

1. **AWS Elastic Beanstalk (EB):** Orquestração automática do provisionamento do ambiente Java e balanceamento de carga, eliminando dores de cabeça de manutenção de servidores cruas (IaaS).
2. **AWS EC2 (Elastic Compute Cloud):** Máquinas virtuais rodando instâncias robustas configuradas automaticamente via EB.
3. **Gerenciamento de Logs & Monitoramento:** Estruturado para se conectar às esteiras do CloudWatch, provendo observabilidade total da aplicação.

*(Consulte o arquivo `RELATORIO_COMPLETO_AWS.md` incluído no repositório para evidências técnicas, prints de arquitetura e documentação aprofundada da infraestrutura cloud).*

## 🛠️ Tecnologias Dominadas

* **Linguagem Backend:** Java 17+
* **Framework:** Spring Boot, Spring MVC, Spring Data JPA
* **Banco de Dados:** PostgreSQL / MySQL 
* **DevOps:** Docker, Docker Compose
* **Cloud:** AWS (Elastic Beanstalk, EC2, IAM)

## 📦 Como Iniciar o Projeto Localmente

1. Clone o repositório:
   ```bash
   git clone https://github.com/Mattys03/savir-cloud.git
   ```
2. Inicie os containers do banco de dados (se aplicável na sua máquina):
   ```bash
   docker-compose up -d
   ```
3. Execute o script de inicialização nativo incluído no projeto:
   ```bash
   # Windows
   iniciar.bat
   
   # Linux/Mac
   ./iniciar.sh
   ```
4. A API estará respondendo em `http://localhost:8080/api/v1`.

## 📝 Licença

Desenvolvido para propósitos acadêmicos e demonstração de Portfólio.
