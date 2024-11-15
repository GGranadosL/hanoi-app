# Tower of Hanoi Solver App

An **iterative** Tower of Hanoi solver with a **SwiftUI** frontend and a **TypeScript** backend hosted on **Google Cloud Functions**. This application efficiently computes and displays the sequence of moves required to solve the Tower of Hanoi puzzle for a specified number of disks.

## Table of Contents

- [Features](#features)
- [Performance Overview](#performance-overview)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Deployment](#deployment)
- [Usage](#usage)
- [Limitations](#limitations)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

- **Recursive Algorithm**: Utilizes an efficient recursive approach to solve the Tower of Hanoi puzzle without the drawbacks of recursion.
- **SwiftUI Frontend**: Offers a modern, responsive user interface for iOS devices.
- **TypeScript Backend**: Ensures type safety and maintainability in the backend logic.
- **Serverless Deployment**: Hosted on Google Cloud Functions for scalability and reduced infrastructure management.
- **Performance Metrics**: Displays execution time, number of moves, and memory usage for different disk counts.
- **Error Handling**: Gracefully handles invalid inputs and server errors with informative messages.

## Performance Overview

| Number of Disks | Execution Time       | Number of Moves           | Memory Usage       |
|-----------------|----------------------|---------------------------|--------------------|
| 5               | 0.048 seconds        | 31                        | ~1.32 KB           |
| 10              | 0.055 seconds        | 1,023                     | ~34.25 KB          |
| 19              | 3.86 seconds         | 524,287                   | ~17 MB             |
| 20              | ~32.1 seconds         | 1,048,575                 | ~34.1 MB           |
| 30              | ~9.13 hours          | 1,073,741,823             | ~34.1 GB           |
| 40              | ~388 days            | 1,099,511,627,775         | ~33.3 TB           |
| 50              | ~1,218 years          | 1,125,899,906,842,623     | ~33,332 TB         |

> **Note**: Execution times and memory usage increase exponentially with the number of disks due to the nature of the problem.

## Architecture

- **SwiftUI App**: Frontend that captures user input and displays results.
- **Google Cloud Functions**: Backend that processes the iterative algorithm and returns the sequence of moves.
- **Data Flow**:
  - User Input ➔ API Request ➔ Compute Moves ➔ API Response ➔ Display Moves

## Tech Stack

- **Frontend**:
  - **SwiftUI**: For building a responsive and intuitive user interface on iOS devices.
- **Backend**:
  - **TypeScript**: For writing type-safe and maintainable server-side code.
  - **Google Cloud Functions**: For deploying serverless backend functions.
- **Others**:
  - **Firebase Functions**: Seamless integration with Google Cloud Functions.
  - **CORS**: Handling Cross-Origin Resource Sharing in HTTP requests.

## Getting Started

### Prerequisites

- **Frontend**:
  - **Xcode** (version 12 or later) with SwiftUI support.
- **Backend**:
  - **Node.js** (version 14 or later)
  - **npm** or **yarn**
  - **Firebase CLI**: For deploying Cloud Functions.
- **Google Cloud Account**: With billing enabled for deploying Cloud Functions.

### Installation

#### Frontend Setup

- **Open the SwiftUI Project**

  - Navigate to the frontend directory:

    ```bash
    cd ../HanoiSolverApp
    ```

  - Open the project in Xcode:

    ```bash
    open HanoiSolverApp.xcodeproj
    ```

- **Configure API Endpoint**

  - In the SwiftUI project, locate the file where the API endpoint is defined.
  - Update the endpoint URL to point to your deployed Google Cloud Function.

## Usage

- **Launch the App**

  - Run the SwiftUI app on an iOS simulator or physical device from Xcode.

- **Input Number of Disks**

  - Enter the desired number of disks in the provided input field.

- **Solve the Puzzle**

  - Tap the "Solve" button to initiate the computation.
  - The app will display the sequence of moves required to solve the puzzle.

- **View Results**

  - Observe the execution time, number of moves, and memory usage displayed.

## Limitations

- **Performance Constraints**: Solving the puzzle with a large number of disks may result in long computation times and high memory usage.
- **Resource Usage**: High disk counts can exceed typical device or server capabilities due to exponential growth in required resources.
- **Server Limits**: Google Cloud Functions have execution time and memory usage limits that may be exceeded with very large inputs.

## License

N/A

## Contact

- **Author**: Gerardo Granados Lopez
- **Email**: [gerardo.email@example.com](mailto:gerardo.email@example.com)
- **LinkedIn**: [Your LinkedIn Profile](https://www.linkedin.com/in/yourprofile)
