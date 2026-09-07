# odrep-mc

Servidor de **practice PvP** (duelos, kits, FFA, combos) com jogabilidade **1.8**,
rodando em **Paper 1.21.8** e aceitando clientes de **1.8.9 até a versão atual**
via ViaVersion.

Este repositório versiona **apenas configuração e scripts**. Os `.jar` (Paper e
plugins), o mundo, os logs e o cache são baixados/gerados localmente e estão no
`.gitignore`.

---

## Arquitetura

| Papel | Software | Origem |
|---|---|---|
| Servidor | Paper 1.21.8 (Java 25) | papermc.io |
| Multi-versão 1.8 → atual | ViaVersion + ViaBackwards + ViaRewind | Modrinth |
| Jogabilidade 1.8 (sem cooldown, knockback antigo) | OldCombatMechanics | Modrinth |
| Duelos / kits / arenas / fila | Duels | SpigotMC (resource 20171) |
| Treino de pontes (bridge / MLG rush) | Bridge Practice ou MLGRush | SpigotMC (ver `plugins/README.md`) |
| Permissões | LuckPerms | Modrinth |
| Anti-cheat | GrimAC | github.com/GrimAnticheat/Grim |

`online-mode=true` — **somente contas originais**. Whitelist desligada.

---

## Primeiro uso

### Servidor (Oracle Cloud, Ubuntu 22.04 ARM64)

```bash
sudo apt update && sudo apt install -y openjdk-25-jre-headless screen curl jq
git clone <este-repo> odrep-mc && cd odrep-mc
bash scripts/setup.sh          # baixa Paper + plugins nas versões fixadas
# aceite a EULA da Mojang conscientemente:
echo "eula=true" > run/eula.txt
bash scripts/start.sh
```

Libere a porta **25565/tcp** no Security List da VCN e no firewall local:

```bash
sudo iptables -I INPUT 6 -m state --state NEW -p tcp --dport 25565 -j ACCEPT
sudo netfilter-persistent save
```

### Teste local (Windows)

Instale o [Temurin 25](https://adoptium.net/temurin/releases/?version=25) x64, depois:

```bat
scripts\setup.bat
echo eula=true> run\eula.txt
scripts\start.bat
```

Conecte em `localhost`.

---

## Estrutura

```
odrep-mc/
├── server.properties            # copiado para run/ pelo setup
├── config/                      # spigot.yml, bukkit.yml, paper-*.yml
├── plugins/*.example.yml        # configs versionadas (o setup copia sem .example)
├── scripts/
│   ├── versions.env            # versões fixadas de tudo
│   ├── setup.sh / setup.bat    # download
│   └── start.sh / start.bat    # flags da JVM (Aikar)
└── run/                        # IGNORADO — servidor roda aqui
```

Editou uma config? Edite em `config/` ou `plugins/*.example.yml` e commite.
Nunca commite nada de dentro de `run/`.
