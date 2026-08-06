# Fluxo de decompilação → edição → recompilação

## Por que JPEXS e não mxmlc/Apache Flex SDK puro

Dava pra imaginar recompilar isso do zero com `mxmlc` (Apache Flex SDK / Royale), mas na prática é inviável
aqui:

- O `.swf` embute milhares de assets (imagens, fontes, sons, símbolos, XMLs) que não têm projeto-fonte
  `.fla`/`.mxml` correspondente — só existem dentro do `.swf` compilado.
- Reconstruir o `Main`/application descriptor, referências de símbolo↔classe (`SymbolClass`), ordem de
  frames etc. exigiria recriar manualmente centenas de vínculos que hoje só existem como metadata interna do
  SWF.
- É um app **AIR** (não SWF puro de browser) — precisaria também do AIR SDK, certificado de assinatura, e
  descriptor `.xml` do app pra empacotar de novo como executável, e nada disso está disponível a partir do
  `.swf` sozinho.

**A abordagem viável é editar in-place**: o JPEXS decompila cada classe ActionScript pra `.as` legível, você
edita só as classes que quer mudar, e o próprio JPEXS **recompila essas classes de volta pro bytecode (AVM2)
e grava um novo `.swf`** — mantendo todos os outros milhares de tags/assets intactos. Isso é exatamente o que
o `-importScript` da CLI do JPEXS faz (a mesma função do botão "Save" quando você edita uma classe pela GUI).

## Passo a passo (Windows, PowerShell)

Pressupõe JPEXS em `C:\ffdec\` (ver `docs/SETUP.md`) e o `HabboAir.swf` original baixado do release do
HabboAirPlus em algum lugar local, ex. `C:\airplus-local\HabboAir.swf`.

### 1. Decompilar (gera a árvore `.as` completa)

```powershell
cd C:\ffdec
java -Xmx4g -jar ffdec.jar -onerror ignore -export script `
  C:\airplus-local\HabboAir_src `
  C:\airplus-local\HabboAir.swf
```

Leva uns 10-15 minutos (são ~8600 classes). Script pronto: `tools/decompile.ps1`.

### 2. Editar

Abra `C:\airplus-local\HabboAir_src` no VS Code e edite as classes que quiser (comece por
`scripts/com/sulake/habbo/window/LilithCustoms.as`, ver `docs/COMMANDS.md`).

Depois de cada mudança, gere um diff pra guardar no `patches/` deste repo (não precisa commitar a árvore
inteira, só o diff):

```powershell
# a partir de uma cópia "limpa" da mesma classe re-exportada do .swf original
diff -u LilithCustoms.as.orig LilithCustoms.as > patches\00X-nome-da-mudanca.diff
```
(No Windows sem `diff`, use `git diff --no-index arquivo_original arquivo_editado`, ou o comparador de
arquivos embutido do VS Code.)

### 3. Recompilar

Só precisa apontar pra pasta com a(s) classe(s) editada(s) — não precisa reimportar as 8600, só as que
mudaram. Estrutura de pastas deve espelhar o pacote (`scripts/com/sulake/habbo/window/LilithCustoms.as`):

```powershell
cd C:\ffdec
java -Xmx4g -jar ffdec.jar -onerror ignore -air -importScript `
  C:\airplus-local\HabboAir.swf `
  C:\airplus-local\HabboAir_custom.swf `
  C:\airplus-local\import_folder
```

- `-air`: usa `airglobal.swc` em vez de `playerglobal.swc` na compilação (necessário — é um AIR SWF, versão
  51 conforme o `header`).
- `import_folder` deve conter só `scripts\com\sulake\habbo\window\LilithCustoms.as` (ou qualquer subconjunto
  de classes que você editou), na estrutura de pacote certa.

Isso gera `HabboAir_custom.swf` — mesmo tamanho/estrutura do original, só com o bytecode das classes editadas
trocado. Script pronto: `tools/recompile.ps1`.

### 4. Verificar (opcional mas recomendado)

Re-exporte só a classe editada do `.swf` novo e confira se a mudança está lá:

```powershell
java -jar ffdec.jar -selectclass com.sulake.habbo.window.LilithCustoms -export script `
  C:\airplus-local\verify C:\airplus-local\HabboAir_custom.swf
```

### 5. Usar o `.swf` customizado

Troque o `HabboAir.swf` original (dentro da instalação do client AIR, normalmente ao lado do executável) pelo
`HabboAir_custom.swf` — renomeando pra manter o nome esperado pelo wrapper AIR. Conecta no mesmo Habbo Hotel
de sempre, já que nenhuma mudança aqui toca em endpoint/protocolo de rede.

## Erros comuns

- **`Duplicate pack path found (mx.core...)` no log**: warnings pré-existentes do próprio SWF (framework
  Flex/mx embutido), não são causados pelas suas edições e não impedem a recompilação (exit code 0).
- **Timeout/travando numa classe específica**: use `-exportFileTimeout` / `-timeout` na exportação, ou
  `-onerror ignore` pra pular e seguir.
- **Erro de compilação AS3 na importação**: normalmente é sintaxe inválida introduzida na edição, ou algum
  caractere especial/encoding — prefira ASCII puro em strings literais.
