// ==========================================
// SCRIPT DE CARGA DE DADOS - NEO4J
// Projeto: Modelagem em Grafos de um Serviço de Streaming
// ==========================================

// 1. Limpeza do banco de dados (Opcional, para testes)
// IMPORTANTE: Remove todos os nós e relacionamentos existentes para evitar duplicidade.
MATCH (n) DETACH DELETE n;

// ==========================================
// 2. CRIAÇÃO DOS NÓS
// ==========================================

// --- Nós de Gêneros ---
CREATE (g1:Gênero {id: 1, nome: "Ficção Científica", descrição: "Filmes e séries com tecnologia futurista, espaço ou viagens no tempo"})
CREATE (g2:Gênero {id: 2, nome: "Drama", descrição: "Foco no desenvolvimento aprofundado de personagens e conflitos emocionais"})
CREATE (g3:Gênero {id: 3, nome: "Ação", descrição: "Filmes com muita adrenalina, perseguições e combates"})
CREATE (g4:Gênero {id: 4, nome: "Suspense", descrição: "Histórias tensas com mistérios a serem desvendados"});

// --- Nós de Atores ---
CREATE (a1:Ator {id: 101, nome: "Keanu Reeves", nacionalidade: "Libanês/Canadense"})
CREATE (a2:Ator {id: 102, nome: "Leonardo DiCaprio", nacionalidade: "Norte-americano"})
CREATE (a3:Ator {id: 103, nome: "Millie Bobby Brown", nacionalidade: "Britânica"})
CREATE (a4:Ator {id: 104, nome: "Bryan Cranston", nacionalidade: "Norte-americano"})
CREATE (a5:Ator {id: 105, nome: "Carrie-Anne Moss", nacionalidade: "Canadense"});

// --- Nós de Diretores (Mapeado exatamente como "Dirctor" do rascunho) ---
CREATE (d1:Dirctor {id: 201, nome: "Lana Wachowski", nacionalidade: "Norte-americano"})
CREATE (d2:Dirctor {id: 202, nome: "Christopher Nolan", nacionalidade: "Britânico/Norte-americano"})
CREATE (d3:Dirctor {id: 203, nome: "Vince Gilligan", nacionalidade: "Norte-americano"});

// --- Nós de Filmes ---
CREATE (f1:Filmes {id: 301, nome: "Matrix", ano_lançamento: 1999, duração_tempo: 136, idioma: "Inglês"})
CREATE (f2:Filmes {id: 302, nome: "A Origem", ano_lançamento: 2010, duração_tempo: 148, idioma: "Inglês"})
CREATE (f3:Filmes {id: 303, nome: "Interestelar", ano_lançamento: 2014, duração_tempo: 169, idioma: "Inglês"});

// --- Nós de Séries ---
CREATE (s1:Séries {id: 401, nome: "Breaking Bad", ano_lançamento: 2008, duração_tempo: 47, idioma: "Inglês"})
CREATE (s2:Séries {id: 402, nome: "Stranger Things", ano_lançamento: 2016, duração_tempo: 50, idioma: "Inglês"});

// --- Nós de Usuários (Mapeado com os atributos 'e-mai' e 'data_nacimento' do rascunho) ---
CREATE (u1:Usuários {id: 501, nome: "Alice Souza", `e-mai`: "alice@email.com", data_nacimento: "1994-05-12"})
CREATE (u2:Usuários {id: 502, nome: "Bruno Lima", `e-mai`: "bruno@email.com", data_nacimento: "1988-11-23"})
CREATE (u3:Usuários {id: 503, nome: "Carla Mendes", `e-mai`: "carla@email.com", data_nacimento: "2001-07-05"});


// ==========================================
// 3. CRIAÇÃO DOS RELACIONAMENTOS
// ==========================================

// --- Relação Filmes -[Atuo]-> Ator ---
// Nota: De acordo com o diagrama, a relação aponta do Filme para o Ator com o nome "Atuo".
MATCH (f:Filmes {id: 301}), (a:Ator {id: 101}) CREATE (f)-[:Atuo]->(a);
MATCH (f:Filmes {id: 301}), (a:Ator {id: 105}) CREATE (f)-[:Atuo]->(a);
MATCH (f:Filmes {id: 302}), (a:Ator {id: 102}) CREATE (f)-[:Atuo]->(a);
MATCH (f:Filmes {id: 303}), (a:Ator {id: 102}) CREATE (f)-[:Atuo]->(a);

// --- Relação Séries -[Dirigiu]-> Dirctor ---
// Nota: De acordo com o diagrama, a relação aponta de Séries para o Dirctor com o nome "Dirigiu".
MATCH (s:Séries {id: 401}), (d:Dirctor {id: 203}) CREATE (s)-[:Dirigiu]->(d);
MATCH (s:Séries {id: 402}), (d:Dirctor {id: 202}) CREATE (s)-[:Dirigiu]->(d); // Exemplo fictício para fins de teste de relacionamento

// --- Relação Filmes/Séries -> Gênero ---
// Nota: O diagrama não define rótulo para esta relação, mas grafos no Neo4j exigem um nome. Usamos "PERTENCE_A".
MATCH (f:Filmes {id: 301}), (g:Gênero {id: 1}) CREATE (f)-[:PERTENCE_A]->(g); // Matrix -> Sci-Fi
MATCH (f:Filmes {id: 302}), (g:Gênero {id: 1}) CREATE (f)-[:PERTENCE_A]->(g); // A Origem -> Sci-Fi
MATCH (f:Filmes {id: 302}), (g:Gênero {id: 4}) CREATE (f)-[:PERTENCE_A]->(g); // A Origem -> Suspense
MATCH (f:Filmes {id: 303}), (g:Gênero {id: 1}) CREATE (f)-[:PERTENCE_A]->(g); // Interestelar -> Sci-Fi
MATCH (f:Filmes {id: 303}), (g:Gênero {id: 2}) CREATE (f)-[:PERTENCE_A]->(g); // Interestelar -> Drama
MATCH (s:Séries {id: 401}), (g:Gênero {id: 2}) CREATE (s)-[:PERTENCE_A]->(g); // Breaking Bad -> Drama
MATCH (s:Séries {id: 401}), (g:Gênero {id: 4}) CREATE (s)-[:PERTENCE_A]->(g); // Breaking Bad -> Suspense
MATCH (s:Séries {id: 402}), (g:Gênero {id: 1}) CREATE (s)-[:PERTENCE_A]->(g); // Stranger Things -> Sci-Fi
MATCH (s:Séries {id: 402}), (g:Gênero {id: 4}) CREATE (s)-[:PERTENCE_A]->(g); // Stranger Things -> Suspense

// --- Relação Usuários -[WATCHED]-> Filmes e Séries ---
// Nota: Relação aponta do Usuário para o conteúdo.
MATCH (u:Usuários {id: 501}), (f:Filmes {id: 301}) CREATE (u)-[:WATCHED]->(f);
MATCH (u:Usuários {id: 501}), (s:Séries {id: 402}) CREATE (u)-[:WATCHED]->(s);
MATCH (u:Usuários {id: 502}), (f:Filmes {id: 301}) CREATE (u)-[:WATCHED]->(f);
MATCH (u:Usuários {id: 502}), (f:Filmes {id: 302}) CREATE (u)-[:WATCHED]->(f);
MATCH (u:Usuários {id: 502}), (s:Séries {id: 401}) CREATE (u)-[:WATCHED]->(s);
MATCH (u:Usuários {id: 503}), (f:Filmes {id: 303}) CREATE (u)-[:WATCHED]->(f);
MATCH (u:Usuários {id: 503}), (s:Séries {id: 402}) CREATE (u)-[:WATCHED]->(s);
