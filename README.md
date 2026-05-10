# Savir Cloud — Sistema de Gestão Empresarial

**Trabalho APS - Métodos Avançados de Programação (MAP)**
**Prof. Ms. Domingos Bruno**

## Integrantes do Grupo
- Matheus Rego Pinheiro

---

## 1. Tema e Objetivo

Sistema de Gestão Empresarial com **Cadastro de Usuários, Clientes e Produtos**, utilizando:
- **Java 17 + Spring Boot 3.2**
- **Arquitetura MVC** (Model-View-Controller)
- **Arquitetura de Microserviços**
- **APIs REST** com formato JSON
- **Padrões GRASP**
- **MongoDB Atlas** (banco de dados na nuvem)

---

## 2. Arquitetura de Microserviços

O sistema é dividido em **2 microserviços independentes** que se comunicam via HTTP REST:

```
┌──────────────────────┐        ┌──────────────────────┐
│   AUTH SERVICE        │        │   CATALOG SERVICE     │
│   (porta 8081)        │◄──────►│   (porta 8082)        │
│                       │  HTTP   │                       │
│ • Login/Autenticação  │        │ • CRUD de Clientes    │
│ • CRUD de Usuários    │        │ • CRUD de Produtos    │
└──────────┬────────────┘        └──────────┬────────────┘
           │                                │
           └──────────┬─────────────────────┘
                      │
              ┌───────▼────────┐
              │  MongoDB Atlas  │
              │  (Banco NoSQL)  │
              └────────────────┘
```

### Comunicação entre Microserviços
O `catalog-service` se comunica com o `auth-service` via **RestTemplate** (HTTP GET) para verificar permissões de usuários antes de operações sensíveis como exclusão.

---

## 3. Arquitetura MVC

Cada microserviço segue o padrão MVC:

| Camada | Classe | Responsabilidade |
|--------|--------|-----------------|
| **Model** | `User.java`, `Client.java`, `Product.java` | Representam as entidades e dados |
| **Controller** | `AuthController`, `UserController`, `ClientController`, `ProductController` | Recebem requisições HTTP e delegam |
| **View** | Frontend HTML/JS | Interface de visualização |
| **Service** | `UserService`, `ClientService`, `ProductService` | Lógica de negócio |

---

## 4. Endpoints REST (APIs)

### Auth Service (porta 8081)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| POST | `/api/auth/login` | Autenticação de usuário |
| GET | `/api/users` | Listar todos os usuários |
| GET | `/api/users/{id}` | Buscar usuário por ID |
| POST | `/api/users` | Criar novo usuário |
| PUT | `/api/users/{id}` | Atualizar usuário |
| DELETE | `/api/users/{id}` | Excluir usuário |

### Catalog Service (porta 8082)

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/clients` | Listar todos os clientes |
| GET | `/api/clients/{id}` | Buscar cliente por ID |
| POST | `/api/clients` | Criar novo cliente |
| PUT | `/api/clients/{id}` | Atualizar cliente |
| DELETE | `/api/clients/{id}` | Excluir cliente |
| GET | `/api/products` | Listar todos os produtos |
| GET | `/api/products/{id}` | Buscar produto por ID |
| POST | `/api/products` | Criar novo produto |
| PUT | `/api/products/{id}` | Atualizar produto |
| DELETE | `/api/products/{id}` | Excluir produto |

Todos os endpoints retornam dados em **formato JSON**.

---

## 5. Padrões GRASP Aplicados

### 5.1 Controller
**Onde:** `AuthController`, `UserController`, `ClientController`, `ProductController`
**Justificativa:** Os Controllers centralizam o recebimento de requisições HTTP. Não contêm lógica de negócio — apenas recebem, delegam ao Service apropriado, e retornam a resposta.

### 5.2 Creator
**Onde:** `UserService.create()`, `ClientService.create()`, `ProductService.create()`
**Justificativa:** Os Services são responsáveis por criar novas instâncias das entidades, pois são eles que possuem acesso ao repositório e conhecem as regras de criação (ex: validar login duplicado).

### 5.3 Expert (Especialista)
**Onde:** `UserService`, `ClientService`, `ProductService`
**Justificativa:** Cada Service é o especialista no seu domínio. O `UserService` conhece as regras de usuário (autenticação, validação de login), o `ClientService` conhece as regras de cliente, etc.

### 5.4 Alta Coesão (High Cohesion)
**Onde:** Todas as classes do projeto.
**Justificativa:** Cada classe tem uma única responsabilidade:
- `User.java` → apenas dados de usuário
- `UserRepository` → apenas acesso ao banco
- `UserService` → apenas lógica de negócio
- `UserController` → apenas rotas HTTP

### 5.5 Baixo Acoplamento (Low Coupling)
**Onde:** Comunicação entre microserviços via `AuthClient` + `RestTemplate`.
**Justificativa:** O `catalog-service` NÃO depende diretamente do código do `auth-service`. A comunicação é feita via HTTP REST, permitindo que cada serviço seja desenvolvido, testado e implantado de forma independente.

---

## 6. Como Executar

### Pré-requisitos
- Java 17 (JDK)
- Maven 3.9+

### Passo 1: Iniciar o Auth Service
```bash
cd auth-service
mvn spring-boot:run
```
O serviço inicia na porta **8081**.

### Passo 2: Iniciar o Catalog Service
```bash
cd catalog-service
mvn spring-boot:run
```
O serviço inicia na porta **8082**.

### Passo 3: Abrir o Frontend
Abrir o arquivo `frontend/index.html` no navegador.

**Login padrão:** `admin` / `123`

### Com Docker (opcional)
```bash
docker-compose up --build
```

---

## 7. Tecnologias Utilizadas
- **Java 17** (Eclipse Temurin)
- **Spring Boot 3.2.5**
- **Spring Data MongoDB**
- **MongoDB Atlas** (banco de dados na nuvem)
- **HTML5, CSS3, JavaScript** (frontend sem frameworks)
- **Docker** (para containerização e deploy)
- **Maven** (gerenciador de dependências)
- **AWS Elastic Beanstalk & CloudFront** (Hospedagem e proxy HTTPS)

---

## 8. Arquitetura de Deploy na AWS

O sistema está hospedado na Amazon Web Services (AWS) com foco em **alta performance de deploy** e **segurança mobile**.

### 8.1. Otimização de Build (Fast Deploy)
Como a instância do Elastic Beanstalk (EC2 `t3.micro`) possui recursos limitados (1GB de RAM), compilar duas aplicações Java via Maven diretamente no servidor causava lentidão extrema (mais de 15 minutos) e eventuais falhas por falta de memória (Timeouts). 
A solução implementada foi a adoção de **Deploy de JARs Pré-compilados**:
1. Os arquivos `.jar` são compilados localmente (na máquina de desenvolvimento).
2. O `Dockerfile` foi radicalmente simplificado para utilizar a imagem `eclipse-temurin:17-jre-alpine` (super leve, ~50MB) e apenas copiar os `.jar` prontos.
3. Isso reduziu o tempo de deploy na AWS de **~15 minutos para apenas ~30 segundos**.

### 8.2. Proxy Seguro com AWS CloudFront (HTTPS)
Ao acessar a aplicação via dispositivos móveis (ex: links no WhatsApp ou navegadores modernos como Safari/Chrome mobile), os aparelhos forçam conexões seguras (`https://`). Como o domínio nativo da AWS (`.elasticbeanstalk.com`) não suporta a emissão direta de certificados SSL/TLS, os acessos mobile ficavam travados em um carregamento infinito.

Para resolver o problema de forma nativa e 100% gratuita na AWS:
- Criou-se uma distribuição no **AWS CloudFront** atuando como proxy reverso.
- O CloudFront fornece um domínio seguro (`https://d332eloo83c24a.cloudfront.net`) com um certificado SSL válido emitido pela Amazon.
- Quando o usuário acessa via celular de forma segura, o CloudFront recebe o tráfego em HTTPS e repassa para o ambiente do Elastic Beanstalk (via HTTP interno), garantindo o carregamento imediato da aplicação sem erros de privacidade ou telas pretas.

