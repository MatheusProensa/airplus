# 🛩️ airplus — client customizado pessoal

> Projeto pessoal em cima do [HabboAirPlus](https://github.com/LilithRainbows/HabboAirPlus).
> Repo **privado**. Uso pessoal. Sem servidor privado — conecta no Habbo oficial de sempre.

---

## ⚠️ Por que é privado

- O `.swf` original e a árvore decompilada (`HabboAir_src/`) são código da **Sulake** (dono do Habbo).
- Publicar isso **público** = risco real de DMCA/copyright na sua conta.
- Por isso o repo ficou **privado**. Não torne público sem pensar de novo nisso.

---

## 📁 O que tem aqui

| Pasta/arquivo | O que é |
|---|---|
| `HabboAir_src/` | Código decompilado inteiro (ActionScript, ~8600 classes) |
| `HabboAir_custom.swf` | O client já compilado com suas mudanças |
| `HabboAir_src.zip` | Backup zipado do source |
| `patches/` | Diffs pequenos de cada mudança sua (fácil de revisar) |
| `docs/SETUP.md` | Como preparar o ambiente (JPEXS, VS Code, extensão AS3) |
| `docs/COMMANDS.md` | Como funcionam os comandos de chat (`:playing`, `:dance`...) |
| `docs/BUILD.md` | Passo a passo: decompilar → editar → recompilar |
| `tools/` | Scripts que automatizam decompilação/recompilação |

---

## 🚀 Prático (downloads + versões)

**Base usada (projeto original, não é meu):** [LilithRainbows/HabboAirPlus](https://github.com/LilithRainbows/HabboAirPlus)

| Preciso de... | Link |
|---|---|
| ⬇️ Baixar o client base (antes das minhas mudanças) | [Releases do HabboAirPlus](https://github.com/LilithRainbows/HabboAirPlus/releases/latest) |
| ⬇️ Baixar meu `.swf` já customizado | [`HabboAir_custom.swf`](HabboAir_custom.swf) (está aqui neste repo) |
| 🚀 Launcher alternativo (Win/Linux/Mac) | [HabboCustomLauncher](https://github.com/LilithRainbows/HabboCustomLauncher/releases/tag/latest) |
| 🔧 Decompilador pra editar `.as` | [JPEXS](https://github.com/jindrapetrik/jpexs-decompiler/releases/latest) |

**Versões atuais:**

| Item | Valor |
|---|---|
| Client version | `WIN63-202607011411-782849652` |
| AIR SWF version | `51` |
| JPEXS version | `22.0.2` |

**Comandos em destaque** (lista completa dos ~100 comandos herdados do AirPlus está no [README original](https://github.com/LilithRainbows/HabboAirPlus); a lógica interna deles está documentada em `docs/COMMANDS.md`):

- `:commands` — mostra a lista inteira dentro do próprio client
- `:dance [0-4]` `:playing` `:afk` `:clone` — os mais usados no dia a dia
- `:mandiocafrita` e `:vip` — **os meus**, exclusivos pra minha conta (ver seção abaixo)

---

## 🎮 Suas customizações

- **`:mandiocafrita`** — comando exclusivo, só pra sua conta, não afeta outros jogadores.
- **`:vip`** — comando exclusivo, mesma ideia do `:mandiocafrita` (mensagem própria).
- Código principal: [`LilithCustoms.as`](HabboAir_src/HabboAir_src/scripts/com/sulake/habbo/window/LilithCustoms.as)

---

## ✅ Resumo rápido

1. Isso é só client-side (visual/comandos), não mexe em servidor nem protocolo.
2. Conecta no Habbo oficial via SSO do site, igual sempre foi.
3. Repo privado → pode ter tudo aqui dentro sem risco.
4. Precisa recompilar? Veja `docs/BUILD.md`.
