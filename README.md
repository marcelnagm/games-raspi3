# 🕹️ Games-RasPi3: O Retrô definitivo no seu Raspberry Pi 3

[![Plataforma: Raspberry Pi OS Bookworm](https://img.shields.io/badge/Platform-Raspberry%20Pi%20OS%20Bookworm-red.svg)](https://www.raspberrypi.com/software/)
[![Licença: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Transforme o seu Raspberry Pi 3 em uma máquina de emulação clássica em segundos. Este repositório traz uma curadoria de jogos icônicos rodando diretamente do DOSBox, configurados cirurgicamente para extrair a melhor performance do processador ARM e do sistema de arquivos do **Bookworm**.

Esqueça configurações complexas, mapeamento manual de diretórios ou problemas com o mouse travado na janela. **Basta clonar, executar e jogar.**

---

## 🔥 Por que este ecossistema é diferente?

* **⚡ Performance Máxima Controlada:** Configurações baseadas em emulação dinâmica (`core=dynamic` e `cycles=max`), garantindo taxa de quadros fluida até em jogos exigentes como Doom, Street Fighter 2 e Mortal Kombat.
* **🖱️ Mouse Livre (No Autolock):** Chega de ter o ponteiro capturado pela janela do emulador. Mova o mouse livremente para fora da tela sem precisar de atalhos de teclado.
* **📂 Automação Inteligente via `path.games`:** O sistema varre seu repositório local, resolve os caminhos absolutos de montagem automaticamente e cria os lançadores direto no menu **Jogos** do sistema operacional.
* **🧹 Idempotência Garantida:** Toda vez que você adiciona um jogo ou roda o setup, os atalhos antigos são limpos e reestruturados. Zero lixo acumulado no sistema.

---

## 🎮 Jogos Inclusos na Coleção

O repositório está estruturado para mapear e lançar 15 clássicos absolutos direto do menu:

| Categoria | Título no Menu | Pasta Local | Executável / Script |
| :--- | :--- | :--- | :--- |
| **Ação / FPS** | 🔫 DOOM | `doom` | `DOOM.EXE` |
| **Luta** | 🤼 MORTAL KOMBAT | `mk1` | `MK.EXE` |
| **Luta** | 🥊 STREET FIGHTER 2 | `sf2` | `SSF2T.BAT` |
| **Ação / Corrida** | 🚗 GTA | `gta` | `GTADOS.BAT` |
| **Corrida** | 🏎️ RACING | `ghi` | `gui.EXE` |
| **Plataforma** | 🦾 MEGAMAN | `mmx` | `MMX.BAT` |
| **Plataforma** | 🏰 PRINCE OF PERSIA 2 | `pop2` | `PRINCE.EXE` |
| **Plataforma** | 🍆 RAYMAN | `ray` | `RAYMAN.EXE` |
| **Estratégia / Sim** | 🏥 THEME HOSPITAL | `hosp` | `HOSPITAL.EXE` |
| **Estratégia / Sim** | 🏗️ CONSTRUCTOR | `cons` | `GAME.EXE` |
| **Estratégia / Sim** | 👔 TRANSPORT TYCOOON | `ttd` | `TYCOON.EXE` |
| **Quebra-Cabeça** | 🔧 MACHINE 2 | `machine` | `TIM.EXE` |
| **Educacional** | 🕵️ CARMEN SAN DIEGO | `carmen` | `CARMEN.EXE` |
| **Aventura / RPG** | 🐵 MONKEY ISLAND | `monkey` | `MONKEY.EXE` |
| **Aventura / RPG** | 🔮 LOOM | `loom` | `LOOM.EXE` |

---

## 🚀 Instalação Rápida (Apenas 3 Comandos)

Abra o terminal do seu Raspberry Pi OS e cole o combo abaixo. O script vai instalar o DOSBox (caso não possua), aplicar as otimizações de ciclo de CPU, limpar o cache do menu e injetar os novos atalhos:

```bash
git clone [https://github.com/marcelnagm/games-raspi3](https://github.com/marcelnagm/games-raspi3) games
cd games
./setup.sh
