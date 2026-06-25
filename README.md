# Student Grade Tracker App

A Flutter app for managing student subjects and marks. Users can add subjects,
view all subjects with calculated grades, and check a live summary with average
mark and overall grade.

## Features

- 3 screens:
	- Add Subject
	- Subject List
	- Summary
- Bottom navigation to switch screens
- Light/Dark theme toggle in AppBar
- Subject model with private `_mark` field and computed `grade`
- Provider-based state management for all app state
- Live summary updates when subjects are added or removed
- Dismissible list items for swipe-to-delete

## Grading Logic

- `A` for marks >= 80
- `B` for marks >= 65
- `C` for marks >= 50
- `F` for marks < 50

## Validation

- Subject name must not be empty
- Mark must be numeric and between 0 and 100

## Tech Stack

- Flutter
- Dart
- provider

## Run Locally

1. Install Flutter SDK.
2. Clone this repository.
3. Open the project folder.
4. Run:

```bash
flutter pub get
flutter run
```

## Project Structure

```text
lib/
	main.dart
	models/
		subject.dart
	providers/
		app_state.dart
		subject_provider.dart
	screens/
		add_subject_screen.dart
		subject_list_screen.dart
		summary_screen.dart
	theme/
		app_themes.dart
```

## Assignment Checklist Coverage

- Private mark field and grade getter in `Subject`
- Uses `.where()` and `.map()` in `SubjectProvider`
- Form validation for empty name and invalid marks
- Swipe-to-delete with `Dismissible`
- Custom light/dark `ThemeData`
- No `setState` usage (Provider only)

