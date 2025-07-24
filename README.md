# Dog + Cat & I 🐕🐱

A modern iOS application built with **Clean Swift (VIP) Architecture** that showcases different API integration patterns and concurrent network operations.

## 🏗️ Architecture

### Architecture Components

Each scene follows the Clean Swift pattern with these 6 core files:
- **Models.swift** - Request/Response/ViewModel structs
- **ViewController.swift** - UI logic and user interactions
- **Interactor.swift** - Business logic and data processing
- **Presenter.swift** - Data formatting for display
- **Router.swift** - Navigation and scene transitions
- **Worker.swift** - External API calls and data fetching


## 📱 Features

### 🐕 Dogs Scene
- **Single Image Fetch** - Load individual dog images
- **Concurrent Fetching** - Load multiple images simultaneously using `TaskGroup`
- **Sequential Fetching** - Load images with configurable delays
- **Real-time Performance** - Compare concurrent vs sequential approaches

### 🐱 Cats Scene
- **Cat Breeds API** - Fetch comprehensive cat breed information
- **Expandable UI** - Collapsible breed details with smooth animations
- **Pagination Support** - Handle large datasets efficiently
- **Error Handling** - Graceful fallbacks for network issues

### 👤 Me Scene
- **Random User API** - Generate random user profiles
- **Rich User Data** - Name, location, contact info, profile pictures
- **Data Formatting** - Formatted dates, addresses, and contact details
- **Gender Icons** - Visual gender representation

## 🛠️ Technologies & Libraries

### Core Dependencies
- **Swift 5.9+** - Modern Swift with async/await
- **iOS 15.0+** - Latest iOS features and APIs
- **Xcode 15.0+** - Latest development tools

### Networking
- **Alamofire 5.x** - HTTP networking library

### UI & Image Loading
- **SDWebImage** - Efficient image loading and caching
- **SDWebImageMapKit** - Map integration support
- **UIKit** - Native iOS UI framework
- **Storyboards** - Interface Builder for UI design

### Development Tools
- **netfox** - Network debugging and inspection
- **Swift Package Manager** - Dependency management

## 📁 Project Structure

```
Dog + Cat & I/
├── AppDelegate.swift
├── SceneDelegate.swift
├── Core/
│   ├── Components/
│   │   └── LoadingOverlay/
│   └── Extension/
│       ├── UIImageExtension.swift
│       ├── UIImageViewExtension.swift
│       └── UIViewControllerExtension.swift
├── Network/
│   └── Models/
│       ├── Cats/Responses/
│       ├── Dogs/Responses/
│       └── Me/Responses/
├── Scenes/
    ├── Cats/
    │   ├── CatsViewController.swift
    │   ├── CatsInteractor.swift
    │   ├── CatsPresenter.swift
    │   ├── CatsRouter.swift
    │   ├── CatsWorker.swift
    │   ├── CatsModels.swift
    │   └── View/
    ├── Dogs/
    │   ├── DogsViewController.swift
    │   ├── DogsInteractor.swift
    │   ├── DogsPresenter.swift
    │   ├── DogsRouter.swift
    │   ├── DogsWorker.swift
    │   ├── DogsModels.swift
    │   └── View/
    └── Me/
        ├── MeViewController.swift
        ├── MeInteractor.swift
        ├── MePresenter.swift
        ├── MeRouter.swift
        ├── MeWorker.swift
        └── MeModels.swift
```

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0 or later
- iOS 15.0+ deployment target
- Swift 5.9+

### Installation
1. Clone the repository
```bash
git clone <repository-url>
cd "Dog + Cat & I"
```

2. Open the project in Xcode
```bash
open "Dog + Cat & I.xcodeproj"
```

3. Build and run
- Press `Cmd + R` to build and run
- Or select a simulator and click the Run button

## 🔧 API Endpoints

### Cats API (catfact.ninja)
- **Endpoint**: `https://catfact.ninja/breeds`
- **Method**: GET
- **Response**: Cat breed information with pagination

### Dogs API (dog.ceo)
- **Endpoint**: `https://dog.ceo/api/breeds/image/random`
- **Method**: GET
- **Response**: Random dog image URLs

### Random User API (randomuser.me)
- **Endpoint**: `https://randomuser.me/api/`
- **Method**: GET
- **Response**: Random user profile data
