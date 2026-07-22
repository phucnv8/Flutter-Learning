# 14. Enum Nâng Cao (Enhanced Enums)

### 14.1 Enum cơ bản

```dart
enum Direction { north, south, east, west }

void main() {
  final dir = Direction.north;
  print(dir.name);  // north
  print(dir.index); // 0

  // Switch exhaustive
  switch (dir) {
    case Direction.north: print('Đi lên');
    case Direction.south: print('Đi xuống');
    case Direction.east:  print('Đi phải');
    case Direction.west:  print('Đi trái');
  }
}
```

### 14.2 Enhanced Enum (Dart 2.17+)

Enum có thể chứa field, constructor, và method như class:

```dart
enum Planet {
  mercury(3.303e+23, 2.4397e6),
  venus(4.869e+24, 6.0518e6),
  earth(5.976e+24, 6.37814e6),
  mars(6.421e+23, 3.3972e6);

  // Fields
  final double mass;       // kg
  final double radius;     // m

  // Constant constructor (bắt buộc với enhanced enum)
  const Planet(this.mass, this.radius);

  // Computed property
  double get surfaceGravity {
    const G = 6.67430e-11;
    return G * mass / (radius * radius);
  }

  double surfaceWeight(double otherMass) => otherMass * surfaceGravity;
}

void main() {
  const earthWeight = 75.0;
  const mass = earthWeight / Planet.earth.surfaceGravity;

  for (final p in Planet.values) {
    print('${p.name}: ${p.surfaceWeight(mass).toStringAsFixed(2)} N');
  }
}
```

### 14.3 Enum implement interface

```dart
abstract interface class Describable {
  String get description;
}

enum Season implements Describable {
  spring('Mùa xuân — ấm áp, hoa nở'),
  summer('Mùa hè — nóng, nhiều nắng'),
  autumn('Mùa thu — mát, lá vàng'),
  winter('Mùa đông — lạnh, có tuyết');

  @override
  final String description;

  const Season(this.description);
}

void main() {
  for (final s in Season.values) {
    print('${s.name}: ${s.description}');
  }
}
```

### 14.4 Enum với mixin

```dart
mixin EnumLabel {
  String get label => name.toUpperCase();
}

enum Status with EnumLabel { pending, active, inactive, banned }

void main() {
  print(Status.active.label); // ACTIVE
}
```
