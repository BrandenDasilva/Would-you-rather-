# Would You Rather? 🤔

A fun and engaging iOS app that asks "Would You Rather" questions to help you forget about the day's bad news and have a good time!

## Features

✨ **Engaging Questions** - 50+ carefully crafted questions that are fun, silly, thought-provoking, and entertaining
- Questions range from silly ("Fight one horse-sized duck or 100 duck-sized horses?") to thought-provoking ("Have the ability to fly or become invisible?")
- No questions related to current events or bad news - purely escapist fun!

📊 **Response Tracking** - See how everyone else answered
- Track responses for each question
- View percentage breakdowns of choices
- See total vote counts

📝 **Question History** - Never lose track of past questions
- View all previously asked questions
- See aggregate results from all users
- Questions are sorted by popularity

🔄 **Smart Question Management**
- Questions never repeat until all have been asked
- Automatic cycling through the question pool
- Reset functionality to start fresh

🎨 **Beautiful UI**
- Modern SwiftUI interface with gradient backgrounds
- Smooth animations and transitions
- Intuitive button interactions
- Clean, colorful design

## How It Works

1. The app presents you with a "Would You Rather" question with two options
2. Select your preferred option
3. Submit your choice to see how everyone else voted
4. Results are displayed with percentages and vote counts
5. A new question appears automatically after viewing results
6. Access question history anytime via the history button

## Technical Details

- **Platform**: iOS 15.0+
- **Language**: Swift
- **Framework**: SwiftUI
- **Data Persistence**: UserDefaults for local storage
- **Architecture**: MVVM pattern with ObservableObject

## Project Structure

```
WouldYouRather/
├── WouldYouRatherApp.swift    # App entry point
├── ContentView.swift           # Main question view
├── HistoryView.swift           # Question history view
├── Question.swift              # Data models
├── QuestionManager.swift       # Business logic & data management
└── Assets.xcassets/            # App assets
```

## Getting Started

1. Open `WouldYouRather.xcodeproj` in Xcode
2. Select your target device (iPhone simulator or physical device)
3. Build and run the project (⌘ + R)
4. Start answering fun questions!

## Requirements

- Xcode 14.0 or later
- iOS 15.0 or later
- macOS for development

---

Made with ❤️ to bring joy and fun conversations to your day!
