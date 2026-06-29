// ==========================================
// QUERIES DE NEGÓCIO EM CYPHER
// Projeto: Modelagem em Grafos de um Serviço de Streaming
// ==========================================

// --- PERGUNTA DE NEGÓCIO 1: Histórico de Consumo ---
// Objetivo: Listar todos os conteúdos (filmes e séries) assistidos por um usuário específico.
// Pergunta: "O que a Alice Souza assistiu na plataforma?"
MATCH (u:Usuários {nome: "Alice Souza"})-[r:WATCHED]->(conteudo)
RETURN u.nome AS Usuario, labels(conteudo)[0] AS Tipo, conteudo.nome AS NomeConteudo, conteudo.idioma AS Idioma;


// --- PERGUNTA DE NEGÓCIO 2: Detalhes do Conteúdo (Elenco e Direção) ---
// Objetivo: Listar a ficha técnica (atores de filmes e diretores de séries) dos conteúdos.
// Pergunta A: "Quais atores atuaram no filme 'Matrix'?"
MATCH (f:Filmes {nome: "Matrix"})-[r:Atuo]->(a:Ator)
RETURN f.nome AS Filme, a.nome AS Ator, a.nacionalidade AS NacionalidadeAtor;

// Pergunta B: "Quem dirigiu a série 'Breaking Bad'?"
MATCH (s:Séries {nome: "Breaking Bad"})-[r:Dirigiu]->(d:Dirctor)
RETURN s.nome AS Serie, d.nome AS Diretor, d.nacionalidade AS NacionalidadeDiretor;


// --- PERGUNTA DE NEGÓCIO 3: Conteúdos por Categoria/Gênero ---
// Objetivo: Buscar todos os filmes e séries associados a um gênero específico.
// Pergunta: "Quais são as produções de 'Ficção Científica'?"
MATCH (conteudo)-[:PERTENCE_A]->(g:Gênero {nome: "Ficção Científica"})
RETURN g.nome AS Genero, labels(conteudo)[0] AS Tipo, conteudo.nome AS Titulo, conteudo.ano_lançamento AS Lancamento;


// --- PERGUNTA DE NEGÓCIO 4: Recomendação por Afinidade (Filtro Colaborativo Simples) ---
// Objetivo: Recomendar conteúdos para um usuário (ex: Bruno) com base nos conteúdos assistidos por outras pessoas que assistiram os mesmos itens que ele.
// Pergunta: "Quem assistiu os mesmos filmes que o Bruno Lima assistiu, o que mais assistiu que o Bruno ainda não assistiu?"
MATCH (u:Usuários {nome: "Bruno Lima"})-[w1:WATCHED]->(f1:Filmes)<-[w2:WATCHED]-(outro:Usuários)
MATCH (outro)-[w3:WATCHED]->(recomendacao:Filmes)
WHERE NOT (u)-[:WATCHED]->(recomendacao) AND recomendacao <> f1
RETURN DISTINCT recomendacao.nome AS FilmeRecomendado, recomendacao.ano_lançamento AS Ano, recomendacao.idioma AS Idioma
LIMIT 5;


// --- PERGUNTA DE NEGÓCIO 5: Ranking de Popularidade ---
// Objetivo: Encontrar os conteúdos mais populares (com maior número de visualizações) na plataforma.
// Pergunta: "Quais são os filmes e séries mais assistidos?"
MATCH (u:Usuários)-[:WATCHED]->(conteudo)
RETURN labels(conteudo)[0] AS Tipo, conteudo.nome AS Titulo, count(u) AS TotalVisualizacoes
ORDER BY TotalVisualizacoes DESC;


// --- EVIDÊNCIA VISUAL: Visualização do Esquema ---
// Objetivo: Mostrar a modelagem de grafos ativa no banco de dados.
// Comando: Execute a consulta abaixo no console do Neo4j para ver o grafo de esquema.
CALL db.schema.visualization();
