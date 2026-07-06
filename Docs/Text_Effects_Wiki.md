# Wiki - Text Effects 

Ce document liste l'ensemble des effets de textes disponibles via les shaders `TextEFFECTS` encodés dans BetterHUD.

Pour utiliser un effet en jeu, il suffit de colorer votre texte avec la couleur **RGB** exacte correspondante (par exemple via des plugins de chat, des Hologrammes, ou des Menus). Le shader détectera cette couleur spécifique et appliquera l'effet magiquement.

> [!TIP]
> Sur Minecraft, les couleurs customisées (Hexadecimal / RGB) s'utilisent souvent via le format `<#HEX>` ou `&#HEX`. 
> Exemple pour (240, 240, 0) dont l'hexadécimal est `#F0F000` : `&#F0F000Mon Texte`

---

## 🎨 Liste des Effets Classiques

Voici les déclencheurs (triggers) RGB pour les effets "classiques" (colorés selon l'effet). Utilisez la valeur HEX pour l'appliquer.

| Effet | Code HEX Déclencheur | Description de l'Effet (Couleurs appliquées) |
|-------|----------------------|----------------------------------------------|
| Statique | `#F0F000` | Texte Rouge, Ombre Rose Foncé |
| Vague (Waving) | `#F0F004` | Texte Jaune, Ombre Marron |
| Itération | `#F0F008` | Texte Vert, Ombre Émeraude |
| Retournement (Flipping) | `#F0F00C` | Texte Cyan, Ombre Bleue |
| Distorsion (Skewing) | `#F0F010` | Texte Violet, Ombre Bleutée |
| Outline | `#F0F014` | Texte Rouge + Contour |
| Dégradé (Gradient) | `#F0F018` | Dégradé Jaune au Rouge |
| Arc-en-ciel (Rainbow) | `#F0F01C` | Dégradé RGB Dynamique |
| Scintillement (Shimmer) | `#F0F020` | Texte Blanc |
| Aberration chromatique | `#F0F024` | Texte Blanc (Sans ombre) |
| Métallique (Metalic) | `#F0F028` | Reflet Gris/Métal |
| Feu (Fire) | `#F0F02C` | Texte Rouge feu animé |
| Grossissement (Growing) | `#F0F030` | Texte Rouge dynamique |
| Fondu Croisé (Fade) | `#F0F034` | Jaune vers Vert |
| Clignotement (Blinking) | `#F0F038` | Texte Vert |
| Brillance (Glowing) | `#F0F03C` | Texte Cyan |

## ⚪ Liste des Effets Blancs (Nouveau)

Voici les déclencheurs (triggers) RGB pour les versions **pur blanc** de l'ensemble de ces mêmes effets.

| Effet | Code HEX Déclencheur | Description de l'Effet |
|-------|----------------------|------------------------|
| Statique | `#F0F400` | Texte Blanc, Ombre Grise |
| Vague (Waving) | `#F0F404` | Texte Blanc, Ombre Grise |
| Itération | `#F0F408` | Texte Blanc, Ombre Grise |
| Retournement (Flipping) | `#F0F40C` | Texte Blanc, Ombre Grise |
| Distorsion (Skewing) | `#F0F410` | Texte Blanc, Ombre Grise |
| Outline | `#F0F414` | Texte Blanc + Contour |
| Dégradé (Gradient) | `#F0F418` | Dégradé Blanc à Gris clair |
| Arc-en-ciel (Rainbow) | `#F0F41C` | Dégradé RGB (Tinté Blanc) |
| Aberration chromatique | `#F0F424` | Texte Blanc (Sans ombre) |
| Métallique (Metalic) | `#F0F428` | Reflet Blanc Métal |
| Feu (Fire) | `#F0F42C` | Flammes Blanches |
| Grossissement (Growing) | `#F0F430` | Texte Blanc Dynamique |
| Fondu Croisé (Fade) | `#F0F434` | Blanc vers transparent |
| Clignotement (Blinking) | `#F0F438` | Texte Blanc |
| Brillance (Glowing) | `#F0F43C` | Texte Blanc |

## 🏷️ Liste des Effets Ranks (Nouveau)

Ces effets sont conçus pour les grades/ranks, avec un texte **pur blanc** et un contour **coloré**.

| Grade | Code HEX Déclencheur | Couleur Contour |
|-------|----------------------|-----------------|
| Player | `#F0F800` | `<#b0b0b0>` |
| Copper | `#F0F804` | `<#ffb02c>` |
| Emerald | `#F0F808` | `<#05a300>` |
| Obsidian | `#F0F80C` | `<#BF00FF>` |
| Helper | `#F0F810` | `<#f46fd8>` |
| Staff | `#F0F814` | `<#1a567f>` |
| Owner | `#F0F818` | `<#b00000>` |

## 📦 Liste des Effets Rarities (Nouveau)

Ces effets sont conçus pour les raretés d'items, avec un texte **pur blanc** et un contour **coloré**.

| Rareté | Code HEX Déclencheur | Couleur Contour |
|-------|----------------------|-----------------|
| Common | `#F0F81C` | `<#999999>` |
| Uncommon | `#F0F820` | `<#FFF200>` |
| Rare | `#F0F824` | `<#00D900>` |
| Epic | `#F0F828` | `<#0091D9>` |
| Legendary | `#F0F82C` | `<#B00012>` |
| Mythic | `#F0F830` | `<#7E00B0>` |

---

## ✨ Effets Additifs (Superposition)

Vous pouvez désormais ajouter un effet supplémentaire (un "calque") par-dessus n'importe quel effet existant (Classique, Blanc, Rank ou Rareté) en changeant simplement le **deuxième octet (Green)** de votre code Hex.

| Catégorie | Valeur G (Green) | Effet Ajouté | Exemple (Glow + Metal) |
|-----------|------------------|--------------|---------------------------|
| **Base** | `F0` (240) | Aucun | `#F0F028` |
| **Glow** | `E8` (232) | Brillance additive | `#F0E828` |
| **Background** | `EC` (236) | Fond noir translucide | `#F0EC28` |
| **Glow + BG** | `E4` (228) | Glow + Fond | `#F0E428` |
| **Glitch** | `E0` (224) | Distorsion Cyberpunk | `#F0E028` |
| **Rainbow Edge**| `DC` (220) | Contour Arc-en-ciel | `#F0DC28` |

> [!NOTE]
> Le reste du code (Byte 3 / Blue) reste identique pour choisir l'effet de base (ex: `28` pour Métallique).

---

## 🛠️ Commandes de Test

### Test des effets additifs (Combinaisons)
```mcfunction
/tellraw Renaud ["",{"text":"Glow + Metal ","color":"#F0E828"},{"text":"BG + Gradient ","color":"#F0EC18"},{"text":"Glitch + Rainbow ","color":"#F0E01C"},{"text":"Metal + RainbowEdge ","color":"#F0DC28"}]
```

### Test des effets ranks
```mcfunction
/tellraw Renaud ["",{"text":"Player ","color":"#F0F800"},{"text":"Copper ","color":"#F0F804"},{"text":"Emerald ","color":"#F0F808"},{"text":"Obsidian ","color":"#F0F80C"},{"text":"Helper ","color":"#F0F810"},{"text":"Staff ","color":"#F0F814"},{"text":"Owner ","color":"#F0F818"}]
```

### Test des effets rarities
```mcfunction
/tellraw Renaud ["",{"text":"Common ","color":"#F0F81C"},{"text":"Uncommon ","color":"#F0F820"},{"text":"Rare ","color":"#F0F824"},{"text":"Epic ","color":"#F0F828"},{"text":"Legendary ","color":"#F0F82C"},{"text":"Mythic ","color":"#F0F830"}]
```

Pour visualiser rapidement l'ensemble des effets en jeu.

### Test des effets classiques
```mcfunction
/tellraw Renaud ["",{"text":"Statique ","color":"#F0F000"},{"text":"Vague ","color":"#F0F004"},{"text":"Itération ","color":"#F0F008"},{"text":"Retournement ","color":"#F0F00C"},{"text":"Distorsion ","color":"#F0F010"},{"text":"Outline ","color":"#F0F014"},{"text":"Dégradé ","color":"#F0F018"},{"text":"Arc-en-ciel ","color":"#F0F01C"},{"text":"Scintillement ","color":"#F0F020"},{"text":"Aberration ","color":"#F0F024"},{"text":"Métallique ","color":"#F0F028"},{"text":"Feu ","color":"#F0F02C"},{"text":"Grossissement ","color":"#F0F030"},{"text":"Fondu ","color":"#F0F034"},{"text":"Clignotement ","color":"#F0F038"},{"text":"Brillance ","color":"#F0F03C"}]
```

### Test des effets blancs
```mcfunction
/tellraw Renaud ["",{"text":"Statique ","color":"#F0F400"},{"text":"Vague ","color":"#F0F404"},{"text":"Itération ","color":"#F0F408"},{"text":"Retournement ","color":"#F0F40C"},{"text":"Distorsion ","color":"#F0F410"},{"text":"Outline ","color":"#F0F414"},{"text":"Dégradé ","color":"#F0F418"},{"text":"Arc-en-ciel ","color":"#F0F41C"},{"text":"Aberration ","color":"#F0F424"},{"text":"Métallique ","color":"#F0F428"},{"text":"Feu ","color":"#F0F42C"},{"text":"Grossissement ","color":"#F0F430"},{"text":"Fondu ","color":"#F0F434"},{"text":"Clignotement ","color":"#F0F438"},{"text":"Brillance ","color":"#F0F43C"}]
```
