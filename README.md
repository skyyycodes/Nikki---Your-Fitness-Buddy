
# Nikki

Nikki is a child superhero-themed fitness app designed to combat childhood obesity by engaging kids aged 4-12 in fun and interactive workouts. Through captivating storytelling and AI-driven interactions, Nikki encourages healthy habits and active lifestyles. **This project was developed for the Cognizant Digital Nurture Technoverse 2024 Hackathon by Team Believers**.


## Table of Contents

- [Introduction](##introduction)
- [Features](##features)
- [Tech Stack](##tech-stack)
- [Setup](##setup)
- [Usage](##usage)
- [Contributing](##contributing)
- [License](#license)

## Introduction


Nikki aims to solve the problem of childhood obesity by leveraging AI technology. Our app transforms fitness into a fun and interactive experience, encouraging children aged 4-12 to adopt healthy habits through engaging storytelling and personalized workout routines.
## Features
Nikki features a range of interactive and engaging elements to promote fitness and healthy habits among children:

1. **Interactive Storytelling**: Engaging narratives where Nikki, the superhero, motivates children to exercise through exciting adventures.
2. **Personalized Workout Recommendations**: AI-driven routines tailored to each child's fitness level and goals.
3. **Real-Time Voice Interaction**: Voice-activated features for hands-free navigation and interactive exercises.
4. **Progress Tracking and Rewards**: Track fitness achievements and earn rewards to motivate continued activity.
5. **Nutritional Guidance**: Age-appropriate dietary advice to complement physical activity.
6. **Gamification**: Fun challenges and games to make workouts enjoyable and engaging.
7. **Parental Insights**: Tools for parents to monitor their child's progress and set goals.
8. **Emotional Recognition**: AI that adapts interactions based on the child's mood to provide a supportive experience.
9. **Collaborative Challenges**: Group activities and competitions to encourage social interaction and teamwork.
10. **Dynamic Content Adaptation**: Customizable stories and workouts to keep content fresh and exciting.
11. **Behavior Analysis**: AI that learns and adapts to each child's preferences and habits to optimize engagement.
12. **Augmented Reality (AR) Integration**: AR features to make exercises more immersive and fun.
13. **Social Interaction**: Safe, moderated platform for children to connect and share their achievements.
14. **Stress and Relaxation Features**: Mindfulness exercises and relaxation techniques to support overall well-being.
## Tech Stack
The tech stack of Nikki encompasses a range of technologies to create a seamless and engaging user experience:

1. **Frontend**:
   - **Flutter**: For building the cross-platform mobile app (iOS and Android).
   - **Dart**: The programming language used with Flutter for app development.
   - **Dialogflow**: For integrating AI-driven voice interactions and chat functionalities.

2. **Backend**:
   - **Node.js**: For server-side scripting and handling API requests.
   - **Express.js**: For building the backend RESTful APIs.
   - **Firebase**: For real-time database, authentication, and cloud functions.

3. **AI & ML**:
   - **TensorFlow Lite**: For on-device machine learning to provide personalized workout recommendations and emotion recognition.
   - **Dialogflow**: For natural language processing and AI-driven interactions.
   - **OpenCV**: For computer vision tasks related to AR and activity recognition.

4. **Database**:
   - **Firestore (Firebase)**: For storing user data, progress tracking, and real-time updates.

5. **Cloud Services**:
   - **Google Cloud Platform (GCP)**: For hosting and scalable cloud functions.
   - **Firebase Cloud Messaging (FCM)**: For push notifications and real-time communication.

6. **APIs**:
   - **Nutritionix API**: For nutritional guidance and dietary advice integration.
   - **Google Maps API**: For location-based challenges and activities.

7. **Security**:
   - **OAuth 2.0**: For secure authentication and authorization.
   - **JWT (JSON Web Tokens)**: For secure user sessions.

8. **DevOps**:
   - **GitHub**: For version control and collaboration.
   - **CI/CD**: Continuous integration and continuous deployment pipelines for automated testing and deployment.

9. **AR Integration**:
   - **ARCore (Google)**: For augmented reality features and immersive experiences.

10. **Analytics**:
    - **Google Analytics**: For tracking user engagement and app performance.
    - **Firebase Analytics**: For in-depth analysis of user behavior and app usage patterns.
## Setup

To set up Nikki follow these steps:

### Prerequisites
1. **Flutter SDK**: Install Flutter SDK on your machine.
2. **Dart SDK**: Dart is bundled with the Flutter SDK.
3. **Android Studio** or **Xcode**: For Android and iOS development respectively.
4. **Visual Studio Code (VS Code)** or any preferred IDE: For code editing.
5. **Git**: To clone the repository.
6. **Firebase Account**: For backend services.
7. **Node.js** and **npm**: For backend server setup if applicable.
8. **Google Cloud Platform (GCP) Account**: For Dialogflow and other cloud services.
9. **API Keys**: Necessary keys for external APIs used in the app (e.g., Nutritionix, Google Maps).

### Step-by-Step Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/nikki.git
   cd nikki
   ```

2. **Install Flutter and Dart**:
   Ensure Flutter and Dart are installed and added to your PATH. Verify installation by running:
   ```bash
   flutter doctor
   ```

3. **Install Dependencies**:
   Navigate to the project directory and install the dependencies listed in `pubspec.yaml`:
   ```bash
   flutter pub get
   ```

4. **Setup Firebase**:
   - Create a Firebase project on the [Firebase Console](https://console.firebase.google.com/).
   - Add your app to Firebase (both iOS and Android if needed).
   - Download the `google-services.json` file for Android and place it in the `android/app` directory.
   - Download the `GoogleService-Info.plist` file for iOS and place it in the `ios/Runner` directory.
   - Enable necessary Firebase services (Authentication, Firestore, Cloud Messaging, etc.).

5. **Configure APIs**:
   - Obtain API keys for services like Nutritionix and Google Maps.
   - Add these keys to your project securely, e.g., using environment variables or secure storage in the app.

6. **Setup Dialogflow**:
   - Create a Dialogflow agent on the [Dialogflow Console](https://dialogflow.cloud.google.com/).
   - Integrate Dialogflow with your project by adding necessary credentials and configurations.

7. **Run the App**:
   - Connect your device or start an emulator.
   - Run the app using Flutter:
     ```bash
     flutter run
     ```
### Common Issues
- **Flutter SDK Issues**: Ensure the Flutter SDK is correctly installed and configured.
- **API Key Errors**: Double-check that all API keys are correctly added and configured.
- **Dependency Conflicts**: Ensure all dependencies are compatible and correctly installed.
- **Firebase Configuration**: Ensure the Firebase `google-services.json` and `GoogleService-Info.plist` files are in the correct directories and properly configured.
## Usage

1. **Open the Application**:
   - Launch the Nikki app on your mobile device.

2. **Sign Up or Log In**:
   - Create a new account or log in using your existing credentials.

3. **Explore the Home Page**:
   - Navigate through the home page to find various features and activities.

4. **Engage in Interactive Workouts**:
   - Participate in fun and engaging workout sessions guided by Nikki.

5. **Track Your Progress**:
   - Use the progress tracker to monitor your fitness achievements and set new goals.

6. **Receive Personalized Recommendations**:
   - Get AI-driven workout and nutritional recommendations tailored to your needs.

7. **Join Challenges and Games**:
   - Take part in fitness challenges and games to stay motivated and have fun.

8. **Utilize Voice Interaction**:
   - Use voice commands to interact with Nikki and navigate through the app hands-free.

9. **Access Nutritional Guidance**:
   - Explore age-appropriate dietary advice to complement your fitness routine.

10. **Check Your Profile**:
    - View your stats, daily tasks, collectibles, and activity logs on your profile.

11. **Connect with Friends**:
    - Join collaborative challenges and interact with friends within the app.

12. **Earn Rewards**:
    - Earn rewards and badges for completing workouts and achieving milestones.
## Contributing


We welcome contributions from the community. Please follow these steps to contribute:

1. **Fork the Repository**:
   - Fork the Nikki repository on GitHub to your own account.

2. **Create a New Branch**:
   - Create a new branch for your feature or bugfix:
     ```bash
     git checkout -b feature-or-bugfix-name
     ```

3. **Commit Your Changes**:
   - Make your changes and commit them with a descriptive message:
     ```bash
     git add .
     git commit -m "Description of your changes"
     ```

4. **Push the Branch to Your Fork**:
   - Push your branch to your forked repository:
     ```bash
     git push origin feature-or-bugfix-name
     ```

5. **Open a Pull Request**:
   - Open a pull request to the main Nikki repository, providing a clear description of your changes and any relevant information.

By following these steps, you can contribute to making Nikki even better!
