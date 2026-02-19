# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter application called "Method Toolkit" (package name: `pod`) - a design thinking and workshop facilitation tool for coaches and facilitators. The app provides a library of design thinking methods, workshop planning capabilities, and live facilitation mode.

## Development Commands

### Running the App
```bash
flutter run
```

### Testing
```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/widget_test.dart
```

### Code Quality
```bash
# Analyze code for issues
flutter analyze

# Format code
flutter format .
```

### Dependencies
```bash
# Install dependencies
flutter pub get

# Update dependencies
flutter pub upgrade
```

### Building
```bash
# Build for Android
flutter build apk

# Build for iOS
flutter build ios

# Build for web
flutter build web
```

## Architecture

### Core Structure

The app follows a simple Flutter architecture without state management libraries:

- **`lib/main.dart`**: Entry point defining `PodApp` with MaterialApp and route handling
- **`lib/models.dart`**: Data models (`MethodItem`, `MethodStep`, `Workshop`) and sample data
- **`lib/theme.dart`**: Centralized color palette (`AppColors`) used throughout the app
- **`lib/screens/`**: Full-screen views (home, details, planner, live mode)
- **`lib/widgets/`**: Reusable UI components (cards, bottom sheets, navigation)

### Navigation

The app uses named routes defined in `main.dart:28-42`:
- `/details` - Method details screen (requires `MethodItem` argument)
- `/planner` - Workshop planner (requires `Workshop` argument)
- `/live` - Live facilitation mode (requires `MethodItem` argument)

Navigation example:
```dart
Navigator.pushNamed(context, '/details', arguments: method);
```

### Data Flow

Currently uses **global sample data** defined in `models.dart:68-143`:
- `sampleMethods` - List of method templates
- `sampleWorkshop` - Example workshop with agenda

There is no persistent storage or state management library yet. StatefulWidgets manage local state (e.g., `WorkshopPlannerScreen` maintains editable agenda list).

### Key Screens

1. **ToolkitHomeScreen** (`toolkit_home_screen.dart`):
   - Main entry point showing method library
   - Category grid, quick picks carousel, tool of the day
   - Uses `CustomBottomNavBar` widget

2. **MethodDetailsScreen** (`method_details_screen.dart`):
   - Shows full method details (objective, materials, steps, pro tips)
   - Uses ExpansionTiles for collapsible sections
   - "Add to Planner" button opens `AddMethodBottomSheet`

3. **WorkshopPlannerScreen** (`workshop_planner_screen.dart`):
   - Edit workshop title and date
   - Reorderable agenda timeline
   - Calculates total duration from method durations

4. **LiveModeScreen** (`live_mode_screen.dart`):
   - Timer display and stage progress
   - Step-by-step facilitation guide
   - Playback controls (pause, skip, restart)

### Theming

The app uses a **dark theme** with consistent color palette defined in `theme.dart`:
- Primary blue: `AppColors.primary` (#137FEC)
- Background: `AppColors.backgroundDark` (#101922)
- Cards: `AppColors.cardDark` (#161F28)
- Accent colors: pink, orange, green, purple, teal, rose

All screens use Material 3 (`useMaterial3: true`) with dark brightness.

### Models

**MethodItem**: Represents a design thinking method/tool
- Core properties: title, duration, groupSize, difficulty, phase
- Visual: icon, accentColor
- Content: objective, materials, steps, proTips
- Helper: `durationMinutes` getter parses duration string

**MethodStep**: Individual step in a method
- Properties: title, description, isCompleted (for live mode tracking)

**Workshop**: Collection of methods for a session
- Properties: title, date, agenda (list of MethodItems)
- Helper: `totalDurationMinutes` calculates sum of method durations

## Code Conventions

### File Organization
- Screen files: `screens/[name]_screen.dart`
- Widget files: `widgets/[name].dart` (lowercase with underscores)
- Use relative imports for local files: `'../theme.dart'`, `'../models.dart'`

### Widget Structure
- Screens typically have a main `build()` method returning Scaffold
- Break down UI into private `_build*()` methods for major sections
- Use `const` constructors wherever possible for performance

### Styling Patterns
- Always reference `AppColors` from theme.dart, never hardcode colors
- Consistent border radius: 16-24px for cards, 6-12px for chips
- Dark overlay buttons: `Colors.white.withOpacity(0.2)`
- Accent highlights: `color.withOpacity(0.1)` for backgrounds

### Duration Parsing
Methods use string durations like "45-60m", "8 min", "30M". Parse using:
```dart
final clean = duration.replaceAll(RegExp(r'[^0-9]'), '');
final minutes = int.tryParse(clean) ?? 0;
```
For ranges, take the first number: `duration.split('-')[0]`

## Testing

The project uses `flutter_test` and includes a basic smoke test in `test/widget_test.dart` that verifies:
- App launches successfully
- Main text elements render
- Navigation bar is present

When adding features, add corresponding widget tests following the existing pattern.

## Design System

The app implements a design reference for 5 Method Toolkit screens with specific visual patterns:
- Gradient headers for detail screens (using method's accentColor)
- Timeline visualization with vertical line and dots for planner
- Large timer display with glow effects for live mode
- Consistent icon-based info bars (time, size, level)
- Bottom action bars with primary CTAs

Refer to existing screens for design patterns when building new features.
