# Sajel Siyad - Machine Test

This is a machine test project made with flutter which is assigned to me as a machine test.

## Intructions to build the app

- Clone the github repository

```Bash
git clone https://github.com/SajelSiyad/plus-it-park-.git
```

- Install dependencies

```Bash
flutter pub get
```

- For generating the Freezed classes run the below command in the terminal

```Bash
dart run build_runner build
```

## Project Structure

- As mensioned, to seperate the logic I've used MVC architecture
- **Models** for structuring data
- **View** for including user interface codes
- **Provider** state management codes of Riverpod
- **Services** API fetching and related functionalities
- **Utils** is for including app utilities
