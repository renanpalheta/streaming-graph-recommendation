# Modelagem de Dados em Grafos para Serviço de Streaming com Neo4j

Este repositório contém o desafio de projeto desenvolvido para o Bootcamp da [DIO](https://dio.me) sobre **Neo4j - Análise de Dados com Grafos**. O objetivo principal é modelar e implementar o banco de dados orientado a grafos de uma plataforma de streaming, simulando usuários, conteúdos (filmes e séries), gêneros, atores e diretores.

---

## 🔍 Contexto do Problema & Justificativa de Grafos

Serviços de streaming modernos dependem massivamente de relacionamentos entre dados. Recomendar um filme, encontrar conteúdos de um mesmo gênero ou identificar padrões de comportamento de usuários exige percorrer conexões complexas rapidamente.

### Por que usar bancos de dados orientados a grafos (Neo4j)?
* **Desempenho em Consultas Conectadas (*Index-free Adjacency*):** Em bancos relacionais (SQL), buscar recomendações baseadas no histórico de amigos ou gêneros parecidos exige múltiplos `JOINs` custosos. No Neo4j, o relacionamento é físico (um ponteiro direto), tornando as travessias no grafo extremamente rápidas, independente do volume total de dados.
* **Flexibilidade de Esquema:** Novos tipos de conteúdos, formas de interações ou atributos podem ser adicionados sem a necessidade de migrações complexas de tabelas (*no migrations*).
* **Consultas Intuitivas com Cypher:** A linguagem de consulta Cypher foi desenhada para representar padrões visuais no grafo (ex: `(u:Usuário)-[:WATCHED]->(f:Filme)`), facilitando o desenvolvimento de regras de negócio de recomendação.

---

## 📐 Modelo do Grafo

A modelagem segue a estrutura conceitual do projeto, estruturando os seguintes componentes:

### 1. Nós (Labels) e Propriedades
* **`Usuários`**: `id`, `nome`, `e-mai`, `data_nacimento` *(mapeados conforme especificação)*.
* **`Filmes`**: `id`, `nome`, `ano_lançamento`, `duração_tempo`, `idioma`.
* **`Séries`**: `id`, `nome`, `ano_lançamento`, `duração_tempo`, `idioma`.
* **`Gênero`**: `id`, `nome`, `descrição`.
* **`Ator`**: `id`, `nome`, `nacionalidade`.
* **`Dirctor`**: `id`, `nome`, `nacionalidade` *(mapeado conforme especificação)*.

### 2. Relacionamentos (Relationships)
* **`WATCHED`**: Conecta `Usuários` aos `Filmes` ou `Séries` assistidos (Usuários -> Conteúdo).
* **`Atuo`**: Conecta `Filmes` aos seus respectivos `Ator` (Filmes -> Ator).
* **`Dirigiu`**: Conecta `Séries` aos seus respectivos `Dirctor` (Séries -> Dirctor).
* **`PERTENCE_A`**: Conecta `Filmes` ou `Séries` ao seu `Gênero` correspondente (Conteúdo -> Gênero).

> [!TIP]
> **Adicione sua Imagem de Modelagem:**
> Para deixar o repositório completo, salve a imagem da sua modelagem no diretório do projeto como `modelagem.png` (ou na pasta `images/`) e descomente/ajuste a linha abaixo no seu README:
> <!-- ![Modelagem do Grafo](./modelagem.png) -->

---

## 🛠️ Como Executar o Projeto

Você pode rodar as consultas do projeto utilizando o **Neo4j Browser** localmente ou em nuvem por meio do **Neo4j AuraDB** (instância gratuita).

### Passo 1: Configuração do Banco e Carga de Dados
1. Abra o painel do seu banco Neo4j.
2. Copie e cole todo o conteúdo do arquivo [`setup_database.cypher`](./setup_database.cypher) no console de queries do Neo4j.
3. Execute o script. Ele irá limpar o banco de dados de testes e criar todos os nós e conexões do modelo.

### Passo 2: Executando as Consultas de Negócio
Com o banco populado, você pode rodar os exemplos do arquivo [`business_queries.cypher`](./business_queries.cypher) para testar e ver as travessias no grafo funcionando.

---

## 📊 Perguntas de Negócio Respondidas

No arquivo [`business_queries.cypher`](./business_queries.cypher), foram estruturadas queries para responder a cenários reais de análise de dados do serviço de streaming:

1. **Histórico de Consumo:** Quais conteúdos específicos foram assistidos por um usuário?
2. **Ficha Técnica:** Quem dirigiu uma série específica e quais atores atuaram em um filme?
3. **Filtro de Categoria:** Quais filmes e séries pertencem a um gênero específico?
4. **Recomendação Colaborativa:** Quais filmes são indicados para um usuário com base no que pessoas com gostos semelhantes assistiram?
5. **Ranking de Popularidade:** Quais são as produções mais consumidas da plataforma?

*(Dica: Após rodar as consultas no Neo4j, tire prints dos grafos resultantes e insira aqui para comprovar visualmente os resultados de negócio!)*

---

## 🤕 Cicatrizes do Projeto (Troubleshooting & Aprendizados)

O mercado valoriza desenvolvedores que sabem diagnosticar e contornar desafios do mundo real. Abaixo estão listadas as principais decisões técnicas tomadas durante a execução do projeto:

* **Caracteres Especiais e Hifens em Propriedades (Cypher syntax):**
  * **Problema:** A modelagem especificou a propriedade de e-mail do usuário como `e-mai` e a data de nascimento como `data_nacimento`. Além de conterem pequenos erros ortográficos, a presença de hifens em propriedades (como `e-mai`) causa erro de sintaxe direta em Cypher.
  * **Resolução:** Para resolver isso e manter a conformidade fiel com o desafio, foi necessário utilizar a marcação de crase (backticks) ao referenciar a propriedade: `` `e-mai` ``. Isso força o motor de execução do Neo4j a tratar a propriedade como string literal.
* **Relacionamentos sem Nome Definido:**
  * **Problema:** No diagrama conceitual, as setas direcionadas dos conteúdos (`Filmes` e `Séries`) para o nó de `Gênero` não tinham uma ação ou nome de relacionamento (estavam em branco).
  * **Resolução:** No Neo4j, todo relacionamento obrigatoriamente precisa ter um tipo/nome de rótulo. A fim de manter a semântica do domínio, foi adotado o rótulo `PERTENCE_A` para mapear essas conexões.
* **Direcionalidade das Relações:**
  * **Problema:** A relação de atuação aponta de `Filmes` para `Ator` (`Atuo`) e a de direção aponta de `Séries` para `Dirctor` (`Dirigiu`). 
  * **Resolução:** Embora no mundo real o ator seja o agente da ação de atuar, respeitamos a direção exata das setas do diagrama na criação das queries. Na hora de consumir os dados em consultas reais de negócio, contornamos isso utilizando a flexibilidade de direcionamento do Cypher (`<-` ou `->`) para realizar buscas bidirecionais eficientes.