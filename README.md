# Overview
A Google Maps clone made with Flutter. Designed with a modular architecture to make it easy to add new features.

# Platforms
* iOS

# Screenshots
<img src="https://user-images.githubusercontent.com/25019832/209843673-23e80b62-1ef0-4818-aecd-a50ab85cd7a3.png" width="200"/>
<img src="https://user-images.githubusercontent.com/25019832/209843689-e3b98a51-f050-43e5-a3b0-88a397d2fbff.png" width="200"/>
<img src="https://user-images.githubusercontent.com/25019832/209843704-4325ab92-531e-4e8e-ba8d-5d07cddb3a6d.png" width="200"/>
<img src="https://user-images.githubusercontent.com/25019832/209843727-9f783b41-4a5e-42fe-9860-ef50ffef159a.png" width="200"/>
<img src="https://user-images.githubusercontent.com/25019832/209843738-8e18a3e5-ba87-44ff-8741-e0971248f946.png" width="200"/>

# Setup
1. Setup location permissions by following steps [here](https://pub.dev/packages/location).
2. Setup a Firebase project by following steps [here](https://firebase.google.com/docs/flutter/setup?platform=ios).
3. Setup Google Auth by following the steps [here](https://pub.dev/packages/google_sign_in).
4. Setup Google Maps [here](https://pub.dev/packages/google_maps_flutter).
   1. Create a `.env` file and fill in your `GOOGLE_MAPS_KEY`.

# Feature List
* Sign in With Google
* Account storage in Firebase
* Google Maps Location Search
* Google Maps Directions

# Architecture
The app uses the bootstrap design pattern along with a feature-oriented design (each subfolder under `lib/` represents a feature). Some features are simply used by others such as `nav` while others are visible to the end user. Each feature in `lib/*` contains a [barrel file](https://adrianfaciu.dev/posts/barrel-files/) with the same name as the feature (i.e. `lib/feature/feature.dart`).

## Boostrap
The entrypoint for this app is contained in the `core` feature. The development entrypoint is at `lib/core/main_dev.dart`. A bootstrap approach is utilized to ensure dependencies are ready before the app starts. The necessary APIs and associated repositories are intialized in `bootstrap()` and the resulting repositories are stored in `RepositoryProvider` in `lib/core/app/app.dart`. BLoCs that are needed across the entire application are also initialized in `AppView` located at `lib/core/app/app.dart`.

## Features
Each feature can contain any of the following:
* API: These modules communicate directly external resources. They are implemented as independent Flutter packages and their location is `packages/*_api`. There is an abstract interface for each API as well as an implementation that prefixes the name with the source it connects to. For example, the `profile` feature contains an abstract API at `packages/profile_api` as well as a Firebase implementation of the API at `packages/firebase_profile_api`.
* Repository: These modules connect directly to its associated API and can optionally mutate or process raw API data. They are implemented as independent Flutter packages and their location is `packages/*_repository`. The `auth` repository is at `packages/auth_repository` for example.
* BLoC: This project relies on the BLoC (Business LOgic Component) Flutter package to handle state changes in repositories. They connect directly to their associated repository and are located at `lib/*/bloc/`. Each BLoC's states and events are located in this folder.
* View: Features that display to the end user are located at `lib/*/view/`.

### assets
This feature is reposible for loading assets located in the `assets` folder.

### auth
This feature provides user authentication and is currently handled by Firebase. State changes are handled by the `authStateChanges()` stream.

### core
This feature provides an entrypoint for the app and handles bootstrapping of dependencies and any global objects that are needed across the app. See the Entrypoint section for more info.

### home
Provides a home page for the app which essentially is just the `HomeMapView` and a navigation drawer.

### home_map
Contains a map view for the homepage that shows vehicles in the area.

### location
Provides a device location using the third party [location](https://pub.dev/packages/location) package.

### location_search
Allows the user to search for locations using the Google Places API. Currently is not used but should be connected to the `parking_search` feature to allow users to first search for a location, then view nearby parking spots.

### map
Contains `MapView` that uses the `google_maps_flutter` package to display a map. This is used by the `home_map` feature.

### nav
Provides navigation directions using the Google Directions API.

### profile
Provides a profile page for the user to view their profile and sign out.

### theme
Contains global app theming data.

# Dependencies
There are a few pub.dev dependencies that are used throughout the app. They are listed below:
* `built_value`: Used for object de/serialization in various APIs. It is a little cumbersome to setup but is scalable and resilient to changes.
* `bloc`: Used for state management across the app.
* `google_maps_flutter`: Provides all map views in the app. The `map` feature is essentially a wrapper around this package.
