# 💡 100 ideias pro client (brainstorm)

## 🎯 Próxima tarefa (detalhada) — sinalizador de direções da bola

Feature específica pedida, com mockup desenhado pelo usuário confirmando o visual:
um "asterisco" de 8 linhas (4 retas + 4 diagonais) saindo do centro de onde a bola
está, acompanhando ela em tempo real conforme se move pelo campo.

**Por que é aceitável** (já discutido e decidido): a bola já é visível a todo mundo
na sala; isso só destaca visualmente uma informação já pública, não automatiza
nenhuma ação nem esconde nada dos outros jogadores. O jogador ainda precisa se
mover manualmente/no timing certo — a habilidade continua sendo dele.

**Por que não é trivial:**
- `RoomObjectHighLighter` (o sistema de destaque que `:autoclick`/`:totem` já usam)
  só aplica filtro de cor/glow **no próprio objeto** — não desenha nada no chão.
- Não achei nenhuma classe do client expondo `TileCursor.swf`/`SelectionArrow.swf`
  de forma reutilizável pra desenhar tiles arbitrários.

**Abordagem técnica provável:**
1. Identificar o furni da bola (por clique do usuário, tipo `:totem` faz com
   `LatestClickedFurnitureID`, ou por nome do furni tipo `:spawn` já filtra)
2. Ler a posição dela a cada tick de um `Timer` novo (reusar `GetFurnitureLocation`
   que já existe em `LilithCustoms.as`)
3. Calcular as 8 coordenadas de tile ao redor (4 retas + 4 diagonais), respeitando
   limites da sala
4. Spawnar/mover mobílias falsas invisíveis nesses tiles (mesma técnica do
   `:spawn`, via `addObjectFurnitureByName` + `EmptyStuffData`) — ou trocar de
   cor/style pra ficar visível mas discreto ("bem fraco destacado" foi o pedido)
5. Limpar os marcadores ao desligar o comando ou trocar de sala (igual
   `OnRoomEnter` já limpa outros estados)

Comando sugerido: `:bolagrid` ou `:trackball` (nome final em aberto).

**Atualização:** `:bolagrid` já existe numa v1 (destaca só a bola com glow vermelho
forte, via `RoomObjectHighLighter.addFiltersToFurni` customizado — não precisa de
nome de mobília). Funciona: clica na bola ("Bola da Final"), digita `:bolagrid`.

Falta a v2 (as 8 linhas de verdade nos tiles, 4 retas + 4 diagonais, ver mockup do
usuário). Duas rotas investigadas pra isso:

1. **Spawnar mobília falsa nos 8 tiles** (via `addObjectFurnitureByName`, mesma
   técnica do `:spawn`) — precisa do identificador interno (classname) de uma
   mobília fina/pequena. Candidato do usuário: **"Blocão 13"** (nome de exibição
   na loja/catálogo — ainda falta o classname real, tipo algo que apareça em
   `furnidata`. Não tem como eu adivinhar isso só pelo nome de exibição.)
2. **Cursor de tile nativo** (`com.sulake.habbo.room.object.logic.room.RoomTileCursorLogic`
   / `TileCursorVisualization`, exposto via `IRoomEngine.setTileCursorState(roomId,state)`
   e `toggleTileCursorVisibility(roomId,visible)`) — **descartado**: é um cursor
   único, atrelado ao hover do mouse, não dá pra ter 8 instâncias simultâneas em
   posições fixas sem mexer mais fundo no motor da sala (fora do escopo seguro
   pra uma sessão corrida).

**Próximo passo sugerido:** usar o `:spawn [nome]` que já existe no client pra o
usuário testar candidatos de nome direto no jogo (ele já aceita qualquer nome de
mobília digitado) — assim a gente descobre o classname certo sem eu ter que
adivinhar código nenhum.


Lista de ideias — nenhuma delas envolve vantagem de velocidade/movimento contra outros
jogadores (aquele limite que já ficou combinado). Tudo aqui é cosmético, conveniência,
ou automação de coisas que você já faz manualmente, no mesmo nível de coisas como
`:autoclick` ou `:seasonal` que a AirPlus já tem oficialmente.

⭐ = também está na lista de **Top 15** (as que eu acho mais boas/matadoras).

## `:vip` e `:mandiocafrita`

1. ⭐ `:vip` muda cor da janela pra dourado/roxo enquanto ativo
2. `:vip` toca som exclusivo ao ativar/desativar
3. ⭐ `:vip` troca automaticamente pro look salvo "VIP"
4. `:vip` mostra cronômetro de quanto tempo está ativo
5. `:vip` avisa quando você entra numa sala nova
6. ⭐ `:mandiocafrita` solta piada de comida aleatória a cada X min
7. `:mandiocafrita` ativa expressão de riso (`:laugh`) ao ligar
8. `:mandiocafrita` muda tema visual pra tons de fritura
9. Renomear `:mandiocafrita` pra `:chef` (ou manter, com efeito novo)
10. ⭐ Comando `:status` — mostra quais dos seus modos (VIP/Mandioca/PetFala) estão ativos

## AutoClick / Automação de móveis

11. ⭐ `:autoclick` parar sozinho após N cliques definidos
12. `:autoclick` retomar sozinho ao trocar de sala
13. ⭐ Salvar conjuntos de móveis pro autoclick (`:saveclick`/`:useclick`)
14. Indicador visual mostrando quantos cliques já foram dados
15. Som de "ding" a cada X cliques do autoclick
16. `:autoclick` com delay levemente variável dentro do piso de 100ms
17. Lista de todos os "conjuntos de clique" salvos (`:showclicks`)
18. Autoclick pausar sozinho se a sala ficar sem ninguém
19. Aviso quando o item clicado no autoclick não existe mais
20. Atalho de teclado pra ligar/desligar autoclick rapidinho

## Amigos & Notificações

21. Som customizado por amigo específico ao entrar online
22. ⭐ Investigar/corrigir bug da lista de amigos aparecendo cortada
23. Contador de quantos amigos estão online agora (`:friendsonline`)
24. Notificação quando um amigo específico entra na sala que você está
25. Cor diferente no nome de amigos favoritos no chat
26. Alerta quando alguém te remove dos favoritos (se detectável)
27. Lista de aniversários de amigos salvos manualmente
28. Comando pra "favoritar" silenciosamente sem eles saberem
29. Histórico de quando cada amigo ficou online/offline (log local)
30. Resumo diário de atividade dos amigos ao abrir o client

## Pets

31. ⭐ `:petfala` com mais variações de mensagem
32. `:petfala` gated só pra sua conta
33. ⭐ `:petfaladelay` pra ajustar o intervalo (30s, 1min, etc)
34. Log local de tudo que o `:petfala` já disse
35. Comando que mostra fome/sede dos pets na sala
36. Aviso quando um pet está com fome baixa
37. `:petfala` variando conforme o pet mais próximo de você
38. Mensagens de aniversário automáticas pro pet
39. Contador de quantos pets você tem na sala
40. Modo "pets falam entre si" — mensagens alternadas tipo diálogo

## Visual do Client

41. ⭐ Tema de cores automático por hora do dia (manhã/tarde/noite)
42. Tema sazonal manual (verão, inverno, halloween) via comando
43. Barra inferior com gradiente customizado
44. Ícone da janela personalizado
45. ⭐ Tela de login com imagem de fundo sua
46. Fonte do chat customizada (se suportado)
47. Cursor do mouse customizado dentro da sala
48. Efeito de partículas na barra de título
49. Modo escuro pras janelas de UI (catálogo, inventário)
50. Splash screen personalizada ao abrir o client

## Chat & Comunicação

51. ⭐ Histórico de chat exportável pra arquivo `.txt`
52. Tradução automática de mensagens
53. Filtro de palavras customizado (esconder certas palavras no chat)
54. Emojis customizados via atalho de texto
55. Chat com timestamp em cada mensagem
56. Busca dentro do histórico de chat da sessão
57. Marcar mensagens importantes pra achar depois
58. Modo "não perturbe" — silencia sussurros temporariamente
59. Contador de quantas mensagens você mandou na sessão
60. Auto-resposta quando você está "away"

## Looks & Guarda-roupa

61. Mais categorias no guarda-roupa local
62. Preview rápido de um look salvo sem trocar de verdade
63. Nomear looks salvos com emoji/categoria
64. ⭐ Sorteio aleatório entre seus looks salvos (`:randomlook`)
65. Agendar troca de look automática por hora do dia
66. Comparar dois looks salvos lado a lado
67. Exportar/importar looks salvos entre PCs (arquivo)
68. Favoritar looks mais usados
69. Estatística de qual look você mais usa
70. Atalho de teclado pra alternar entre 2 looks rapidinho

## Sala & Câmera

71. Salvar posições de câmera favoritas por sala
72. Zoom automático ao entrar em salas grandes
73. Modo cinematográfico (câmera lenta ao girar)
74. ⭐ Atalho pra tirar screenshot da sala direto
75. Grade de referência visual pra decorar (toggle)
76. Marca d'água customizada em screenshots
77. Modo "tour" — câmera percorre a sala sozinha (visual, sem mover avatar)
78. Salvar rotas de câmera favoritas
79. Indicador de tamanho da sala (WxH) na tela
80. Atalho pra centralizar câmera no seu avatar

## Informação & Utilidade

81. Relógio/hora atual na tela (overlay)
82. ⭐ Contador de tempo de sessão (quanto tempo você está online)
83. Painel com resumo dos seus comandos ativos
84. ⭐ Aviso de quando o client está há muito tempo aberto (lembrete de pausa)
85. Calculadora de créditos/moedas rápida
86. Nota rápida (post-it) fixada na tela do client
87. Lembrete configurável (tipo alarme) que soa depois de X minutos
88. Exportar suas configurações completas num só clique
89. Painel de "changelog" mostrando o que mudou na última recompilação
90. Atalho pra abrir o `:commands` sem digitar

## Diversão / Roleplay / Easter eggs

91. Frase aleatória ao entrar no hotel
92. ⭐ Easter egg secreto em data especial (seu aniversário, etc)
93. `:sorte` — mensagem de "sorte do dia" aleatória
94. Emote exclusivo seu (combinação de fx + expressão)
95. Assinatura customizada no final de mensagens longas
96. Piadas aleatórias com `:piada`
97. Contador de "boas ações" (RP, tipo respeitos dados)
98. Frase de efeito ao sair do hotel
99. Avatar "comemora" sozinho quando você atinge uma meta (ex: X dias de conta)
100. Modo "história" — narra em terceira pessoa o que você está fazendo (RP)
