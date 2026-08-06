# Como os comandos de chat do AirPlus funcionam

Toda a lógica dos comandos (`:playing`, `:dance`, `:chatcolor`, `:barstyle`, etc — a lista inteira do README do
HabboAirPlus) mora numa única classe:

```
scripts/com/sulake/habbo/window/LilithCustoms.as
```

Essa classe (~3900 linhas) é instanciada uma vez pelo `WindowManager` e guarda todo o estado dos comandos
(flags booleanas, dicionários, timers) como propriedades públicas — por isso o nome de "deus-objeto" do
AirPlus.

## As duas peças do padrão

### 1. `AllowedCommands` (array de strings)

Perto do construtor (linha ~272), tem um `Array` gigante com todas as strings de comando reconhecidas,
minúsculas, com o `:` incluso:

```actionscript
this.AllowedCommands = new Array(":)", ":(", ..., ":playing", ..., ":dance", ..., ":navfilter");
```

Esse array é usado por `IsValidCommand()` (pra saber se o que foi digitado é um comando válido, ex: pra
colorir o texto do input) e por `OnChatInputKeyUp()` (autocompletar com Tab). **Se seu comando não estiver
aqui, ele não autocompleta e não fica com highlight de "comando válido"** — mas o dispatcher (abaixo) ainda
roda normalmente mesmo sem isso, então tecnicamente é opcional. Adicione mesmo assim pra ter a mesma UX dos
comandos oficiais.

### 2. `ParseChatInput(RoomWidgetMessage)` — o dispatcher

Função gigante (linha ~2493 a ~3874) chamada toda vez que você aperta Enter no chat. Faz basicamente:

```actionscript
public function ParseChatInput(RoomWidgetMessage:*) : Boolean
{
   var ChatInput:String = RoomWidgetMessage.text;
   var ChatInputSplit:Array = ChatInput.split(" ");
   ChatInputSplit[0] = ChatInputSplit[0].toLowerCase();

   if(ChatInputSplit[0] == ":dance")
   {
      this.RoomSession.sendDanceMessage(int(ChatInputSplit[1]));
      return false;   // false = "tratei, NÃO manda isso como mensagem de chat normal"
   }
   if(ChatInputSplit[0] == ":playing")
   {
      // toggla uma flag, salva, e chama a API de room engine
      ...
      return false;
   }
   // ... uma centena de outros "if" iguais a esse ...

   return true;   // nenhum comando bateu -> manda como chat normal
}
```

Ou seja: **é um if-chain gigante comparando `ChatInputSplit[0]`** (a primeira palavra do que foi digitado,
já em minúsculo) com cada comando. `ChatInputSplit[1]`, `[2]`... são os argumentos (ex: `:dance 2` →
`ChatInputSplit[1] == "2"`). Cada bloco sempre termina com `return false` (comando consumido) — só cai no
`return true` do final se nada bateu.

Ferramentas auxiliares usadas por quase todo comando:

- `this.ShowWhisperAlert("texto")` — mostra uma mensagem local tipo "sussurro do sistema", só pra você (é
  assim que o `:playing`, `:navfilter` etc. avisam "modo ativado/desativado").
- `this.SaveVariablesValues()` — persiste as flags num `SharedObject` (o "solzinho" local), pra sobreviver
  a um restart do client.
- `this.WindowManager.sessionDataManager.userName` — seu nick logado no Habbo. É a peça-chave pra fazer um
  comando **exclusivo só pra sua conta** (ver abaixo).

## Adicionando um comando seu

Passo a passo, no arquivo `LilithCustoms.as` (na sua cópia local decompilada, fora deste repo):

1. **Adicione a string em `AllowedCommands`** (~linha 273), no final do array:
   ```actionscript
   ...,":navfilter",":meucomando");
   ```
2. **Adicione um bloco `if` em `ParseChatInput`**, em qualquer lugar dentro do `if(ChatInputSplit.length > 0)`
   (por convenção, perto de comandos parecidos), terminando com `return false;`:
   ```actionscript
   if(ChatInputSplit[0] == ":meucomando")
   {
      // sua lógica aqui
      this.ShowWhisperAlert("Fiz uma coisa!");
      return false;
   }
   ```
3. Recompile (ver `docs/BUILD.md`) e teste.

## Comando exclusivo por conta (padrão usado no `:vip`)

Pra um comando só funcionar pra você (mesmo que outras pessoas usem o mesmo `.swf`), compare
`sessionDataManager.userName` antes de executar qualquer efeito, e **sempre retorne `false`** independente do
resultado — assim o comando nunca "vaza" como mensagem de chat nem dá pista pra quem não é você de que ele
existe:

```actionscript
if(ChatInputSplit[0] == ":vip")
{
   if(this.WindowManager.sessionDataManager.userName.toLowerCase() == "seunick")
   {
      this.ShowWhisperAlert("Client customizado por você [OK]");
   }
   return false;
}
```

Isso é puramente de identificação/vaidade local — não interfere em nada do lado do servidor nem de outros
jogadores. Ver `patches/001-vip-command.diff` para o diff exato aplicado como exemplo.

**Fora dos limites:** não use esse gate de usuário pra dar vantagem competitiva em disputas contra outros
jogadores (ex: ganhar corridas de clique, reduzir latência real, automatizar reações mais rápido que humanos).
Isso é cheat mesmo sendo "só seu" — outros jogadores que não têm o mod perdem por causa dele. O padrão acima
serve pra coisas cosméticas/de conveniência, que é a categoria de 100% dos comandos que o próprio AirPlus já
tem oficialmente.
