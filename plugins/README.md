# plugins/

Só `*.example.yml` é versionado. Os `.jar` ficam em `run/plugins/` (ignorados).
Nunca ponha `.jar` nesta pasta — o servidor carrega de `run/plugins/`.

`setup` copia cada `Nome.example.yml` → `run/plugins/Nome/config.yml` (sem
sobrescrever). Já versionados: `ViaVersion`, `TAB` (scoreboard), `DiscordSRV`
(sem o token — preencha em `run/`).

## Stack (Paper 1.21.11 / Java 21)

### Automático — `setup` baixa do Modrinth
ViaVersion · ViaBackwards · ViaRewind · LuckPerms · WorldEdit · Duels Optimised
· PlaceholderAPI · TAB (scoreboard; alimenta o Rich Presence — ver `docs/rich-presence.md`)

Duels Optimised = fork ativo do Duels (o oficial morreu no 1.14/1.19); mesma
config e comandos.

### Manual — baixe o `.jar` e ponha em `run/plugins/`

| Plugin | Link | Observação |
|---|---|---|
| OldCombatMechanics | github.com/kernitus/BukkitOldCombatMechanics/releases/latest | combate 1.8; sem config custom (gera o padrão dele) |
| MLG Rush (1vs1 bedwars) | spigotmc.org/resources/mlg-rush-the-1vs1-bedwars.100142/ | Spigot 1.17+ (a res. 132056 exige Java 25) |
| GrimAC | github.com/GrimAnticheat/Grim/releases/latest | anti-cheat |

## Treino de pontes — PENDENTE

SpeedBridge v2 está morto para 1.21 (`Exception initializing main class`).
Alternativas a avaliar: **Bridge Training** (spigotmc 77799), ou construir uma
arena "bridge" no próprio Duels/MLGRush. Definir depois que o resto estiver de pé.

## Ordem de configuração

1. Subir só com Via* + OCM → validar que cliente 1.8.9 e atual entram e o
   combate é 1.8.
2. LuckPerms: `/lp creategroup admin`, `/lp user <voce> parent set admin`,
   `/lp group admin permission set '*' true`.
3. Duels: `/duels` (GUI admin) → criar 1 arena + kits.
4. MLGRush: `/mlgrush setup`.
5. GrimAC por último.
