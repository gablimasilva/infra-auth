# Infra Auth

Repositório responsável pelo provisionamento da infraestrutura de autenticação da plataforma de venda de veículos.

A autenticação é realizada através do AWS Cognito e provisionada utilizando Terraform.

## Recursos Provisionados

- AWS Cognito User Pool
- AWS Cognito User Pool Client
- AWS Cognito User Pool Domain

## Estrutura do Projeto

```text
infra-auth

|-- modules
|   `-- cognito
|       |-- main.tf
|       |-- variables.tf
|       `-- outputs.tf
|
|-- environments
|   |-- dev
|   |   |-- main.tf
|   |   |-- provider.tf
|   |   |-- variables.tf
|   |   |-- terraform.tfvars
|   |   `-- outputs.tf
|   |
|   `-- prod
|       |-- main.tf
|       |-- provider.tf
|       |-- variables.tf
|       |-- terraform.tfvars
|       `-- outputs.tf
|
|-- .github
|   `-- workflows
|       `-- terraform.yml
|
|-- .gitignore
`-- README.md
```

## Ambientes

O projeto possui dois ambientes:

- Development (dev)
- Production (prod)

Cada ambiente possui sua própria configuração Terraform e utiliza o mesmo módulo compartilhado.

## Pré-Requisitos

### Terraform

Verificar instalação:

```bash
terraform --version
```

### AWS CLI

Verificar instalação:

```bash
aws --version
```

### Credenciais AWS

Configurar credenciais:

```bash
aws configure
```

Informar:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

## Executando Terraform

### Ambiente de Desenvolvimento

Entrar na pasta:

```bash
cd environments/dev
```

Inicializar:

```bash
terraform init
```

Validar:

```bash
terraform validate
```

Executar plano:

```bash
terraform plan
```

Aplicar infraestrutura:

```bash
terraform apply
```

### Ambiente de Produção

Entrar na pasta:

```bash
cd environments/prod
```

Inicializar:

```bash
terraform init
```

Validar:

```bash
terraform validate
```

Executar plano:

```bash
terraform plan
```

Aplicar infraestrutura:

```bash
terraform apply
```

## Outputs

Após a execução do Terraform serão disponibilizadas as seguintes informações:

### User Pool ID

```text
sa-east-1_xxxxxxxxx
```

### Client ID

```text
xxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Issuer URL

```text
https://cognito-idp.sa-east-1.amazonaws.com/sa-east-1_xxxxxxxxx
```

## Integração com a API

Os valores gerados deverão ser utilizados na API de veículos.

Exemplo:

```json
{
  "Authentication": {
    "Authority": "https://cognito-idp.sa-east-1.amazonaws.com/sa-east-1_xxxxxxxxx",
    "Audience": "xxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
```

Configuração do JWT Bearer:

```csharp
builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority =
            builder.Configuration["Authentication:Authority"];

        options.Audience =
            builder.Configuration["Authentication:Audience"];
    });
```

## CI/CD

O projeto possui validação automática através do GitHub Actions.

Fluxo:

```text
Pull Request
    |
    v
Terraform Init
    |
    v
Terraform Validate
    |
    v
Terraform Plan
```

## Segurança

Nenhuma credencial AWS deve ser armazenada no repositório.

Utilizar:

- AWS CLI
- GitHub Secrets
- IAM Roles

para autenticação e autorização.

## Observações

Este repositório é responsável exclusivamente pela camada de autenticação.

Infraestruturas complementares são mantidas em repositórios independentes:

- infra-auth
- infra-banco
- infra-cluster
- api-veiculos