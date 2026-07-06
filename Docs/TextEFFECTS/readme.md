# First Effect
So to start off, open the file `assets/minecraft/shaders/include/text_effects_config.glsl`, this the file where you can assign effects to a specific colour.
For example, lets look at the shake effect:
```
TEXT_EFFECT(240, 240, 0) {
    apply_shaking_movement();
    override_text_color(rgb(255, 82, 82));
    override_shadow_color(rgb(100, 20, 80));
}
```
The first line, `TEXT_EFFECT(240, 240, 0)`, denotes what colour the effect should be applied to, this is an RGB value, you can display text with this RGB value in vanilla Minecraft like this: `/tellraw @a {"text":"This is an example message.","color":"#F0F000"}`. The second line, `apply_shaking_movement();`, applies the actual shaking effect, and the lines below that override the text and the text shadow colour. If you've coded in java before you might notice that the syntax is very similar.
You can add and remove any of these effects as you wish, there's not a hard-coded number of how many effects there are in the file.

# Some Technical Stuff
As you probably have noticed, in the default config file I took steps of 4 in the blue channel for every new effect, this has a reason, because to calculate the shadow colour, vanilla Minecraft divides the R, G, and B component by 4 and rounds the result, so if you take steps of less than 4, the shadow colour will be the same between multiple effects and it might apply the wrong effect on it. So make sure that the RGB values you pick aren't too close to each other.

The order in which you apply the effects is important! As a general rule of thumb, this should be the order:
 - Movement
 - Change colour
 - Effects outside of the text (outline, glow, etc.)
if you stick to the order that the effects are in in the list below, you should be fine, but if your text looks weird, please make sure you got the order right.

# The Effects
And finally, the list of the effects!

```
0.  remove_text_shadow()
1.  apply_shaking_movement()
2.  apply_waving_movement()                                      | apply_waving_movement(<speed>)
3.  apply_iterating_movement()                                   | apply_iterating_movement(<speed>, <space>)
4.  apply_flipping_movement()                                    | apply_flipping_movement(<speed>, <space>)
5.  apply_skewing_movement()                                     | apply_skewing_movement(<speed>)
6.  apply_growing_movement()                                     | apply_growing_movement(<speed>)
7.  override_text_color(rgb(<R>, <G>, <B>))                      | override_text_color(rgba(<R>, <G>, <B>, <A>))
8.  override_shadow_color(rgb(<R>, <G>, <B>))                    | override_shadow_color(rgba(<R>, <G>, <B>, <A>))
9.  apply_pride()
10. apply_gradient(rgb(<R1>, <G1>, <B1>), rgb(<R2>, <G2>, <B2>))
11. apply_rainbow()
12. apply_metalic(rgb(<R>, <G>, <B>))
13. apply_fade()                                                 | apply_fade(rgb(<R>, <G>, <B>))
14. apply_shimmer()                                              | apply_shimmer(<speed>, <intensity>)
15. apply_chromatic_abberation()
16. apply_fire()
17. apply_thin_outline(rgb(<R>, <G>, <B>))
18. apply_outline(rgb(<R>, <G>, <B>))
19. apply_glowing()
20. apply_blinking()                                             | apply_blinking(<speed>)
```

The pride effect, there are the following effects:
```
apply_pride() // for the rainbow flag
apply_lesbian_pride()
apply_mlm_pride()
apply_bisexual_pride()
apply_transgender_pride()
apply_pansexual_pride()
apply_asexual_pride()
apply_aromantic_pride()
apply_non_binary_pride()
```

Please join the [Discord server](https://discord.gg/cbFPg737Th) if you have further questions or want to get updates!

# 0143YTM7ORA3SO6P0