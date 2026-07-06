# Wiki — Screen Transitions (Shader Overlays)

Ce document liste l'ensemble des **transitions d'écran** disponibles via les core shaders de BetterHD.
Le système utilise la commande `/title` avec une couleur spéciale `#FDxxyy` pour déclencher un overlay plein écran.

> [!TIP]
> Le caractère `█` (U+2588, FULL BLOCK) est utilisé comme support. L'alpha du `/title` (fadeIn/stay/fadeOut) contrôle la progression.

---

## 🔧 Convention de Couleur

- **R = 253** (0xFD) : Marqueur de transition
- **G** : Type d'effet (0-39)
- **B** : Paramètre supplémentaire (couleur, etc.)

Format : `#FD{G hex}{B hex}` → ex: `#FD0000` = Type 0, Param 0

---

## 🎬 Liste Complète des Effets (40)

### Fondus (0-1)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 0 | `00` | Fondu noir | Fondu progressif vers le noir |
| 1 | `01` | Fondu couleur | Fondu vers une couleur (voir table B ci-dessous) |

#### Paramètre B pour Fondu Couleur (Type 1)

| B | Hex | Couleur |
|---|-----|---------|
| 0 | `00` | Noir |
| 1 | `01` | Blanc |
| 2 | `02` | Rouge |
| 3 | `03` | Bleu |
| 4 | `04` | Vert |
| 5 | `05` | Orange |
| 6 | `06` | Violet |
| 7 | `07` | Jaune |
| 8 | `08` | Cyan |
| 9 | `09` | Magenta |

---

### Iris & Formes (2, 6, 34, 35, 39)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 2 | `02` | Iris close | Cercle qui se ferme au centre |
| 6 | `06` | Diamond wipe | Losange qui se ferme au centre |
| 34 | `22` | Double diamond | Deux losanges symétriques |
| 35 | `23` | Box zoom in | Rectangle qui se ferme au centre |
| 39 | `27` | Heart shape | Forme de cœur qui recouvre l'écran |

---

### Wipes Directionnels (3-5, 16-18)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 3 | `03` | Wipe horizontal | Balayage gauche → droite |
| 4 | `04` | Wipe vertical | Balayage haut → bas |
| 5 | `05` | Wipe diagonal | Balayage en diagonale |
| 16 | `10` | Wipe horizontal inv. | Balayage droite → gauche |
| 17 | `11` | Wipe vertical inv. | Balayage bas → haut |
| 18 | `12` | Wipe diagonal inv. | Diagonale inversée |

---

### Splits & Rideaux (19-20)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 19 | `13` | Curtain horizontal | Split du centre vers les côtés |
| 20 | `14` | Curtain vertical | Split du centre vers haut/bas |

---

### Stores & Bandes (10, 15, 23-24, 36)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 10 | `0A` | Blinds horizontal | Stores horizontaux |
| 15 | `0F` | Blinds vertical | Stores verticaux |
| 23 | `17` | Stripes H alternées | Bandes horizontales opposées |
| 24 | `18` | Stripes V alternées | Bandes verticales opposées |
| 36 | `24` | Scanlines | Lignes de scan alternées |

---

### Dissolutions (7-8, 22, 26, 37)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 7 | `07` | Pixelate dissolve | Pixellisation + dissolution |
| 8 | `08` | Noise dissolve | Dissolution aléatoire |
| 22 | `16` | Grid reveal | Grille de cellules aléatoires |
| 26 | `1A` | Film grain fade | Dissolution avec grain animé |
| 37 | `25` | Triangular mosaic | Mosaïque de triangles aléatoires |

---

### Motifs Géométriques (11-12, 28-29, 30)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 11 | `0B` | Checkerboard | Damier en deux phases |
| 12 | `0C` | Hex dissolve | Dissolution hexagonale |
| 28 | `1C` | Squares grow | Carrés grandissant en grille |
| 29 | `1D` | Circle scatter | Cercles aléatoires qui grossissent |
| 30 | `1E` | Cross dissolve | Forme en X qui s'étend |

---

### Rotations & Spirales (9, 13, 25, 32-33)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 9 | `09` | Radial sweep | Balayage horloge |
| 13 | `0D` | Spiral wipe | Spirale qui recouvre l'écran |
| 25 | `19` | Rotating wipe | Ligne qui tourne |
| 32 | `20` | Angular wipe | Balayage angulaire |
| 33 | `21` | Windmill | Moulin à 4 pales |

---

### Effets Spéciaux (14, 21, 27, 31, 38)

| Type | G | Nom | Description |
|------|---|-----|-------------|
| 14 | `0E` | Zoom blur | Effet tunnel / zoom |
| 21 | `15` | Ripple | Anneaux concentriques ondulants |
| 27 | `1B` | Falling columns | Colonnes qui tombent |
| 31 | `1F` | Zigzag wipe | Balayage en zigzag |
| 38 | `26` | Paint drip | Coulures de peinture |

---

## 🛠️ Commandes de Test Complètes

```mcfunction
# === FONDUS ===
/title @a times 20 40 20

/title @a title {"text":"█","color":"#FD0000"}
# Fondu noir (Type 0)

/title @a title {"text":"█","color":"#FD0101"}
# Fondu blanc (Type 1, B=1)

/title @a title {"text":"█","color":"#FD0102"}
# Fondu rouge (Type 1, B=2)

/title @a title {"text":"█","color":"#FD0103"}
# Fondu bleu (Type 1, B=3)

/title @a title {"text":"█","color":"#FD0104"}
# Fondu vert (Type 1, B=4)

/title @a title {"text":"█","color":"#FD0105"}
# Fondu orange (Type 1, B=5)

/title @a title {"text":"█","color":"#FD0106"}
# Fondu violet (Type 1, B=6)

/title @a title {"text":"█","color":"#FD0107"}
# Fondu jaune (Type 1, B=7)

/title @a title {"text":"█","color":"#FD0108"}
# Fondu cyan (Type 1, B=8)

/title @a title {"text":"█","color":"#FD0109"}
# Fondu magenta (Type 1, B=9)

# === IRIS & FORMES ===
/title @a title {"text":"█","color":"#FD0200"}
# Iris close (Type 2)

/title @a title {"text":"█","color":"#FD0600"}
# Diamond wipe (Type 6)

/title @a title {"text":"█","color":"#FD2200"}
# Double diamond (Type 34)

/title @a title {"text":"█","color":"#FD2300"}
# Box zoom in (Type 35)

/title @a title {"text":"█","color":"#FD2700"}
# Heart shape (Type 39)

# === WIPES ===
/title @a title {"text":"█","color":"#FD0300"}
# Wipe horizontal L→R (Type 3)

/title @a title {"text":"█","color":"#FD0400"}
# Wipe vertical T→B (Type 4)

/title @a title {"text":"█","color":"#FD0500"}
# Wipe diagonal (Type 5)

/title @a title {"text":"█","color":"#FD1000"}
# Wipe horizontal R→L (Type 16)

/title @a title {"text":"█","color":"#FD1100"}
# Wipe vertical B→T (Type 17)

/title @a title {"text":"█","color":"#FD1200"}
# Wipe diagonal inv. (Type 18)

# === RIDEAUX ===
/title @a title {"text":"█","color":"#FD1300"}
# Curtain horizontal (Type 19)

/title @a title {"text":"█","color":"#FD1400"}
# Curtain vertical (Type 20)

# === STORES & BANDES ===
/title @a title {"text":"█","color":"#FD0A00"}
# Blinds horizontal (Type 10)

/title @a title {"text":"█","color":"#FD0F00"}
# Blinds vertical (Type 15)

/title @a title {"text":"█","color":"#FD1700"}
# Stripes H alternées (Type 23)

/title @a title {"text":"█","color":"#FD1800"}
# Stripes V alternées (Type 24)

/title @a title {"text":"█","color":"#FD2400"}
# Scanlines (Type 36)

# === DISSOLUTIONS ===
/title @a title {"text":"█","color":"#FD0700"}
# Pixelate dissolve (Type 7)

/title @a title {"text":"█","color":"#FD0800"}
# Noise dissolve (Type 8)

/title @a title {"text":"█","color":"#FD1600"}
# Grid reveal (Type 22)

/title @a title {"text":"█","color":"#FD1A00"}
# Film grain fade (Type 26)

/title @a title {"text":"█","color":"#FD2500"}
# Triangular mosaic (Type 37)

# === MOTIFS GEOMETRIQUES ===
/title @a title {"text":"█","color":"#FD0B00"}
# Checkerboard (Type 11)

/title @a title {"text":"█","color":"#FD0C00"}
# Hex dissolve (Type 12)

/title @a title {"text":"█","color":"#FD1C00"}
# Squares grow (Type 28)

/title @a title {"text":"█","color":"#FD1D00"}
# Circle scatter (Type 29)

/title @a title {"text":"█","color":"#FD1E00"}
# Cross dissolve (Type 30)

# === ROTATIONS & SPIRALES ===
/title @a title {"text":"█","color":"#FD0900"}
# Radial sweep (Type 9)

/title @a title {"text":"█","color":"#FD0D00"}
# Spiral wipe (Type 13)

/title @a title {"text":"█","color":"#FD1900"}
# Rotating wipe (Type 25)

/title @a title {"text":"█","color":"#FD2000"}
# Angular wipe (Type 32)

/title @a title {"text":"█","color":"#FD2100"}
# Windmill (Type 33)

# === EFFETS SPECIAUX ===
/title @a title {"text":"█","color":"#FD0E00"}
# Zoom blur (Type 14)

/title @a title {"text":"█","color":"#FD1500"}
# Ripple (Type 21)

/title @a title {"text":"█","color":"#FD1B00"}
# Falling columns (Type 27)

/title @a title {"text":"█","color":"#FD1F00"}
# Zigzag wipe (Type 31)

/title @a title {"text":"█","color":"#FD2600"}
# Paint drip (Type 38)
```

---

## 💡 Notes

- **Texte par-dessus** : `/title @a subtitle` ou `/title @a actionbar` pour afficher du texte pendant la transition
- **Durée** : Ajustez les valeurs de `/title @a times <fadeIn> <stay> <fadeOut>` (en ticks, 20 ticks = 1 seconde)
- **Compatibilité** : Indépendant du système BetterHud (HUD, popups, text effects)
- **Évolutivité** : Ajouter un effet = ajouter un `else if (tt == X)` dans `text.fsh`
