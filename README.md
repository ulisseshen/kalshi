# Financial Status App

## Description

This is a simple Flutter project that calculates the user's financial status based on their annual income and monthly costs. The project consists of two main pages: the home page [HomePage](./lib/src/features/home/home_page.dart) and the status page [StatusPage](./lib/src/features/status/status_page.dart).

## 🔰 Getting Started with the Project

### Prerequisites

- Flutter SDK: [Flutter Installation](https://flutter.dev/docs/get-started/install)
- Dart SDK: [Dart Installation](https://dart.dev/get-dart)

This project was built using Flutter version `3.19.6`.

It is recommended to use [FVM (Flutter Version Management)](https://fvm.app/) to manage the Flutter version.

## ⚙️ Running the Project

```bash
# Clone this repository
$ git clone https://github.com/ulisseshen/kalshi.git

# Navigate to the project folder
$ cd kalshi

# Install dependencies
$ flutter pub get

# Run the application
$ flutter run

# Run the tests
$ flutter test  
```

## 🏙️ Architecture

A simple feature-based architecture was chosen.

- The code for the home and status features is located in the `src/features` folder.
- The shared code between the features is located in the `src/shared` folder.
- Utilities, such as SVG image paths and common vertical spacing, are in the `src/utils` folder.

## 📂 Project Structure
```
lib
├── src
│   ├── ... the entire project
│   ├── main.dart
```

## 📦 Packages Used
  - **flutter_svg**: 
  Used to render icons and logos in .svg format
  - **google_fonts**: 
  Used to follow the project's textual font standards
  - **currency_text_input_formatter**: 
  Used to help with currency formatting

## Credits
By [Ulisses Hen](https://github.com/ulisseshen) The [Mage of Flutter](https://www.linkedin.com/in/ulisseshen/)