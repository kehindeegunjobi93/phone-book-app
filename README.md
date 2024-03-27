# Phone Book App

## Overview
A Phone  Book App which is a simple yet powerful application for managing your contacts  with features to which you can effortlessly organize your contacts, add new ones, delete and keep your address book up-to-date.

## Features

Efficient Contact Management: Easily add, edit, and delete contacts to keep your address book organized.
Intuitive User Interface: The app features a clean and user-friendly interface, making it easy for users of all levels to navigate and use.
Contact Details: View detailed information for each contact, including name, phone number, and avatar.
Add Contact Page: Includes a form for adding new contacts with validation for name and phone number fields.

## Installation

Instructions on how to install and run the app.

1. Clone this repository.
2. Run `flutter pub get` to install dependencies.
3. Run `flutter run` to start app on emulator

## Usage

How to use the app and any important details users should know.

- Click on the Floating Action Button in the bottom right to add a new contact.
- Upload optional image, add fullname and phone number and click submit.
- See  what you just added on the contact list page
- To view or edit, click on any of the contacts on the list, you  should see update button and the exisiting data
- To delete, click on delete icon at the top right corner.

## Files and Directory Structure

Explanation of the files and directories in the project.

your_flutter_project/
├── android/
├── ios/
├── lib/
│ ├── contact_model.dart
│ ├── contact_repository.dart
│ ├── contact_list_page.dart
│ ├── add_contact_page.dart
│ └── ...
├── test/
│ └── contact_list_page_test.dart
├── pubspec.yaml
└── ...



- `android/`, `ios/`: Native code for Android and iOS platforms.
- `lib/`: Contains Dart code for your app.
  - `contact_model.dart`: Defines the Contact model class.
  - `contact_repository.dart`: Manages the data for contacts.
  - `contact_list_page.dart`: Displays the list of contacts.
  - `add_contact_page.dart`: Allows users to add new contacts.
  - ...
- `test/`: Contains unit tests for the app.
  - `contact_list_page_test.dart`: Tests for the ContactList page widget.
  - ...
- `pubspec.yaml`: Configuration file for the Flutter project.

