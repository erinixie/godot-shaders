# Shaders Godot

Shaders adaptados o modificados de GodotShaders y ShaderToys.
Código simple donde poder probar y testearlos.

## GodotShaders

| Nombre                 | Descripción                                   | Autor                                                         | Link                                                    |
| ---------------------- | --------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------- |
| 2D outline stroke      | Aplica una linea exterior al sprite           | [Hancan](https://godotshaders.com/author/hancan/)             | https://godotshaders.com/shader/2d-outline-stroke/      |
| 2D Hologram Shader     | Efecto Holograma a una textura o Sprite       | [Resinten](https://godotshaders.com/author/resinten/)         | https://godotshaders.com/shader/2d-hologram-shader/     |
| Loading Dots Animation | Loading muy completo                          | [Kitsunekotta](https://godotshaders.com/author/kitsunekotta/) | https://godotshaders.com/shader/loading-dots-animation/ |
| Shine 2d               | Shine 2D configurable en movimiento y estilos | [EriNixie](https://godotshaders.com/author/erinixie/)         | https://godotshaders.com/shader/shine-2d-configurable/  |
| Simple Energy Shield   | Aro de color, estilo escudo de energia        | [Axilirate](https://godotshaders.com/author/axilirate/)       | https://godotshaders.com/shader/simple-energy-shield-2/ |

## ShaderToys

| Nombre               | Descripción                                                  | Autor                                                       | Link                                  |
| -------------------- | ------------------------------------------------------------ | ----------------------------------------------------------- | ------------------------------------- |
| Discoteq 2           | Ondas Sinusoidales amarillas                                 | [Supah](https://www.shadertoy.com/user/supah)               | https://www.shadertoy.com/view/DtXfDr |
| Glitch2              | Efecto Glitch                                                | [Coolok](https://www.shadertoy.com/user/Coolok)             | https://www.shadertoy.com/view/4dXBW2 |
| Grassy               | Campo de cesped                                              | [Fizzer](https://www.shadertoy.com/user/fizzer)             | https://www.shadertoy.com/view/lslGR8 |
| Halo RGB             | Halo RGB (Aro RGB)                                           | [Supah](https://www.shadertoy.com/user/supah)               | https://www.shadertoy.com/view/fdSBDD |
| HSL ColorSpace       | Espacio cubico RGB con movimiento                            | [Bloxard](https://www.shadertoy.com/user/bloxard)           | https://www.shadertoy.com/view/4sS3Dc |
| Nani                 | Efecto anime, nani; comic, alerta                            | [FMS_Cat](https://www.shadertoy.com/user/FMS_Cat)           | https://www.shadertoy.com/view/wsfcDM |
| Plasma-238           | Esfera de plasma de colores                                  | [Xor](https://www.shadertoy.com/user/Xor)                   | https://www.shadertoy.com/view/WfS3Dd |
| Plasma particles     | Particulas de plasma en el centro y expande horizaontalmente | [Frontside](https://www.shadertoy.com/user/frontside)       | https://www.shadertoy.com/view/MlfcDN |
| Rays shader          | Rayos dorados estilo celestiales                             | [Coolok](https://www.shadertoy.com/user/Coolok)             | https://www.shadertoy.com/view/XtfcWH |
| Reflejos Celestiales | Rayos dorados estilo celestiales con aro en el centro        | [Rafacacique](https://www.shadertoy.com/user/rafacacique)   | https://www.shadertoy.com/view/lslGzr |
| Ring color remix     | Aro de colores RGB                                           | [Avin](https://www.shadertoy.com/user/avin)                 | https://www.shadertoy.com/view/WtG3RD |
| Ripple shader        | Efecto ondas de agua                                         | [Abhi_bansal](https://www.shadertoy.com/user/abhi_bansal)   | https://www.shadertoy.com/view/ldBXDD |
| Silexars             | Ondas con movimiento estilo caleido                          | [Danguafer](https://www.shadertoy.com/user/Danguafer)       | https://www.shadertoy.com/view/XsXXDn |
| Snow Viking          | Nevada (\*1)                                                 | [Coolok](https://www.shadertoy.com/user/Coolok)             | https://www.shadertoy.com/view/4dSfWV |
| UV Warping           | Ondas de luz como una gota                                   | [Patty\_](https://www.shadertoy.com/user/Patty_)            | https://www.shadertoy.com/view/tcVSDR |
| VHS                  | Efecto VHS vintage                                           | [FMS_Cat](https://www.shadertoy.com/user/FMS_Cat)           | https://www.shadertoy.com/view/MdffD7 |
| Water Caustic        | Ondas con movimiento similar al agua                         | [Dave_Hoskins](https://www.shadertoy.com/user/Dave_Hoskins) | https://www.shadertoy.com/view/MdlXz8 |

## Pasos de transpilación comunes desde ShaderToys

### Cabecera

Indicar la cabecera correcta. Por lo general es del tipo canvas_item:

```txt
	shader_type canvas_item;

	...
```

### Constantes

Verificar si existen constantes redefinidas en el código, de ser así, eliminarla.
El caso más común es PI.

### Sustitución de variables estándar

Doc: https://docs.godotengine.org/es/4.x/tutorials/shaders/converting_glsl_to_godot_shaders.html#id2

Estas son conversiones obligatorias en shaders para Godot:

iResolution → 1.0 / SCREEN_PIXEL_SIZE

```txt
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
```

fragCoord → UV \* resolution

```txt
	vec2 fragCoord = UV * resolution;
```

iTime → TIME

```txt
	reemplazar iTime por TIME
```

fragColor → COLOR

```txt
	reemplazar fragColor por COLOR
```

### Cambio de mainImage a fragment

mainImage() → fragment()

```txt
	void mainImage(out vec4 fragColor, in vec2 fragCoord) → void fragment()
```

### Codigo Ejemplo

```Godot
void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 fragCoord = UV * resolution;

	...
}
```

## MISCELANEAS

### Librerías de Shaders

- https://godotshaders.com/
- https://www.shadertoy.com
- https://github.com/gdquest-demos/godot-shaders
- https://github.com/BlooRabbit/Godot-shaders
