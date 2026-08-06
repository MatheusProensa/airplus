# Setup (Windows)

## 1. JPEXS Free Flash Decompiler

O HabboAirPlus foi compilado com **JPEXS 22.0.2** (ver `README.txt` do release do HabboAirPlus). Use a mesma
versão para evitar diferenças de deobfuscation/formatação:

1. Baixe `ffdec_22.0.2.zip` em:
   https://github.com/jindrapetrik/jpexs-decompiler/releases/tag/version22.0.2
2. Extraia em, por exemplo, `C:\ffdec\`.
3. Requer Java (JRE/JDK 17+ funciona bem; o instalador do FFDec avisa se faltar). Baixe em
   https://adoptium.net se não tiver.
4. Teste no PowerShell:
   ```powershell
   cd C:\ffdec
   java -jar ffdec.jar -help
   ```
   Se listar os comandos, está pronto. A GUI abre com `ffdec.exe` (ou `ffdec.bat`).

## 2. VS Code

1. Instale a extensão **ActionScript & MXML (as3mxml)** de BowlerHatLLC
   (`BowlerHatLLC.vscode-nextgenas`) — dá syntax highlight, outline de classes, e (se você configurar um SDK
   Flex/Royale) autocomplete e checagem de erros para `.as`. O `.vscode/extensions.json` deste repo já
   recomenda ela automaticamente ao abrir a pasta.
2. Abra a pasta deste repositório no VS Code (`code .`).
3. Abra também, como uma segunda pasta do workspace (`File > Add Folder to Workspace`), a pasta onde você
   gerou a árvore decompilada completa (ver `docs/BUILD.md` — ela fica fora do git, só local).

## 3. Onde fica cada coisa

```
airplus/                    <- este repo (git, público)
  patches/                  <- só os diffs das suas mudanças
  docs/
  tools/                    <- scripts de decompile/recompile
  .vscode/

<fora do git, só local>
  HabboAir.swf               <- .swf original baixado do release do HabboAirPlus
  HabboAir_src/               <- árvore .as completa (gerada pelo tools/decompile.ps1)
  HabboAir_custom.swf         <- .swf recompilado com suas mudanças
```
