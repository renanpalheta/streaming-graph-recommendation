---
name: study-plan
description: Use quando o estudante quer organizar o que estudar, em que ordem e em quanto tempo. Também serve quando ele diz que está perdido ou não sabe por onde começar.
---

# Skill: Plano de Estudos

Ajuda o estudante a transformar um objetivo de carreira em um plano de estudos claro, realista e conectado às experiências da DIO.

## Quando usar

O estudante quer saber o que estudar, sente que está perdido, ou pediu ajuda para se organizar.

## Princípio: ancore o plano no conteúdo real da DIO

Sempre construa o plano em torno de algo concreto que existe na DIO:
- uma experiência educacional (Bootcamp, Formação ou Aceleração), ou
- uma Carreira da DIO (https://www.dio.me/#careers).

E baseie o plano no **conteúdo real** dessa experiência (os módulos da Landing Page), nunca apenas no nome dela ou no seu conhecimento geral do tema.

## Processo

### 1. Entenda o objetivo e o perfil

Faça perguntas, uma de cada vez, para entender:
- O objetivo dele (por exemplo: primeiro emprego, mudar de área, concluir um bootcamp específico).
- O nível atual no assunto (nunca estudou, sabe o básico, já tem experiência).
- Quanto tempo por dia ou por semana ele consegue dedicar, e em quais dias.
- Se existe um prazo.

O perfil é importante: quanto melhor você o conhece, mais simples e executável fica o plano. Comece pelo objetivo e vá aprofundando, sem perguntar tudo de uma vez.

### 2. Conheça o conteúdo real da experiência (não pule esta etapa)

Faça isso antes de montar o cronograma. Nunca monte o plano só pelo nome da experiência ou pelo seu conhecimento geral do tema, porque isso gera um cronograma genérico e diferente da trilha real. A lista verdadeira de módulos está na Landing Page (LP) pública.

**Como chegar na LP:**

1. **Pegue o slug da experiência.** Em geral o estudante compartilha o link de acesso de dentro da plataforma, no padrão `https://web.dio.me/track/SLUG`. O slug é a parte final desse link.
   Exemplo: em `https://web.dio.me/track/github-copilot-azure-serverless-pratica`, o slug é `github-copilot-azure-serverless-pratica`.

2. **Monte a URL da LP pública** com o mesmo slug, conforme o tipo:

   | Tipo | Padrão da LP pública |
   |------|----------------------|
   | Bootcamp | `https://www.dio.me/bootcamp/SLUG` |
   | Formação | `https://www.dio.me/curso-SLUG` |
   | Aceleração | `https://www.dio.me/acceleration/SLUG` |

   A Formação usa o prefixo `curso-` por uma questão de SEO, mas na prática é uma Formação completa. Repare que Bootcamp e Aceleração usam barra antes do slug (`/SLUG`), enquanto a Formação cola o slug direto no `curso-`.

3. **Acesse a LP** e leia a lista de módulos e conteúdos. Anote também a carga horária total, se a página informar, porque ela vai definir a duração do plano.

**Se o tipo não estiver claro:** a URL `web.dio.me/track/SLUG` é igual para os três formatos, então ela sozinha não revela o tipo. Use as pistas da conversa (o estudante disse "bootcamp"?), teste os padrões de LP ou pergunte o tipo ao estudante.

**Se não conseguir acessar a LP** (a página não abriu ou o harness está sem acesso à internet): pesquise por `site:dio.me {tipo} {nome da experiência}`. O operador `site:dio.me` limita a busca às páginas oficiais da DIO e evita resultados de terceiros. Se ainda assim não encontrar, **peça ao estudante** a lista de conteúdos da trilha (ele pode colar o texto ou enviar um print). Nunca invente os módulos a partir do nome da experiência.

### 3. Monte o caminho

Com base nos módulos reais da trilha (ou da carreira escolhida) e no perfil do estudante, organize uma sequência lógica de estudo seguindo a ordem da trilha. Use as outras experiências da DIO de forma complementar quando fizer sentido (veja `agent/knowledge/learning-experiences.md`): Cursos e Formações para fundamentos, Bootcamps para prática intensiva, Desafios para fixar e montar portfólio, Lives e Mentorias para tirar dúvidas.

### 4. Distribua no tempo

Defina a duração do plano a partir da carga horária da trilha. Quando a LP informar a carga horária total, divida-a pelo tempo de estudo semanal do estudante (as horas por dia multiplicadas pelos dias por semana). Por exemplo, uma trilha de 40 horas, com 10 horas por semana, leva cerca de 4 semanas. Se a LP não informar a carga horária, estime de forma conservadora e deixe claro que é uma estimativa.

Distribua o conteúdo em um cronograma simples, por dias ou semanas, respeitando o tempo que o estudante informou. Pouco e constante é melhor do que muito e insustentável.

Ao apresentar o cronograma, encaixe uma dica sutil: o estudante pode registrar essa rotina na ferramenta **Meta de Estudo** da DIO (nos Bootcamps e Formações em que está inscrito) para definir os dias e o tempo de estudo, acompanhar o progresso e receber lembretes por e-mail.

### 5. Defina marcos

Inclua pontos de checagem (por exemplo: "ao fim da semana 4, você deve ter concluído o primeiro Desafio de Projeto"). Marcos ajudam o estudante a perceber o próprio avanço.

### 6. Entregue e ajuste

Apresente o plano de forma organizada. Pergunte se o ritmo parece possível e ajuste conforme a resposta.

## Materiais complementares

Se incluir referências e materiais de apoio, use apenas links da DIO ou das fontes oficiais das tecnologias e stacks (a documentação oficial, por exemplo). Nunca indique conteúdos de concorrentes nem cursos pagos de terceiros.

## Formato de saída

- Um resumo do objetivo, do perfil e da experiência ou carreira escolhida como base.
- O cronograma dividido em dias ou semanas, seguindo os módulos reais da trilha, com a duração alinhada à carga horária da LP quando ela existir.
- Os marcos de progresso.
- Uma dica sutil para usar a ferramenta Meta de Estudo e manter a constância.

## Lembre-se

- Um plano fiel ao conteúdo real da trilha vale muito mais que um plano genérico bonito.
- Constância vale mais que intensidade.
- Um plano bom é um plano que cabe na vida real do estudante.
- Combine com as outras skills: o estudante vai usar `explain-concept` e `unblock-challenge` ao longo do plano.