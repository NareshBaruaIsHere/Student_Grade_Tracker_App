# Student Grade Tracker App

A simple Flutter app to track subjects, marks, and grades.

You can:
- Add a subject with mark
- See all saved subjects in a list
- Edit any saved subject
- Delete any saved subject
- View live summary (total, average, overall grade)

## Features

- 3 screens: Add Subject, Subject List, Summary
- Bottom navigation to switch screens
- Light/Dark theme toggle in AppBar
- CRUD support (Create, Read, Update, Delete)
- Swipe to delete from the subject list
- Data is saved locally using shared_preferences
- Provider is used for state management

## Grading Logic

- A for marks >= 80
- B for marks >= 65
- C for marks >= 50
- F for marks < 50

## Validation

- Subject name must not be empty
- Mark must be numeric and between 0 and 100

## Run Locally

1. Clone this repository.
2. Open the project folder.
3. Run:

```bash
flutter pub get
flutter run -d windows
```

You can also run in Chrome:

```bash
flutter run -d chrome
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
