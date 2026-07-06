# Tutoriel : Créer des Animations dans BetterHUD

Ce guide explique comment utiliser le système natif de BetterHUD pour créer des animations fluides (séquences d'images) en utilisant les **Pop-ups** et les types d'image **SEQUENCE** ou **SPRITESHEET**.

## 1. Comprendre le système d'animation

Dans BetterHUD, une animation est simplement une série d'images affichées les unes après les autres. Le système est totalement intégré au moteur de rendu, ce qui permet d'utiliser des conditions, des placeholders et des layouts complexes.

### Concepts Clés
- **ImageType SEQUENCE** : Permet de définir une liste de fichiers images à jouer dans l'ordre.
- **ImageType SPRITESHEET** : Permet d'utiliser une seule image (spritesheet verticale) et de la découper automatiquement en frames.
- **AnimationType** : Définit si l'animation doit tourner en boucle (`LOOP`) ou s'arrêter à la fin (`PLAY_ONCE`).
- **Tick** : Contrôle la vitesse globale de rafraîchissement de l'élément.

---

## 2. Configuration d'une image animée

### Option A : Utiliser une liste de fichiers (SEQUENCE)

Utilisez le type `SEQUENCE` dans votre dossier `images/` pour animer des fichiers séparés.

**Exemple : `images/ma_transition.yml`**
```yaml
type: SEQUENCE
files:
  - "transition/frame1.png:5"
  - "transition/frame2.png:5"
  - "transition/frame3.png:5"
# Le chiffre après ':' indique le nombre de ticks pendant lesquels la frame reste affichée.
setting:
  animation-type: PLAY_ONCE # ou LOOP
```

### Option B : Utiliser une spritesheet (SPRITESHEET)

Utilisez le type `SPRITESHEET` pour des animations compactes basées sur une seule image verticale.

**Exemple : `images/mon_effet.yml`**
```yaml
type: SPRITESHEET
file: "effets/spritesheet.png"
frame-height: 32 # Hauteur d'une frame (Défaut: largeur de l'image)
frame-ticks: 2  # Vitesse (Ticks par frame)
scale: 1.0 # (Optionnel) Agrandissement par défaut pour cette image spécifique
scale-x: 1.0 # (Optionnel) Agrandissement horizontal spécifique à l'image
scale-y: 1.0 # (Optionnel) Agrandissement vertical spécifique à l'image
setting:
  animation-type: LOOP
```

---

## 3. Utilisation dans un Layout

Une fois l'image définie, intégrez-la dans un layout.

**Exemple : `layouts/mon_layout_anime.yml`**
```yaml
images:
  mon_image_animee:
    name: mon_effet # Le nom défini dans images/
    scale: 3.5 # (Optionnel) Agrandit proportionnellement (x3.5)
    scale-x: 5.0 # (Optionnel) Assigne une largeur spécifique horizontale de manière désolidarisée de l'axe vertical (Ex: x5.0 pour étirer sur la longueur)
    scale-y: 3.5 # (Optionnel) Assigne une hauteur spécifique à l'axe vertical
    gui:
      x: 0
      y: 0 
    pixel:
      x: 0
      y: 0 # (Optionnel) Ajustez le 'y' pour centrer l'image verticalement après l'avoir agrandie
```

---

## 4. Affichage via un Pop-up

Le meilleur moyen de déclencher une animation temporaire (comme une transition) est d'utiliser un **Pop-up**.

**Exemple : `popups/transition_flash.yml`**
```yaml
duration: 60 # Durée totale du pop-up en ticks
layouts:
  main:
    name: mon_layout_anime
gui:
  x: 0
  y: 0
```

---

## 5. Comparaison avec l'ancien système ScreenEffect

L'ancien système `ScreenEffect` est désormais obsolète et a été intégré au système d'image natif.

| Caractéristique | Ancien ScreenEffect | Nouveau Système SPRITESHEET |
| :--- | :--- | :--- |
| **Positionnement** | Limité au titre (Plein écran) | Libre (Layout standard) |
| **Performance** | Moyen (Font par frame) | **Hautement optimisé** |
| **Intégration** | Système séparé | **Intégration totale** (Placeholders, Conditions) |

---

## Conclusion

Le nouveau système unifié permet de créer des animations plus performantes et plus flexibles. Utilisez `SPRITESHEET` pour vos anciennes animations de transition et `SEQUENCE` pour des animations plus modulaires.
