Compendium Technique : Architecture Avancée et Ingénierie des Systèmes pour Minecraft Java Édition 1.21.11
Chapitre 1 : Introduction au Paradigme Technique de la Version 1.21.11
1.1 Contexte de la Mise à Jour "Mounts of Mayhem"
La version 1.21.11 de Minecraft Java Edition, intitulée "Mounts of Mayhem", marque un tournant décisif dans l'histoire du développement du moteur de jeu Mojang. Bien que les notes de mise à jour grand public mettent en avant des ajouts de contenu tels que la Lance (Spear), les créatures Nautilus, et les montures diversifiées, la véritable révolution se situe au niveau de l'infrastructure des données.1 Pour les développeurs de packs de ressources, les artistes techniques et les concepteurs de datapacks, cette version ne représente pas une simple itération, mais une refonte structurelle majeure nécessitant une réévaluation complète des pipelines de production existants.
L'objectif de ce rapport est de fournir une documentation exhaustive, technique et analytique des changements introduits par les versions de Data Pack 94.1 et de Resource Pack 75.0.1 Contrairement aux mises à jour précédentes qui permettaient une certaine rétrocompatibilité lâche, la 1.21.11 impose des séparations strictes dans les pipelines de rendu et une "registrification" quasi-totale des éléments de gameplay auparavant codés en dur.
1.2 La Philosophie de la Ségrégation des Données
Le thème central de l'architecture 1.21.11 est la ségrégation et la modularité. Historiquement, Minecraft s'appuyait sur des systèmes monolithiques où les textures de blocs et d'objets partageaient souvent les mêmes espaces mémoires (atlas), et où les règles de jeu (Gamerules) existaient en tant que variables globales isolées.
Avec la version 1.21.11, nous observons trois ruptures fondamentales :
La Scission des Atlas (The Atlas Split) : Une séparation physique et logique entre les textures destinées à la géométrie du terrain et celles destinées aux objets en main ou en interface graphique.1
L'Attributarisation de l'Environnement : La transformation des propriétés biométriques statiques (couleur du ciel, brouillard) en attributs dynamiques, modifiables par des chronologies (Timelines) et des contextes dimensionnels.2
La Logique Déclarative des Objets : Le remplacement définitif du système overrides par des définitions de modèles d'objets (Item Model Definitions), permettant une programmation visuelle conditionnelle complexe sans dépendre de prédicats limités.3
Ce document analysera chacune de ces composantes avec une rigueur académique, en s'appuyant sur les données extraites des snippets techniques fournis, pour offrir aux créateurs les outils nécessaires à la maîtrise de cet environnement.
Chapitre 2 : Architecture Graphique et Gestion des Ressources (Format 75)
Le passage au Format de Pack 75 introduit des contraintes strictes conçues pour optimiser le pipeline de rendu OpenGL, mais ces optimisations s'accompagnent d'une complexité accrue pour la gestion des assets.
2.1 La Scission des Atlas de Texture (The Atlas Split)
2.1.1 Analyse Technique de la Séparation
Dans les versions antérieures à la 1.21.11, le moteur de jeu construisait un "atlas cousu" (stitched atlas) principal qui regroupait la majorité des textures. Cela permettait à un modèle d'objet de référencer une texture de bloc (par exemple, un bouton en pierre utilisant la texture minecraft:block/stone) sans friction.
Cependant, cette méthode entraînait des inefficacités notables en termes de filtrage de texture et de gestion de la mémoire vidéo (VRAM). Les blocs nécessitent généralement des "mipmaps" (versions de résolution inférieure de la texture pour le rendu à distance) pour éviter le moiré et le scintillement. Les objets, souvent vus de près dans la main du joueur ou dans l'interface utilisateur, ne bénéficient pas de la même manière de ces mipmaps et peuvent même souffrir d'artefacts visuels (flou excessif) si les niveaux de mipmap sont mal appliqués.
La version 1.21.11 impose donc deux atlas distincts :
minecraft:blocks : Cet atlas contient exclusivement les textures utilisées par les modèles de blocs. Il supporte et génère des niveaux de mipmap complets.4
minecraft:items : Cet atlas est réservé aux textures utilisées par les définitions de modèles d'objets. Crucialement, cet atlas ne génère pas de mipmaps par défaut.4
2.1.2 Implications et Gestion des Erreurs "Missing Texture"
Cette séparation a une conséquence immédiate et critique : le référencement croisé implicite est désormais interdit. Si un fichier JSON de modèle d'objet situé dans assets/<namespace>/items/ tente d'appeler une texture située dans le domaine des blocs (ex: minecraft:block/dirt), le moteur de rendu cherchera cette texture dans l'atlas items. Comme la texture a été cousue dans l'atlas blocks, la recherche échoue, et le jeu retourne la texture de remplacement magenta et noire.5
Stratégies de Migration et de Correction :
Pour les développeurs de packs migrant depuis la 1.21.4, cela nécessite une réorganisation massive des fichiers :
Duplication des Assets : Si un objet doit ressembler à un bloc, sa texture doit être physiquement dupliquée (ou liée symboliquement lors du build) vers le dossier textures/item/.
Configuration des Atlas : Il est théoriquement possible de configurer des fichiers de définition d'atlas JSON pour forcer l'inclusion de certaines textures dans des atlas spécifiques, mais la pratique standard recommandée par Mojang pour le Format 75 est la ségrégation stricte pour garantir la cohérence du pipeline de rendu sans mipmaps pour les objets.4
2.2 Stratégies de Mipmapping et Filtrage
L'introduction de nouvelles options graphiques et de champs de métadonnées offre un contrôle granulaire sur le comportement des textures à distance.
2.2.1 Le Champ mipmap_strategy
Le fichier .mcmeta associé à une texture supporte désormais le champ mipmap_strategy au sein de l'objet texture. Ce champ dicte l'algorithme de sous-échantillonnage utilisé lors de la génération des mipmaps.7
Stratégie
Algorithme et Comportement
Cas d'Usage Recommandé
auto
Llaisse le moteur choisir l'algorithme par défaut (généralement une moyenne pondérée).
Blocs opaques standards (pierre, terre).
mean
Calcule la moyenne arithmétique des pixels voisins. Produit un flou doux.
Textures organiques sans transparence (laine, béton).
cutout
Préserve les bords tranchants entre l'opaque et le transparent. Ignore les valeurs alpha intermédiaires.
Verre, vitres, barreaux de fer.
cutout_strict
Applique un seuil binaire strict. Tout pixel sous le seuil alpha est totalement supprimé dans les mipmaps inférieurs.
Grilles complexes, chaînes, feuillages haute performance.
dark_cutout
Favorise les texels sombres lors de la réduction. Prévient l'apparition de halos clairs autour des objets sombres sur fond transparent.
Capteurs sculk, obsidienne pleureuse, feuillages sombres.

2.2.2 Le Biais de Coupure Alpha (alpha_cutoff_bias)
En complément, le champ alpha_cutoff_bias (flottant) permet de décaler le seuil de transparence lors du calcul des mipmaps.7 Une valeur positive rendra les textures fines plus "épaisses" à distance, empêchant des objets comme les clôtures ou les feuilles de disparaître visuellement lorsqu'ils sont loin. À l'inverse, une valeur négative affinera la texture. C'est un outil puissant pour lutter contre l'aliasing temporel sur les objets fins.
2.3 Filtrage Avancé : RGSS et Anisotropie
La version 1.21.11 expose de nouvelles options utilisateur qui interagissent directement avec ces définitions de texture.
RGSS (Rotated Grid Super Sampling) : Une technique de filtrage basée sur les shaders qui effectue un échantillonnage sur une grille orientée différemment de la grille de pixels de l'écran. Cela offre une meilleure qualité que l'anti-aliasing standard pour un coût de performance modéré.9
Filtrage Anisotrope : Désormais réglable (2x, 4x, 8x), il améliore la netteté des textures vues sous des angles rasants. Les créateurs de packs doivent tester leurs textures "bruyantes" (comme le gravier ou le sable) avec l'anisotropie activée, car elle peut exacerber les motifs répétitifs (effet de tuilage) si la texture n'est pas bien conçue.9
2.4 Mises à Jour des Atlas Célestes et GUI
Un nouvel atlas nommé celestials a été introduit. Il contient exclusivement les textures du soleil, de la lune et des effets de fin (end flashes).7 Cela sépare ces éléments de rendu environnemental des blocs, permettant potentiellement des résolutions beaucoup plus élevées pour les astres sans impacter la taille de l'atlas de terrain principal.
Chapitre 3 : Définitions de Modèles d'Objets (Item Model Definitions)
L'abandon du système overrides au profit des Item Model Definitions est sans doute le changement le plus disruptif pour les créateurs d'objets personnalisés (Custom Items). Ce nouveau système, situé dans assets/<namespace>/items/, introduit une logique de programmation structurée directement dans le JSON.
3.1 Structure et Logique des Définitions
Un fichier de définition d'objet ne décrit pas la géométrie (qui reste dans models/item/), mais le sélecteur logique qui détermine quelle géométrie afficher. La racine du fichier contient un objet model défini par son type.
3.1.1 Le Type minecraft:model
C'est l'unité atomique. Il pointe vers un fichier de modèle géométrique.

JSON


{
  "model": {
    "type": "minecraft:model",
    "model": "minecraft:item/diamond_sword"
  }
}


3.1.2 Le Type minecraft:select (Switch-Case)
Ce type permet de sélectionner un modèle basé sur une propriété spécifique de l'objet.3 Il remplace les longues listes de prédicats.
Propriété (property) : La variable à tester. Exemples : custom_model_data, charge_type, trim_material, display_context.
Cas (cases) : Une liste d'objets définissant la valeur attendue (when) et le modèle à appliquer.
Repli (fallback) : Le modèle par défaut si aucun cas ne correspond.
Exemple d'Application : Variantes de Custom Model Data

JSON


{
  "model": {
    "type": "minecraft:select",
    "property": "minecraft:custom_model_data",
    "cases": [
      {
        "when": "fire_sword",
        "model": { "type": "minecraft:model", "model": "my_pack:item/fire_sword" }
      },
      {
        "when": "ice_sword",
        "model": { "type": "minecraft:model", "model": "my_pack:item/ice_sword" }
      }
    ],
    "fallback": { "type": "minecraft:model", "model": "minecraft:item/iron_sword" }
  }
}


Ce système supporte désormais des chaînes de caractères (Strings) pour le custom_model_data, simplifiant grandement la gestion des IDs par rapport aux nombres arbitraires des versions précédentes.
3.1.3 Le Type minecraft:range_dispatch
Conçu pour remplacer les prédicats numériques linéaires (comme la durabilité ou les anciens CustomModelData numériques), ce type est optimisé pour les valeurs flottantes continues.11
Seuils (threshold) : Le moteur sélectionne la dernière entrée dont le seuil est inférieur ou égal à la valeur de la propriété.
Échelle (scale) : Permet de multiplier la valeur d'entrée avant évaluation.
Cas d'Usage : Barre de Durabilité Personnalisée
Plutôt que d'avoir 100 overrides individuels, le range_dispatch permet de définir des paliers clés (ex: modèle intact, modèle ébréché, modèle brisé) et laisse le moteur gérer la sélection efficacement.
3.1.4 Le Type minecraft:condition
Un opérateur booléen simple. Il évalue une propriété binaire (Vrai/Faux).10
Propriété Clé : minecraft:using_item
Indispensable pour les nouvelles armes comme la Lance (Spear). Elle permet de changer instantanément le modèle (par exemple, passer d'une lance verticale à une lance horizontale) lorsque le joueur maintient le clic droit pour charger une attaque.12
3.1.5 Le Type minecraft:composite
Ce type permet la composition de plusieurs modèles en un seul rendu.13
Fonctionnement : Il prend une liste de modèles et les rend séquentiellement au même emplacement.
Application : C'est la base technique des Ornements d'Armure (Armor Trims) et des Pots Décorés. Cela permet de superposer une "couche de base" et une "couche de texture" sans créer des milliers de fichiers de texture combinés. Pour les créateurs de packs, cela ouvre la porte à des armes modulaires (ex: une poignée + une garde + une lame) assemblées dynamiquement.
3.2 Intégration des Composants de Données
Le système de définition de modèle peut interroger directement les composants de données (Data Components) introduits dans les Data Packs. La propriété minecraft:component permet de vérifier l'existence ou la valeur d'un composant spécifique, liant ainsi étroitement l'état logique de l'objet (Data Pack) à sa représentation visuelle (Resource Pack).
Chapitre 4 : Le Pipeline de Rendu et les Shaders Core
La version 1.21.11 introduit une refonte significative des "Core Shaders" (shaders internes) pour supporter de nouvelles fonctionnalités graphiques comme le "Chunk Fading" (apparition progressive des chunks) et l'animation côté GPU.
4.1 La Scission des Shaders de Terrain
Auparavant, un shader unique terrain gérait la majorité du rendu des blocs. Pour permettre le fondu des chunks lors de leur chargement, ce shader a été scindé 7 :
rendertype_block.vertex / .fragment : Gère les blocs solides opaques.
rendertype_cutout.vertex / .fragment : Gère les blocs avec transparence binaire (feuilles, herbe).
rendertype_translucent : Gère la transparence partielle (eau, verre teinté).
Implication pour les Shaders Personnalisés :
Les créateurs de shaders "vanilla-style" (qui modifient les core shaders pour des effets comme le brouillard personnalisé ou la courbure du monde) doivent désormais injecter leur code dans chacun de ces nouveaux fichiers. De plus, le fragment shader reçoit une nouvelle variable uniforme (probablement u_ChunkFade ou similaire, basée sur l'analyse fonctionnelle) qui contrôle l'opacité globale du chunk. Ignorer cette uniforme dans un shader personnalisé résultera en des chunks qui "poppent" instantanément ou qui restent invisibles.
4.2 Animation de Sprites côté GPU
C'est une optimisation technique majeure. Historiquement, l'animation des textures (l'eau qui coule, le feu, les blocs de prismarine) était calculée par le CPU, qui mettait à jour les coordonnées UV et ré-envoyait les données au GPU à chaque frame. En 1.21.11, cette logique est déplacée vers le GPU.15
Nouveaux Shaders : Des shaders spécifiques sont dédiés à l'interpolation des sprites animés.
Uniforme GameTime : L'uniforme de temps a été standardisé sous le nom GameTime (remplaçant parfois Time), et est accessible globalement.
Uniforme globals : Cet uniforme structurel contient désormais explicitement les coordonnées de la caméra, ce qui simplifie grandement les calculs de position dans les vertex shaders pour les effets de ciel ou de brouillard volumétrique.7
Chapitre 5 : Architecture des Data Packs (Format 94)
Le Data Pack version 94.1 incarne la transition vers un moteur entièrement "Data-Driven". Les éléments de gameplay "codés en dur" sont systématiquement remplacés par des registres configurables.
5.1 Refonte du Registre des Règles de Jeu (Game Rules)
Les Game Rules ne sont plus une liste statique. Elles font partie d'un registre dynamique, ce qui permet aux mods et potentiellement aux futures versions de datapacks d'ajouter leurs propres règles.2
Standardisation des Noms : Toutes les règles ont été renommées en snake_case et placées sous l'espace de noms minecraft.
doFireTick devient minecraft:do_fire_tick.
keepInventory devient minecraft:keep_inventory.
Typage Strict : Les valeurs sont strictement typées (booléen ou entier). L'analyseur de chaînes flou des versions précédentes est supprimé.
Nouvelles Règles Spécifiques :
minecraft:fire_spread_radius_around_player : Remplace la logique binaire de propagation du feu. Elle permet de définir un rayon (entier) autour du joueur où le feu peut se propager, optimisant les performances des serveurs en limitant la simulation du feu aux zones actives.2
5.2 La Commande stopwatch et le Profilage Temps Réel
La version 1.21.11 introduit un outil de diagnostic puissant pour les créateurs de contenu technique : la commande stopwatch.4
Fonctionnalité : Contrairement aux scoreboards qui comptent les "ticks" (boucles de jeu), le stopwatch mesure le temps réel (wall-clock time).
Indépendance du Lag : Le stopwatch continue de tourner même si le serveur "lag" (TPS bas) ou si le jeu est en pause (en solo).
Syntaxe :
/stopwatch create <id> : Initialise un chronomètre.
/stopwatch query <id> : Retourne le temps écoulé.
/execute if stopwatch <id> <range>... : Permet d'exécuter des commandes basées sur le temps réel écoulé.
Cas d'Usage : Cela permet de diagnostiquer précisément les goulots d'étranglement de performance dans les fonctions de datapack complexes, ou de créer des événements basés sur le temps réel (ex: un mode "Speedrun" qui ne dépend pas de la vitesse de simulation du serveur).
5.3 Loot Tables et Prédicats
Fonction minecraft:discard : Une nouvelle fonction de table de butin qui permet de supprimer explicitement un objet. Utile dans des branches conditionnelles complexes où l'on veut s'assurer qu'aucun objet n'est généré si une condition échoue.17
Entrée minecraft:slots : Permet d'extraire le contenu d'un slot spécifique d'une entité (ex: faire tomber la selle d'un cochon ou l'armure d'un cheval zombie) directement via la table de butin.
Prédicats de Composants Vide : La syntaxe {} est désormais valide pour vérifier la simple présence d'un composant, sans se soucier de sa valeur (ex: {"predicates": {"minecraft:written_book_content": {}}} vérifie si un livre est écrit, quel que soit son contenu).4
Chapitre 6 : Attributs Environnementaux (Environment Attributes)
C'est sans doute l'ajout le plus puissant pour la personnalisation des mondes. Les Attributs Environnementaux permettent de modifier les propriétés physico-chimiques et visuelles du monde sans créer de nouvelles dimensions via modding.1
6.1 Anatomie d'un Attribut
Les attributs sont identifiés par des ID espacés de noms, classés par catégorie :
Visuel (minecraft:visual/) :
sky_color : Couleur RGB du ciel.
water_fog_color : Couleur du brouillard sous-marin.
water_fog_end_distance : Distance de rendu du brouillard (remplace les tags de biomes statiques).4
sun_angle, moon_phase : Contrôle la position et l'apparence des astres.
Gameplay (minecraft:gameplay/) :
water_evaporates : Booléen. Si vrai, l'eau se vaporise (comportement du Nether).
snow_golem_melts : Booléen. Détermine si les bonhommes de neige subissent des dégâts (remplace le tag #snow_golem_melts).
can_pillager_patrol_spawn : Contrôle l'apparition des patrouilles.
Audio (minecraft:audio/) :
background_music : Définit la boucle musicale d'ambiance.
6.2 La Hiérarchie de Résolution (The Stack)
La valeur finale d'un attribut est calculée en empilant les modificateurs provenant de différentes sources, résolues dans un ordre de priorité strict 2 :
Météo (Weather) : Priorité maximale (pluie, orage assombrissant le ciel).
Chronologies (Timelines) : Modificateurs temporels dynamiques.
Biomes : Modificateurs positionnels (le joueur est dans un marais vs un désert).
Dimensions : Valeur de base (Overworld, Nether, End).
Le système utilise des opérations mathématiques standard (add, multiply, override, lerp) pour mélanger ces valeurs. Par exemple, une dimension peut définir un ciel bleu. Un biome "Terre Brûlée" peut multiplier le rouge par 2.0. Une timeline "Nuit" peut multiplier la luminosité globale par 0.1.
Chapitre 7 : Le Système de Chronologies (Timelines)
Les Timelines (data/<namespace>/timeline/<id>.json) introduisent la notion de scripter le temps absolu du jeu. Elles permettent de faire varier les Attributs Environnementaux en fonction de l'heure de la journée (/time set).1
7.1 Structure JSON d'une Timeline
Une timeline est définie par :
period_ticks : La durée de la boucle (ex: 24000 pour un cycle jour/nuit standard).
tracks : Une série de pistes, chacune contrôlant un Attribut Environnemental spécifique.
keyframes : Des points de données à des ticks spécifiques. Le jeu interpole (généralement linéairement ou via catmull_rom pour des courbes douces) entre ces points.
Exemple de Scénario : L'Événement "Lune de Sang"
Un développeur peut créer une timeline qui s'active uniquement certaines nuits :
De 0 à 12000 ticks (journée) : Pas de modification.
De 13000 à 23000 ticks (nuit) :
Piste minecraft:visual/sky_color : Interpole vers un rouge profond (#FF0000).
Piste minecraft:visual/moon_phase : Force la phase de pleine lune.
Piste minecraft:gameplay/mob_spawn_rate (attribut hypothétique basé sur les snippets) : Multiplie le taux d'apparition par 2.0.
7.2 Tags de Timelines
Les timelines sont activées via des tags qui définissent leur portée dimensionnelle 4 :
#in_overworld : Active la timeline dans l'Overworld.
#in_nether, #in_end.
#universal : Applique la timeline à toutes les dimensions chargées.
Chapitre 8 : Nouveaux Composants d'Objets et Mécaniques de Combat
La mise à jour "Mounts of Mayhem" introduit des mécaniques de combat monté qui reposent entièrement sur de nouveaux composants de données (Data Components). Ces composants transforment la façon dont les armes interagissent avec les entités.
8.1 La Physique des Armes Cinétiques (kinetic_weapon)
Ce composant est au cœur du fonctionnement de la nouvelle Lance (Spear). Il introduit une mécanique de dégâts basée sur la vélocité relative.7
Principe : Les dégâts ne sont plus fixes. Ils sont calculés en fonction de la vitesse du joueur (ou de sa monture) par rapport à la cible au moment de l'impact.
Champs Configurables :
damage_multiplier (float) : Facteur multiplicateur appliqué à la vitesse pour calculer les dégâts bonus.
contact_cooldown_ticks (int) : Délai avant qu'une nouvelle instance de dégâts cinétiques puisse être appliquée (empêche le "spam" de collisions).
hit_sound : L'événement sonore joué lors d'un impact réussi.
min_speed : Vitesse minimale requise pour activer l'effet cinétique.
8.2 Composants d'Interaction et de Portée
La version 1.21.11 découple enfin la portée d'attaque du mode de jeu (Survie vs Créatif).
minecraft:attack_range : Définit la portée physique de l'arme.
min_reach : Distance minimale. Permet de créer des armes d'hast (comme des piques) inefficaces au corps-à-corps immédiat.
max_reach : Portée maximale (ex: la Lance a une portée étendue).
hitbox_margin : Marge supplémentaire ajoutée à la hitbox de la cible pour faciliter la détection des coups à haute vitesse.18
minecraft:minimum_attack_charge : Un flottant (0.0 - 1.0) qui définit le remplissage nécessaire de la barre de rechargement pour pouvoir lancer une attaque. Cela permet de créer des armes lourdes nécessitant un engagement total.7
8.3 Effets d'Utilisation (use_effects)
Ce composant gère les effets passifs lorsqu'un objet est utilisé (maintenu en clic droit).
can_sprint (booléen) : Détermine si le joueur peut sprinter en utilisant l'objet (ex: charger une lance à cheval).
interact_vibrations : Détermine si l'utilisation émet des vibrations détectables par le Warden.
Chapitre 9 : Entités et Écosystème (Mounts of Mayhem)
L'écosystème de la 1.21.11 s'enrichit de nouvelles créatures interagissant avec ces systèmes.
9.1 La Famille Nautilus
Nautilus & Zombie Nautilus : Ces nouvelles créatures aquatiques disposent de variantes pilotées par les données (data-driven variants).
Fichier de définition : data/<namespace>/zombie_nautilus_variant/<id>.json.4
Champs : model (normal/warm), asset_id (texture), spawn_conditions (règles d'apparition biométriques).
Comportement : Ils utilisent les nouveaux tags #nautilus_hostiles pour déterminer leurs cibles.4
9.2 Les Montures et Ennemis
Chevaux Zombies : Ils apparaissent désormais naturellement, validant l'intégration des nouvelles règles d'apparition.
Camel Husk (Husk de Chameau) & Parched : Nouvelles variantes désertiques. Leurs tables de butin utilisent probablement la nouvelle fonction minecraft:slots pour gérer l'équipement (selles, armures) lors de la mort.
Chapitre 10 : Synthèse et Recommandations de Production
La transition vers Minecraft Java 1.21.11 exige une rigueur nouvelle. Les "hacks" de ressources packs (textures mixtes) et les astuces de datapacks (biomes hardcodés) ne fonctionnent plus. Pour produire du contenu "ultra détaillé" et fonctionnel :
Adoptez la Ségrégation : Séparez physiquement vos textures de blocs et d'objets. Mettez à jour vos scripts de build pour automatiser cette vérification.
Maîtrisez les Registres : Utilisez les Environment Attributes pour créer des ambiances uniques sans modding lourd. Les Timelines sont votre nouvel outil principal pour l'immersion dynamique.
Pensez "Composant" : Ne concevez plus des objets par leur ID, mais par l'assemblage de leurs composants (kinetic, range, model).
Profilez : Utilisez la commande stopwatch pour garantir que vos nouvelles mécaniques temporelles ne saturent pas le temps de trame du serveur.
Cette architecture, bien que plus contraignante, offre une puissance expressive inégalée, transformant le moteur Minecraft en un véritable moteur de jeu modulaire accessible via JSON.
Sources des citations
Minecraft Java Edition 1.21.11, consulté le février 17, 2026, https://www.minecraft.net/en-us/article/minecraft-java-edition-1-21-11
Minecraft Java Edition 1.21.11, consulté le février 17, 2026, https://www.minecraft.net/pl-pl/article/minecraft-java-edition-1-21-11
Custom Textures for Minecraft 1.21.4+ | SDevelopement Wiki - Ssomar Plugins, consulté le février 17, 2026, https://docs.ssomar.com/executableitems/questions-or-guides/custom-textures/custom-textures-1.21.4+-article-version/
Minecraft Java Edition 1.21.11, consulté le février 17, 2026, https://www.minecraft.net/ru-ru/article/minecraft-java-edition-1-21-11
1.21.11 Resource pack help, issue is (I think) to do with blocks & items atlases - Reddit, consulté le février 17, 2026, https://www.reddit.com/r/MinecraftCommands/comments/1q43kw2/12111_resource_pack_help_issue_is_i_think_to_do/
Don't use `#missing` when using block/item for format 1.21.11 · Issue #3291 · JannisX11/blockbench - GitHub, consulté le février 17, 2026, https://github.com/JannisX11/blockbench/issues/3291
Data & Resource Pack News in Minecraft 1.21.11! - YouTube, consulté le février 17, 2026, https://www.youtube.com/watch?v=5yY25GoWQhs
Minecraft Java Edition 1.21.11, consulté le février 17, 2026, https://www.minecraft.net/de-de/article/minecraft-java-edition-1-21-11
Minecraft 1.21.11 Pre-Release 1, consulté le février 17, 2026, https://www.minecraft.net/sv-se/article/minecraft-1-21-11-pre-release-1
Item Model Override > Select Component CustomData not functioning - Reddit, consulté le février 17, 2026, https://www.reddit.com/r/MinecraftCommands/comments/1own8h6/item_model_override_select_component_customdata/
Custom Model Data 1.21.4 using numeric values : r/MinecraftCommands - Reddit, consulté le février 17, 2026, https://www.reddit.com/r/MinecraftCommands/comments/1h8acl7/custom_model_data_1214_using_numeric_values/
Minecraft Snapshot 24w45a, consulté le février 17, 2026, https://www.minecraft.net/en-us/article/minecraft-snapshot-24w45a
Client Items | NeoForged docs, consulté le février 17, 2026, https://docs.neoforged.net/docs/1.21.5/resources/client/models/items/
How To Download Shaders For Minecraft 1.21.11 (Easy Guide 2026) - YouTube, consulté le février 17, 2026, https://www.youtube.com/watch?v=zHB7_VEbdL0
Minecraft Snapshot 24w34a, consulté le février 17, 2026, https://www.minecraft.net/sv-se/article/minecraft-snapshot-24w34a
Did the gamerule names change in 1.21.11? : r/MinecraftCommands - Reddit, consulté le février 17, 2026, https://www.reddit.com/r/MinecraftCommands/comments/1piyapy/did_the_gamerule_names_change_in_12111/
Minecraft Java Edition 1.21.11, consulté le février 17, 2026, https://www.minecraft.net/nb-no/article/minecraft-java-edition-1-21-11
Minecraft 1.21.11 Pre-Release 1, consulté le février 17, 2026, https://www.minecraft.net/en-us/article/minecraft-1-21-11-pre-release-1
