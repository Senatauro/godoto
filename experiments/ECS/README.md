# ECS-Godot Bridge System

This bridge system connects your Godot nodes to the ECS (Entity Component System) architecture, allowing you to control visual nodes using pure ECS logic.

## How It Works

The bridge consists of:

1. **NodeComponent** - Stores reference to Godot nodes
2. **TransformComponent** - Stores position, rotation, scale, and velocity
3. **NodeBridge** - Script that connects any node to ECS
4. **RenderSystem** - Updates node positions from ECS transform data

## Usage

### 1. Basic Setup

Add the NodeBridge script to any node you want to control with ECS:

```gdscript
# Attach NodeBridge.gd to your node
# Configure in the inspector:
auto_create_entity = true
add_input_component = true     # For player-controlled entities
add_movement_component = true  # For moving entities
add_player_tag = true         # For player entities
speed = 400.0                 # Movement speed
```

### 2. ECS Flow

1. **InputSystem** reads player input → updates `InputComponent`
2. **MovementSystem** reads `InputComponent` → updates `TransformComponent` 
3. **RenderSystem** reads `TransformComponent` + `NodeComponent` → updates actual node position

### 3. Example: Player Character

```gdscript
# Create a CharacterBody2D scene
# Add NodeBridge as child with these settings:
auto_create_entity = true
add_input_component = true
add_movement_component = true  
add_player_tag = true
speed = 400.0
```

### 4. Example: Enemy/NPC

```gdscript
# Create any Node2D-based scene  
# Add NodeBridge as child with these settings:
auto_create_entity = true
add_input_component = false    # No player input
add_movement_component = true  # Can move via AI systems
add_player_tag = false        # Not a player
speed = 200.0
```

### 5. Required Input Actions

Make sure your project has these input actions defined:
- `mover_direita` (move right)
- `mover_esquerda` (move left)  
- `mover_cima` (move up)
- `mover_baixo` (move down)

### 6. World Setup

The World script needs to be an autoload singleton:
1. Go to Project → Project Settings → Autoload
2. Add `res://experiments/ECS/scripts/world.gd` as `World`

## Components Reference

### TransformComponent
```gdscript
var position: Vector2      # World position
var rotation: float       # Rotation in radians
var scale: Vector2         # Scale factor
var velocity: Vector2      # Current velocity
```

### MoveComponent  
```gdscript
var speed: float           # Maximum speed
var acceleration: float    # How fast to reach max speed
var friction: float        # How fast to stop when no input
```

### InputComponent
```gdscript
var input_X: int          # -1, 0, or 1
var input_y: float        # -1, 0, or 1
```

### NodeComponent
```gdscript
var node: Node            # Reference to Godot node
var node_type: String     # Type of node (auto-detected)
```

## Advanced Usage

### Adding Components at Runtime

```gdscript
# Get the bridge from any node
var bridge = $NodeBridge
bridge.add_component(CustomComponent.new())

# Or make any node a player at runtime
bridge.make_player()
```

### Creating Custom Systems

```gdscript
extends BaseSystem
class_name AISystem

func _update(world: World, delta: float):
    var entities = world.get_entities_with_components(["AIComponent", "TransformComponent"])
    for entity in entities:
        # Your AI logic here
        pass
```

### Querying ECS Data

```gdscript
# Find all entities with specific components
var players = World.get_entities_with_components(["PlayerTag", "TransformComponent"])

# Get component from entity
var transform = World.get_component_from_entity(entity_id, "TransformComponent")
```

This bridge allows you to have the visual benefits of Godot's scene system while maintaining the flexibility and performance benefits of ECS architecture.
