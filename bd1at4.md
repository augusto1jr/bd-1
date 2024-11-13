# Normalização de Dados

A normalização de dados é um processo de organização de um banco de dados para reduzir a redundância e melhorar a integridade dos dados. No MySQL, assim como em outros sistemas de gerenciamento de banco de dados, a normalização ajuda a organizar as tabelas e seus relacionamentos para que os dados sejam armazenados de forma eficiente e sem inconsistências. A normalização é dividida em diferentes formas normais, chamadas de "formas normais" (ou "normal forms"), que representam estágios progressivos de organização.


### 1. Primeira Forma Normal (1ª FN)
Para que uma tabela esteja na primeira forma normal, ela deve:

Conter apenas dados atômicos (ou seja, cada célula deve ter um único valor, não listas ou conjuntos de valores).
Não deve ter colunas repetitivas ou grupos de colunas que armazenam valores semelhantes.
Exemplo de como alcançar a 1ª FN: Se temos uma tabela de clientes com múltiplos números de telefone armazenados em uma única coluna, devemos separá-los em registros distintos ou em uma nova tabela.


### 2. Segunda Forma Normal (2ª FN)
Para estar na segunda forma normal, a tabela precisa:

Estar na 1ª FN.
Todas as colunas não chave (colunas que não fazem parte da chave primária) devem depender completamente da chave primária.
Isso significa que, em tabelas com chaves primárias compostas, cada atributo não-chave deve depender de toda a chave, não apenas de uma parte dela.

Exemplo de como alcançar a 2ª FN: Se temos uma tabela Pedido que contém ID_Pedido, ID_Cliente, Nome_Cliente e Data_Pedido, Nome_Cliente não depende diretamente de ID_Pedido, mas sim de ID_Cliente. Nesse caso, movemos o Nome_Cliente para uma tabela separada de Clientes.
```sql
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nome_Cliente VARCHAR(100) NOT NULL
);

CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);
```


### 3. Terceira Forma Normal (3ª FN)
Para estar na terceira forma normal, a tabela deve:

Estar na 2ª FN.
Não ter dependências transitivas (ou seja, as colunas não-chave devem depender apenas da chave primária e não de outra coluna não-chave).
Exemplo de como alcançar a 3ª FN: Se uma tabela de Pedidos contém ID_Pedido, ID_Cliente, Data_Pedido e Cidade_Cliente, o campo Cidade_Cliente depende do ID_Cliente, e não do ID_Pedido. Logo, Cidade_Cliente deveria estar em uma tabela de Clientes.

```sql
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nome_Cliente VARCHAR(100) NOT NULL,
    Cidade_Cliente VARCHAR(100)
);

CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);
```


### Benefícios da Normalização

Redução de redundância: Evita dados duplicados em diferentes partes do banco.
Aumento da integridade dos dados: Facilita a manutenção dos dados sem inconsistências.
Facilidade de atualização e manutenção: Atualizações podem ser feitas em um único local, minimizando a chance de erros.

### Desvantagens da Normalização

Complexidade nas consultas: As consultas podem ficar mais complexas, pois os dados podem estar distribuídos em várias tabelas.
Impacto na performance em alguns casos: Dependendo do banco e do volume de dados, as consultas podem se tornar mais lentas devido aos múltiplos JOINs necessários para recuperar informações.
