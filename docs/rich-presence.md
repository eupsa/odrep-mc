# Discord Rich Presence

Mostrar no **perfil do jogador** no Discord algo como:

```
odrep practice
NoDebuff Duel — 12 online
```

## Como funciona (importante)

O servidor **não** consegue setar o Rich Presence de ninguém. Quem exibe é o
**cliente** do jogador, via mod. O servidor só **fornece os dados**, e o jeito
universal de fornecer é pela **scoreboard** — o mod lê o título e as linhas.

Fluxo:

```
Servidor (TAB scoreboard)  ->  Cliente (mod CraftPresence lê a scoreboard)  ->  Discord
```

## Recomendado

| Camada | Escolha | Motivo |
|---|---|---|
| Mod no cliente | **CraftPresence** | padrão de mercado, funciona em 1.8.9 (Forge) e versões novas (Fabric), lê scoreboard/mundo |
| Branding (nome + ícone) | **Discord Application** própria | mostra "odrep practice" e um ícone no lugar de "Minecraft" |
| Dados no servidor | **TAB** + **PlaceholderAPI** | scoreboard com nº de online e modo atual |

Alternativa sem custo de setup: **Lunar Client → Settings → Discord Integration**.
Mostra só "Playing Minecraft 1.8.9" + nome do servidor, sem modo/arena. Serve de
fallback pra quem não instala o CraftPresence.

---

## 1. Servidor — fornecer os dados

Já baixados pelo `setup` (`placeholderapi`, `tab-was-taken`). Depois do primeiro
boot, edite `run/plugins/TAB/config.yml`, seção `scoreboard`:

```yaml
scoreboard:
  enabled: true
  scoreboards:
    practice:
      title: "odrep practice"
      lines:
        - "&7&m--------------------"
        - "&fModo: &a%mode%"
        - "&fOnline: &a%online%&7/&a%maxplayers%"
        - "&fPing: &a%ping%ms"
        - "&7&m--------------------"
        - "&bplay.odrep.gg"
```

- `%online%`, `%maxplayers%`, `%ping%` são nativos do TAB.
- `%mode%` é um placeholder que você define. Simples: crie um por mundo com o
  **PlaceholderAPI** (`/papi` → expansão `Player` / `javascript`), ou use os
  placeholders do Duels/MLGRush quando o jogador está em partida
  (ex.: `%duels_arena%`, `%duels_kit%` — confira os nomes com `/papi ecloud`).
- Recarregue: `/tab reload`.

O **título** da scoreboard (`odrep practice`) e as **linhas** são o que o
CraftPresence vai ler.

## 2. Discord — criar a Application (branding)

1. https://discord.com/developers/applications → **New Application** → nome
   `odrep practice`. (Pode ser o mesmo app do bot do DiscordSRV.)
2. Copie o **Application ID** (aba *General Information*). Esse é o
   `client_id` do Rich Presence.
3. Aba **Rich Presence → Art Assets** → *Add Image(s)*:
   - `logo` — 512×512, o ícone grande
   - `mode_duel`, `mode_lobby`, etc. (opcional) — ícones pequenos por estado
   - O nome que você der é a `key` usada no CraftPresence.

## 3. Cliente — CraftPresence

1. Baixe: https://modrinth.com/mod/craftpresence
   - 1.8.9 → versão **Forge**; 1.21 → **Fabric**
   - Coloque em `.minecraft/mods/` (ou no perfil do launcher usado)
2. No jogo: **Mods → CraftPresence → Config**, ou edite
   `.minecraft/config/craftpresence/`.
3. **General → Client ID** = o Application ID do passo 2.
4. **Display → Presence Data**:
   ```
   details = odrep practice
   state   = {getResult(getFields("scoreboard.title"))}
   ```
   Para linha específica (ex.: a linha do "Modo"):
   ```
   state = {getResult(getFields("scoreboard.line.2"))}
   ```
5. **Images**:
   ```
   largeImageKey = logo
   largeImageText = play.odrep.gg
   ```
6. Salvar → o perfil do Discord passa a mostrar `odrep practice` + a scoreboard.

> Os nomes exatos dos campos (`scoreboard.title`, `scoreboard.line.N`) aparecem
> no próprio CraftPresence em **Config → Presence Settings → Placeholders**.

## 4. Distribuir pros jogadores

- **Não dá pra forçar** — é mod de cliente.
- Opções: pedir que instalem o CraftPresence, ou montar um modpack/perfil
  (CurseForge/Modrinth/MultiMC) com ele já incluso e divulgar o link.
- Quem não instalar continua entrando normal, só não tem o Rich Presence
  detalhado (cai no fallback do Lunar, se usar Lunar).
