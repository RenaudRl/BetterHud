
# 🎨 Améliorations Visuelles Shader — Possibilités Non Explorées

Analyse complète de ce qui est **déjà implémenté** vs ce qui est **possible** avec le système de core shaders Minecraft dans BetterHud.

---

## ✅ Ce que vous avez déjà

| Catégorie | Fonctionnalités |
|-----------|----------------|
| **Screen Transitions** | 40 effets (fade, wipe, iris, dissolve, blinds, spirales, etc.) |
| **Text Effects** | 16 effets (wave, shake, flip, skew, outline, gradient, rainbow, shimmer, chromatic, metallic, fire, grow, fade, blink, glow) × 2 palettes (classique + blanc) |
| **HUD System** | Positionnement dynamique, layers, opacité, wave, rainbow, tiny rainbow |
| **Sliding Titles** | Titres avec animation d'entrée personnalisée |
| **Screen Effects** | Overlay plein écran via spritesheet |

---

## 🚀 Améliorations Possibles — Par Catégorie

### 1. 🔤 Nouveaux Text Effects (fonctions GLSL à ajouter)

Ces effets sont **100% faisables** avec votre architecture `text_effects.glsl` existante :

| Effet | Description | Complexité |
|-------|-------------|------------|
| **Typewriter** | Caractères apparaissent un par un (basé sur `GameTime` + `characterPosition`) | ⭐⭐ |
| **Glitch / Scramble** | Décalage aléatoire des UV + changement de couleur intermittent (style cyberpunk) | ⭐⭐ |
| **Neon Glow** | Outline colorée avec pulsation lumineuse (utilise `textSdf()` + couleur animée) | ⭐⭐ |
| **Ice / Frost** | Teinte bleutée + reflets cristallins basés sur la position Y | ⭐ |
| **Matrix Rain** | Couleur verte + scanline descendantes sur le texte | ⭐⭐ |
| **Dripping** | Texte qui "coule" — décalage UV progressif vers le bas par caractère | ⭐⭐ |
| **Elastic / Bounce** | Mouvement de rebond oscillant (similaire à `waving` mais avec un ease-in bounce) | ⭐ |
| **Rotation** | Rotation individuelle de chaque caractère | ⭐⭐⭐ |
| **Dissolve** | Caractères se dissolvent pixel par pixel (noise-based sur UV du glyph) | ⭐⭐ |
| **Pixelation** | Texte qui se pixelise et se dépixelise en boucle | ⭐⭐ |
| **Double Vision** | Décalage de couleur R/B style "drunk" (simplifié de chromatic mais avec mouvement) | ⭐ |
| **Underline animée** | Ligne sous le texte qui pulse ou se déplace | ⭐⭐ |
| **Shadow 3D** | Ombre décalée avec profondeur simulée | ⭐ |
| **Gradient animé** | Le gradient se déplace horizontalement au fil du temps | ⭐ |
| **Hologramme** | Scanlines horizontales + transparence intermittente + teinte bleue | ⭐⭐ |
| **Thor / Lightning** | Flash lumineux aléatoire + tremblement | ⭐ |
| **Pulsating Color** | La couleur s'intensifie et s'atténue comme un battement de cœur | ⭐ |
| **Text Shadow Drop** | L'ombre "tombe" progressivement comme une goutte | ⭐⭐ |

---

### 2. 🖥️ Nouvelles Screen Transitions (tt == 40+)

Vous avez 40 transitions. Voici des **effets manquants** très populaires :

| Type | Nom | Description |
|------|-----|-------------|
| 40 | **Swirl / Tourbillon** | Distorsion en tourbillon du centre vers l'extérieur |
| 41 | **Shutter (caméra)** | Effet d'obturateur à iris ~6 lames qui se ferment |
| 42 | **Glitch transition** | Bandes horizontales qui se décalent aléatoirement avec du bruit |
| 43 | **Mosaïque circulaire** | Cercles concentriques qui se remplissent de l'extérieur vers le centre |
| 44 | **Brique/Brick** | Motif briques qui se remplissent rangée par rangée |
| 45 | **Voronoi dissolve** | Dissolution par cellules Voronoi (organique) |
| 46 | **Slide push** | L'écran "pousse" vers un côté comme un slider |
| 47 | **Cross zoom** | Zoom + fondu croisé simultané |
| 48 | **Page flip** | Effet de page qui se tourne (3D) |
| 49 | **Rain/Water drip** | L'écran se "mouille" progressivement de haut en bas |
| 50 | **Burn/Paper burn** | Bord brûlé qui se propage (noir → orange → transparent) |
| 51 | **TV Static** | Grain statique de TV analogique qui envahit l'écran |
| 52 | **Fissure/Crack** | Fissures qui se propagent depuis un point d'impact |
| 53 | **Star wipe** | Forme étoile qui s'ouvre/se ferme (classique) |
| 54 | **Wave distortion** | L'écran ondule avant de disparaître (effet "rêve") |

---

### 3. 🌈 Screen Overlays Persistants (Nouveau système)

Actuellement vos transitions sont **temporaires** (fadeIn/stay/fadeOut). Vous pourriez ajouter des **overlays persistants** :

| Overlay | Description | Usage |
|---------|-------------|-------|
| **Vignette** | Assombrissement des bords de l'écran (cinématique) | Immersion, blessure |
| **Film grain permanent** | Grain subtil animé sur tout l'écran | Atmosphère vintage/horreur |
| **Scanlines CRT** | Lignes de scan rétro permanentes | Ambiance rétro |
| **Distorsion thermique** | Ondulation de chaleur (heat haze) | Zone désertique, near fire |
| **Underwater blur** | Flou + teinte bleue/verte | Immersion aquatique |
| **Color grading** | LUT simple — change la palette couleur de tout l'écran | Mood cinématique |
| **Chromatic aberration écran** | Aberration sur tout l'écran, pas juste le texte | Impact, blessure, drogue |
| **Frost screen** | Givre sur les bords de l'écran | Biome neige, froid |
| **Blood overlay** | Taches rouges sur les bords (RPG damage feedback) | Feedback dégâts |
| **Night vision PS** | Teinte verte + grain + contraste boosté | Vision nocturne custom |

> [!IMPORTANT]
> Les overlays persistants nécessiteraient un système de **toggle** (activation/désactivation) plutôt que le système `/title` actuel qui est ponctuel. Cela pourrait se faire via un caractère HUD spécifique rendu en plein écran, similaire au système `ScreenEffect` existant via `screenEffectId`.

---

### 4. 🎮 Améliorations du HUD

Ce que vous avez déjà dans le vertex shader : **Wave, Rainbow, Tiny Rainbow**.

Propriétés HUD additionnelles possibles (via les `property` bits) :

| Propriété | Bit | Description |
|-----------|-----|-------------|
| **Breathing/Pulse** | `8` | Opacité qui pulse lentement (pour éléments type santé faible) |
| **Slide-in** | `16` | Élément qui glisse depuis le bord (entrée animée) |
| **Shake** | `32` | Tremblement (feedback d'impact) |
| **Scale pulse** | `64` | Agrandissement/rétrécissement périodique |
| **Rotation lente** | `128` | Rotation continue (icônes, boussole) |
| **Flash** | `256` | Clignotement rapide (alerte) |
| **Color shift** | `512` | Changement de teinte cyclique (sans être arc-en-ciel) |

---

### 5. 🎬 Effets de Titre Améliorés

Vous avez déjà le **Sliding Title**. Autres animations de titre possibles :

| Effet | Description |
|-------|-------------|
| **Bounce in** | Le titre rebondit depuis le haut |
| **Scale in** | Le titre commence petit et grandit |
| **Rotate in** | Légère rotation lors de l'entrée |
| **Blur to sharp** | Le titre passe de flou à net (simulé via décalage UV) |
| **Typewriter title** | Les caractères du titre apparaissent un à un |
| **Split entry** | Les mots viennent de gauche et droite pour se rejoindre |
| **Glitch in** | Le titre "glitche" en entrée puis se stabilise |

---

### 6. 📐 Techniques Avancées Non Utilisées

D'après le `shader wiki.txt`, ces techniques ne sont **pas encore exploitées** dans votre implémentation :

| Technique | Shader pertinent | Potentiel |
|-----------|-----------------|-----------|
| **Enchantment glint custom** | `rendertype_glint.fsh` | Glint personnalisé par item via `TextureMat` |
| **Entity shader effects** | `rendertype_entity_cutout_no_cull` | Outline sur mobs, glow custom, tint dynamique |
| **Custom sky** | `position.fsh` | Couleur du ciel custom (events, nuit spéciale) |
| **Block highlight** | `rendertype_solid.fsh` | Blocs qui brillent dans le noir (emissive custom) |
| **Particle customization** | `particle.fsh` | Particles recolorées par situation |
| **Fog manipulation** | `fog.glsl` | Fog custom (horreur, ambiance) |
| **World-space effects** | via `ChunkOffset` | Effets basés sur la position monde (zone de danger rouge, etc.) |

> [!WARNING]
> Modifier des shaders autres que `rendertype_text` impacte **tous les joueurs** car le resource pack est global. Ces effets ne sont pas "par joueur" comme le HUD/transitions. À utiliser avec parcimonie pour l'atmosphère globale du serveur.

---

## 📊 Résumé — Priorisation Recommandée

| Priorité | Catégorie | Effort | Impact Visuel |
|----------|-----------|--------|---------------|
| 🔴 Haute | **Nouveaux Text Effects** (glitch, neon, hologram, typewriter) | Faible — juste ajouter des fonctions dans `text_effects.glsl` | Très élevé |
| 🔴 Haute | **Screen Overlays** (vignette, frost, blood, grain) | Moyen — nouveau système de rendu persistant | Très élevé |
| 🟡 Medium | **Nouvelles Transitions** (40-54) | Faible — ajouter des `else if` dans `text.fsh` | Élevé |
| 🟡 Medium | **HUD Properties** (shake, pulse, slide-in) | Faible — bits additionnels dans `text.vsh` | Élevé |
| 🟢 Basse | **Title Animations** (bounce, scale, glitch) | Moyen — modifier la logique Sliding Titles | Moyen |
| 🟢 Basse | **Shaders non-text** (glint, entities, sky) | Élevé — nouveaux fichiers shader + testing | Variable |

---

## 📝 Ce qui manque dans le `shader wiki.txt`

Le fichier wiki actuel est un **bon résumé généraliste** de MC core shaders, mais il manque des sections spécifiques à BetterHud :

1. **Aucune mention du système `#FDxxyy`** (screen transitions via color codes)
2. **Aucune mention du `TEXT_EFFECT` macro** et du système de détection par couleur
3. **Pas de documentation sur les `property` bits** (wave/rainbow/tiny rainbow sur le HUD)
4. **Pas de section sur le Sliding Titles** et ses paramètres (`TITLE_OFFSET`, `TITLE_SCALE`)
5. **Pas d'explication du `ScreenEffect`** (fullscreen overlay via Y offset)
6. **Manque les limites connues** :
   - Limite de compilation shader (~nombre max de cases switch/if-else)
   - Pas de post-processing (on ne peut pas lire les pixels déjà rendus à l'écran)
   - Pas de lecture de texture d'écran (seulement les textures de l'atlas)
7. **Pas de section "Bonnes pratiques"** pour les performances shader

> [!TIP]
> Le `shader wiki.txt` pourrait être restructuré en deux parties : une partie "Référence Minecraft Core Shaders" (ce qui est déjà là) et une partie "Guide BetterHud Shader System" documentant vos systèmes custom.
