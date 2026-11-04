[TartarusApocalypto_README.md](https://github.com/user-attachments/files/34395499/TartarusApocalypto_README.md)
# TartarusApocalypto

Welcome to **TartarusApocalypto**! This is a 2D action-survival game built with the Godot Engine. Battle your way through waves of relentless enemies, collect experience gems to grow stronger, and survive the apocalypse.

## 🕹️ Play Now
You can download and play the game directly—no engine installation or code compiling required!
* **[Download for Windows (Latest Release)](https://github.com/NubezVilla/TartarusApocalypto/releases/tag/v1.0.0)**

## 🎮 Game Overview
*(Add a brief, exciting description of your game's story, setting, and core loop here. For example: "You are the last survivor trapped in a shifting realm. Fight off swarms of Flying Zombies, Stone Golems, and feral hounds while destroying the environment to scavenge for food.")*
You are the lone survivor of a devistating apocalypse with a simple mission, survive the hordes. Fight off swarms of zombies, Golems, and zombified dogs while destroying the environment to keep your health up. How long can you survive?

## ✨ Features
* **🎨 Custom Hand-Crafted Art:** All character sprites, environments, and animations are 100% custom and hand-drawn.
* **Dynamic 2D AI Pathfinding:** Enemies utilize Godot's robust NavigationAgent2D system to intelligently navigate the environment and chase the player.
* **Diverse Enemy Roster:**
  * **Flying Enemies:** Quick, aerial threats that spit projectiles.
  * **Zombies**: Slow moving melee attackers. 
  * **Zombie Dogs:** Fast-moving melee attackers.
  * **Stone Golems (Mini-Bosses):** Heavy hitters that hurl devastating zombie projectiles.
* **Experience & Progression:** Defeat enemies to spawn EXP Gems (White, Orange, Red) and level up.
* **Interactive Environments:** Destroy props like Lampposts and Mailboxes to scavenge for health-restoring Food.
* **Custom Animation System:** Fully animated sprites for movement, attacking, taking damage, and death sequences using AnimationPlayer and AnimatedSprite2D.

## 🛠️ Built With
* **Engine:** [Godot Engine v4.7](https://godotengine.org/)
* **Language:** GDScript *(Note: This project was recently migrated and optimized for Godot 4.7 physics and navigation standards).*

## 🚀 Setup for Developers
To run or edit this project locally on your machine, follow these steps:

### Prerequisites
* Download and install **Godot Engine 4.7** (Standard version).

### Installation
1. Clone this repository or extract the project ZIP file to your local machine:
   ```bash
   git clone https://github.com/NubezVilla/TartarusApocalypto.git
   ```
2. Open the Godot 4.7 Project Manager.
3. Click **Import** and navigate to the folder where you extracted the project.
4. Select the `project.godot` file and click **Import & Edit**.
5. Press F5 (or click the Play button in the top right) to run the game!

## 🕹️ Controls
*(Update these with your actual game controls!)*
* **W, A, S, D** - Move
* **Left Click** - Attack / Shoot
* **Right Click** - Special Ability
* **Spacebar** - Dash
* **Escape** - Pause Menu

## 📂 Project Structure Highlights
* `res://Player/` - Player scripts, scenes, and animations.
* `res://Assets/` - Core sprites, environment props, and collectibles (Gems, Food).
* `res://Enemy_Nodes/` - Base enemy class resources and shared logic.
* *Enemy Folders:* Individual logic and scenes for FlyingEnemy, StoneGolem, ZombieDog, etc.

## 📜 License

**All Rights Reserved**

This project is a portfolio piece and proof of concept. You are explicitly permitted to clone this repository, download the code, and run the project locally for educational and evaluation purposes. 

However, all assets (including custom hand-drawn sprites, animations, and environments) and source code are the property of the creator. You may not copy, distribute, modify, or monetize this project or its assets without explicit permission.
---
*Created by Group 6*
