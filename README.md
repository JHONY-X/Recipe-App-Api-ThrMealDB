# www.GLOBAL-MENU.COM - Recipe Browser App

This is a Flutter application built for the **Mobile Application Development (Unit 4)** assignment at Addis Ababa University.

## Student Information
- **Name:** ERMIAS DEREJE
- **Student ID:** ATE/4952/15
- **Task:** TASK C — Recipe Browser App (API: TheMealDB)


## Project Description
The Recipe Browser App allows users to explore various meal categories, browse meals within those categories, and view detailed recipe information including ingredients, measurements, instructions, and a video tutorial link.

## Features
- Browse all meal categories with thumbnails and descriptions.
- Filter meals by category.
- **Search Screen with Debouncing (+5 Bonus):** Integrated search with a 400ms debounce timer to optimize API calls.
- View full recipe details (ingredients, instructions).
- Watch recipe tutorials on YouTube.
- Robust error handling (No internet, timeouts, API errors).
- Clean architecture with a dedicated API service layer and typed model classes.

## Technical Details
- **HTTP Package:** Used for all REST API communication.
- **Service Layer:** `MealApiService` handles all networking logic with a 10-second timeout.
- **Model Classes:** Immutable models with `fromJson`, `toJson`, and `copyWith` methods.
- **State Management:** `FutureBuilder` used to handle loading, error, and data states.
- **URL Launcher:** Integrated for opening YouTube tutorials.

## API Endpoints Used
- `GET https://www.themealdb.com/api/json/v1/1/categories.php` - Fetch all categories.
- `GET https://www.themealdb.com/api/json/v1/1/filter.php?c={category}` - Fetch meals by category.
- `GET https://www.themealdb.com/api/json/v1/1/lookup.php?i={mealId}` - Fetch full meal details.

## How to Run Locally
1. Ensure you have Flutter installed on your machine.
2. Clone the repository:
   ```bash
   git clone <repository-link>
   ```
3. Navigate to the project directory:
   ```bash
   cd Rcipe-App
   ```
4. Install dependencies:
   ```bash
   flutter pub get
   ```
5. Run the application:
   ```bash
   flutter run
   ```

## Known Limitations or Bugs
- The API is limited to the data provided by TheMealDB (free tier).
- Search functionality by name was not a requirement for Track C and thus not implemented.
- Images rely on the availability of the external API thumbnails.

## References
- [TheMealDB API Documentation](https://www.themealdb.com/api.php)
- [Flutter HTTP Package](https://pub.dev/packages/http)
- [Flutter URL Launcher](https://pub.dev/packages/url_launcher)
