# Khode Expense App

A modern expense tracking and budget management application built with Flutter.

## Features

- **Splash Screen**: Animated introduction screen with app logo and smooth transitions
- **Dashboard**: Overview of financial data with recent transactions and budget summary
- **Transactions**: Track expenses and income with detailed transaction history
- **Budget**: Set and manage budgets for different expense categories  
- **Reports**: Visualize spending patterns and financial trends
- **Profile**: User profile and app settings

## Project Structure

The project follows a clean architecture pattern with the following directory structure:

```
lib
├─┬─ ui
│ ├─┬─ core
│ │ ├─┬─ themes
│ │ │ ├─── app_colors.dart
│ │ │ ├─── app_theme.dart
│ │ │ └─── app_typography.dart
│ │ └─┬─ widgets
│ │   └─── <shared widgets>
│ ├─┬─ splash
│ │ └─── animated_splash_screen.dart
│ ├─┬─ auth
│ │ └─── login_screen.dart
│ ├─┬─ dashboard
│ │ ├─── dashboard_screen.dart
│ │ └─┬─ widgets
│ │   ├─── budget_overview_list.dart
│ │   ├─── monthly_summary.dart
│ │   ├─── recent_transactions_list.dart
│ │   └─── section_header.dart
│ ├─┬─ transactions
│ │ ├─── transactions_screen.dart
│ │ ├─── transaction_detail_screen.dart
│ │ ├─── create_transaction_screen.dart
│ │ └─┬─ widgets
│ │   ├─── transaction_header.dart
│ │   ├─── transaction_item.dart
│ │   └─── <other widgets>
│ ├─┬─ budget
│ │ ├─── budget_screen.dart
│ │ ├─── category_detail_screen.dart
│ │ └─┬─ widgets
│ │   ├─── budget_header.dart
│ │   ├─── category_list_item.dart
│ │   └─── <other widgets>
│ ├─┬─ reports
│ │ └─── reports_screen.dart
│ ├─┬─ profile
│ │ ├─── profile_screen.dart
│ │ └─┬─ widgets
│ │   ├─── profile_header.dart
│ │   ├─── profile_stats.dart
│ │   └─── <other widgets>
│ └─┬─ main
│   └─── main_nav.dart
├─┬─ data
│ ├─┬─ repositories
│ │ └─── <repository classes>
│ ├─┬─ services
│ │ ├─── auth_service.dart
│ │ └─── <other service classes>
│ └─┬─ models
│   └─── <data models>
├─┬─ routing
│ ├─── app_router.dart
│ ├─── route_constants.dart
│ └─── router_config.dart
├─┬─ utils
│ └─── <utility functions>
├─┬─ config
│ └─── <app configuration>
└─── main.dart
```

## Navigation

The app uses GoRouter for navigation with the following structure:

- **Main Navigation**: A bottom navigation bar for switching between main features (Dashboard, Transactions, Budget, Profile)
- **Nested Routes**: Transaction details and editing screens are implemented as nested routes
- **Animation**: Smooth transitions between screens with proper state preservation

### Navigation Structure

```
/splash                     - Splash Screen
/login                      - Login Screen
/                           - Main Navigation (with bottom tabs)
/dashboard                  - Dashboard Screen
/transactions               - Transactions List
/transactions/:id           - Transaction Detail
/transactions/:id/edit      - Edit Transaction
/transactions/create        - Create Transaction
/budget                     - Budget Screen
/budget/category/:id        - Category Detail
/profile                    - Profile Screen
/reports                    - Reports Screen
```

## Theming

The app uses a dark theme with the following color palette:

- **Primary**: Cyclamen (#F266AB)
- **Secondary**: Pastel Orange (#FFB84C)
- **Tertiary**: Amethyst (#A459D1)
- **Background**: Dark (#121212)
- **Card Background**: Dark Gray (#1E1E1E)

Application styling is defined in the `ui/core/themes` directory.

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Dependencies

- **flutter**: Core framework
- **go_router**: Advanced navigation
- **provider**: State management

## Screenshots

(Coming soon)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Copyright (c) 2025 Thorn Chorn
