# airplus (client customizado pessoal)

Projeto pessoal de customização do [HabboAirPlus](https://github.com/LilithRainbows/HabboAirPlus), um client
modificado de Habbo (Adobe AIR / ActionScript 3) que roda em cima do client oficial da Sulake — mesmo
protocolo, mesmos servidores, sem servidor privado envolvido.

**Este repositório não contém o código-fonte decompilado da Sulake/Habbo** (nem o `.swf` original nem a árvore
de `.as` gerada pelo JPEXS). Isso é proposital: o próprio HabboAirPlus só distribui o `.swf` compilado, nunca o
source, e publicar ~8600 classes decompiladas de um jogo comercial num repositório público é um risco real de
copyright/DMCA. Aqui só ficam versionadas **as minhas mudanças** (patches) e **as ferramentas** pra reproduzir
tudo localmente.

## Estrutura

- `patches/` — diffs unificados de cada mudança feita em cima do source decompilado original (gerados com
  `diff -u` entre a classe original exportada e a classe editada). Pequenos, revisáveis, e não contêm o arquivo
  inteiro de terceiros.
- `docs/SETUP.md` — como preparar o ambiente (JPEXS, VS Code, extensão AS3) no Windows.
- `docs/COMMANDS.md` — como o AirPlus implementa os comandos de chat (`:playing`, `:dance`, etc.) e como
  adicionar os seus.
- `docs/BUILD.md` — fluxo de decompilação → edição → recompilação para gerar seu `.swf` customizado.
- `tools/` — scripts (PowerShell/bash) que automatizam a decompilação e a recompilação via JPEXS CLI.
- `.vscode/` — configuração recomendada do editor (extensão de syntax highlight para AS3/MXML).

## Uso pretendido

Uso pessoal apenas. O `.swf` gerado conecta no mesmo Habbo Hotel oficial que o client vanilla/AirPlus já
conecta (via SSO ticket do site, igual sempre foi) — nenhuma mudança aqui mexe em servidor ou em protocolo de
rede. As customizações são estritamente client-side: cosméticas, atalhos e comandos de conveniência pessoal.

Comandos exclusivos adicionados (ver `docs/COMMANDS.md` para detalhes e como o gate de usuário funciona):

- `:vip` — comando de prova de conceito, exclusivo à minha conta, sem nenhum efeito sobre outros jogadores.
