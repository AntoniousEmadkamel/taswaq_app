# Taswaq_app

## Overview

**Taswaq_app** is a comprehensive e-commerce application built with Flutter, designed as a showcase of advanced software architecture, clean code practices, and robust state management. This project implements a real-world, scalable online shopping experience, with a modular structure,and robust domain-driven design.

---

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Technologies & Libraries Used](#technologies--libraries-used)
- [Project Structure](#project-structure)
- [Detailed Module Breakdown](#detailed-module-breakdown)
- [How to Run](#how-to-run)
- [Notes](#notes)

---

## Features

### 🛒 E-Commerce Features
- **on-boarding Screen:**
    - smooth on-boarding to make user know about app
- **Product Listing:**
    - Paginated and categorized product list with detailed product cards.
    - Real-time search and filter support.
- **Product Details:**
    - Detailed product pages, including images, size, color, and brand info.
    - Carousel and image slider for product photos.
    - Add to wishlist, select size/color, and add to cart.
- **Cart Management and Payment:**
    - View, add, remove, and update product quantities in the cart.
    - Persistent cart using secure local storage.
    - Real-time price calculation and updates.
    - Payment using paymob
- **Wishlist:**
    - Add/remove products from wishlist.
    - Sync wishlist items with backend.
- **Authentication:**
    - Full user signup and login flows.
    - Secure authentication with token management .
    - Error handling and feedback for signup/login.
    - Forget password and change it using OTP
- **Profile:**
    - View and update profile information.
    - Change password, with secure validation.
- **Brands & Categories:**
    - Browse products by brand and category.
    - Dynamic fetching of brands/categories from backend.
- **Responsive UI:**
    - Fully responsive design for mobile devices.
    - Adaptive layouts with `flutter_screenutil`.
- **State Management:**
    - Robust use of Bloc pattern across all modules.
    - Separation of events, states, and business logic.
- **Error Handling:**
    - Centralized error/failure management at all layers.
    - User-friendly error messages and retry options.
- **API Integration:**
    - All data is fetched and updated via RESTful APIs.
    - Uses Dio for HTTP requests and advanced error parsing.
- **Clean Architecture:**
    - Clear separation of data, domain, and presentation layers.
    - Use case driven, testable, and scalable codebase.
- **Caching:**
    - Persistent caching of authentication tokens and user data with `shared_preferences`.
- **Theming:**
    - Centralized color and style management.
    - Reusable widget sets and theme configs.

---

## Architecture

### Clean Architecture Principles

- **Domain Layer:**
    - Contains business logic, entities, and use cases.
- **Data Layer:**
    - Responsible for data sources (remote/local), models, and repository implementations.
- **Presentation Layer:**
    - UI code structured into screens, widgets, blocs (state management), and events/states.


**Benefits:**
- High testability.
- Easy to extend features and swap implementations.
- Clear ownership and responsibility for each part.

---

## Technologies & Libraries Used

- **Flutter** (UI Framework)
- **Dart** (Programming Language)
- **flutter_bloc + bloc:** State management architecture.
- **injectable + get_it:** Dependency injection for scalable, decoupled code.
- **Dio:** Powerful HTTP client for API calls.
- **dartz:** Functional programming helpers (Either, Option, etc.).
- **shared_preferences:** Local persistent storage for tokens and user data.
- **flutter_screenutil:** Responsive design and adaptive sizing.
- **cached_network_image:** Efficient image loading/caching.
- **carousel_slider, flutter_image_slideshow:** Product image carousels.
- **meta:** Annotations and type checking.
- **cupertino, material:** Platform-adaptive widgets.
- **Custom error/failure classes:** Strongly-typed error handling across the app.

---

## Project Structure

```
lib/
├── config/              # App configuration, themes, routes
├── core/                # Core utilities, API management, shared resources
│   ├── api/
│   ├── cache/
│   ├── components/
│   ├── error/
│   ├── network/
│   ├──  utils/
├── features/            # Feature modules (clean architecture separation)
│   ├── cart_screen/
│   ├── forget_password/
│   ├── login/
│   ├── onboarding/
│   ├── otp_screen/
│   ├── payment/
│   ├── product_details_screen/    
│   ├── reset_password_screen/    
│   ├── signup/          # Authentication flows
│   ├── tabs/          # Authentication flows
│   │    ├── home_tab/
│   │    ├── products_tab/
│   │    ├── settings_tab/
│   │    ├── wishlist_tab/
│   │    ├── home_layout.dart
├── services/            # Feature modules (clean architecture separation)
│   ├── dio_helper.dart/ 
├── main.dart            # App entry point
```

- **Each feature** is further split into:
    - `data/` (models, repositories, remote/local data sources)
    - `domain/` (entities, use cases, repository contracts)
    - `presentation/` (UI screens, widgets, blocs)

---


## How to Run

1. **Clone the Repository**
   ```bash
   git clone https://github.com/AntoniousEmadKamel/taswaq_app.git
   cd taswaq_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Dependency Injection Code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the Application**
   ```bash
   flutter run
   ```

---

## Notes

This project was designed and built from the ground up as a demonstration of:

- **Clean Architecture Mastery:**
    - Full separation of concerns, scalable and maintainable structure.
- **Advanced State Management:**
    - Bloc pattern at scale, handling complex UI and state flows.
- **API Integration & Error Handling:**
    - Thorough, resilient API calls with robust error reporting.
- **UI/UX Excellence:**
    - Polished, responsive, and adaptive UI for real-world use.
- **Professional Coding Standards:**
    - Strong typing, naming conventions, and documentation throughout.

If you are looking for a developer who can deliver **production-grade, scalable, and maintainable Flutter applications**, this project is the ultimate proof of my skills and attention to detail.

---

## Screenshots

<p align="center">

<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/splash.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/sign-in.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/sign-up.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/home.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/categories-men.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/Categories-women.png" width="120"/>
<br>
<br>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/product-list.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/product-details.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/cart.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/wishlist.png" width="120"/>
<img src="https://github.com/AntoniousEmadkamel/taswaq_app/blob/master/screenshoots/account.png" width="120"/>
</p>

---

## Contact

For collaboration, hiring, or inquiries, reach out via [GitHub](https://github.com/AntoniousEmadkamel).

---

**_Thank you for reviewing my work!_**
