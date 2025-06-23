# Meetmax - Mobile Developer Assessment

## Overview

Meetmax is a Flutter-based mobile application developed as part of the **Lii Lab Mobile Developer Assessment**. It implements the core **Authentication** and **Feed** screens based on a provided Figma design. Since the backend is not integrated, mock data and simulated API responses are used to replicate real-world behavior.

## Features

- Sign In and Sign Up with full form validation
- Email and password fields are strictly validated for correct format and strength
- Authentication enforced using `AuthService` and route guarding with `HomeGuard`
- Persistent login state using `shared_preferences`
- Feed screen with the following functionalities:
  - Like/unlike posts
  - Add new comments and nested replies to existing posts
  - Create new posts (with mock image upload UI)
  - All interactions update session-local mock data to simulate real-time behavior

## Getting Started

### Prerequisites

- Flutter SDK installed
- A device or emulator to run the app


## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/Nihan-ali/Mobile_app
   cd mobile_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```
   
## Simulated Backend

- Authentication, post interactions, and comment threads are simulated using mock logic
- `shared_preferences` is used to store login state locally
- Mock data is used from `mock_data.dart` for posts, comments, and replies

## Assumptions & Tools Used

- No real backend is connected; behavior is simulated in-memory during the session
- Test credentials:  
  `Email: test@example.com`  
  `Password: password123`
- Tools used: Flutter SDK, Dart, `shared_preferences`, mock data structures

## Notes

- Auth state is preserved during the session via local storage
- Unauthorized users are restricted from accessing the Feed
- Pressing back after login won’t navigate back to the login screen

---


Thanks for reviewing!
