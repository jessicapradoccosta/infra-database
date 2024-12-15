# Modelo de Dados - Sistema de Pedidos e Entregas

## 1. Tabelas

### **categories**
A tabela `categories` armazena informações sobre as categorias dos produtos disponíveis no sistema.
- **id** (PK): Identificador único da categoria.
- **name**: Nome da categoria.
- **description**: Descrição da categoria.

### **clients**
A tabela `clients` contém informações sobre os clientes que fazem pedidos.
- **id** (PK): Identificador único do cliente.
- **name**: Nome completo do cliente.
- **email**: Endereço de e-mail do cliente.
- **cpf**: CPF do cliente (utilizado para identificação única).

### **orders**
A tabela `orders` armazena informações sobre os pedidos realizados pelos clientes.
- **id** (PK): Identificador único do pedido.
- **timestamp**: Data e hora em que o pedido foi realizado.
- **client_id** (FK): Identificador do cliente que fez o pedido.
- **total**: Valor total do pedido.
- **status**: Status atual do pedido (ex.: "em preparo", "pronto", "entregue").

### **orders_products**
A tabela `orders_products` é uma tabela de relacionamento, usada para associar produtos a pedidos.
- **order_id** (PK, FK): Identificador do pedido.
- **product_id** (PK, FK): Identificador do produto.

### **products**
A tabela `products` armazena informações sobre os produtos disponíveis para venda.
- **id** (PK): Identificador único do produto.
- **name**: Nome do produto.
- **category_id** (FK): Identificador da categoria à qual o produto pertence.
- **price**: Preço do produto.
- **description**: Descrição do produto.

## 2. Relacionamentos

- **orders_products**: A tabela de relacionamento `orders_products` conecta os produtos aos pedidos, permitindo que um pedido tenha vários produtos e um produto possa estar em vários pedidos.  
  - `order_id` -> `orders.id`
  - `product_id` -> `products.id`

- **products**: Cada produto pertence a uma categoria específica.  
  - `category_id` -> `categories.id`

## 3. Justificativa da Escolha do Banco de Dados

O banco de dados escolhido foi o **PostgreSQL** devido às suas seguintes características:
- **Suporte a Relacionamentos**: O PostgreSQL oferece um excelente suporte para relacionamentos entre tabelas, como mostrado no modelo de dados com as chaves estrangeiras.
- **Consistência**: Como um banco de dados relacional, o PostgreSQL garante integridade referencial, o que assegura que os dados entre as tabelas relacionadas estejam consistentes.
- **Escalabilidade**: Embora seja um banco de dados relacional, o PostgreSQL pode lidar com grandes volumes de dados e complexas operações de leitura e escrita, o que é ideal para um sistema de pedidos e entregas que pode crescer com o tempo.
- **Suporte a Tipos de Dados Avançados**: O PostgreSQL oferece suporte a tipos de dados avançados, como `DECIMAL` para valores monetários, o que é adequado para armazenar valores de pedidos de forma precisa.

## 4. Observações Finais

- **Tipos de Dados**: Todos os tipos de dados foram escolhidos para garantir o melhor desempenho e precisão. Por exemplo, o tipo `DECIMAL` foi usado para valores monetários (preço e total de pedidos) e `TIMESTAMP` para armazenar a data e hora dos pedidos.
- **Normalização**: O modelo segue os princípios de normalização, evitando redundâncias e garantindo que os dados sejam armazenados de maneira eficiente.

