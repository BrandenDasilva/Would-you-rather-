# Would You Rather App - Feature Documentation

## App Overview
A fun, engaging web app that presents "Would You Rather" questions to help users relax and have fun conversations. Works on any device, especially optimized for iPhone Safari.

## Core Features

### 1. Question Display
- **Main Screen**: Displays a single "Would You Rather" question with two options
- **Visual Design**: 
  - Gradient background (purple to blue)
  - Two distinct colored buttons (pink and cyan)
  - Large, readable text
  - Smooth animations on selection
- **Interaction**:
  - Tap to select an option
  - Selected option scales up and glows
  - Submit button appears after selection

### 2. Response Tracking
- **Statistics Collected**:
  - Total responses per question
  - Percentage breakdown for each option
  - Individual vote counts
- **Data Persistence**:
  - All data saved locally using localStorage
  - Persists between browser sessions
  - Automatic save on every response

### 3. Results Display
- **After Submission**:
  - Shows how everyone voted
  - Visual progress bars for each option
  - Percentage and vote count display
  - Auto-advances to next question after 3 seconds
- **Color-Coded**: 
  - Option A results in pink
  - Option B results in cyan

### 4. Question History
- **Accessible via**: Clock icon in navigation bar
- **Shows**:
  - All previously answered questions
  - Current voting statistics for each
  - Sorted by popularity (most responses first)
- **Empty State**: Friendly message when no questions answered yet

### 5. Smart Question Management
- **No Repeats**: Questions won't repeat until all have been asked
- **Auto-Cycling**: Automatic reset when all questions exhausted
- **Random Selection**: Questions appear in random order
- **State Tracking**: Tracks which questions have been asked

### 6. Reset Functionality
- **Access**: Counter-clockwise arrow in navigation bar
- **Safety**: Confirmation modal before resetting
- **Action**: Clears all statistics and response history
- **Warning**: Includes clear message about data loss

## Question Categories

The app includes 50+ questions across various themes:

1. **Superpowers**: Flight vs invisibility, time travel vs teleportation
2. **Lifestyle Choices**: Living situations, personal preferences
3. **Silly Dilemmas**: Absurd but fun scenarios
4. **Philosophical**: Thought-provoking choices
5. **Daily Life**: Practical but interesting trade-offs
6. **Fantasy**: Magical and fantastical options

## Technical Architecture

### Data Models
- **Question**: ID, options, response counts, asked status
- **QuestionManager**: Class managing all app state and logic

### State Management
- **localStorage**: Browser-based persistence
- **Reactive Updates**: Immediate UI updates on state changes

### UI Components
- **Main View**: Question display and interaction
- **History View**: Question history with statistics
- **Modal**: Confirmation dialog for reset
- **Animations**: Smooth transitions and visual feedback

## User Experience Flow

1. **Launch**: App loads, presents first random question
2. **Selection**: User taps preferred option (visual feedback)
3. **Submit**: User confirms choice
4. **Results**: View voting statistics for 3 seconds
5. **Next**: New question automatically appears
6. **History**: Access past questions anytime via history button
7. **Reset**: Option to start fresh with confirmation

## Design Principles

- **Escapism**: No current events or negative topics
- **Fun**: Engaging, entertaining questions
- **Simple**: Intuitive interface, minimal steps
- **Visual**: Colorful, gradient backgrounds
- **Smooth**: Animations and transitions throughout
- **Safe**: Confirmation for destructive actions
- **Mobile-First**: Optimized for touch interactions

## Mobile Optimizations

- **Touch-Friendly**: Large tap targets
- **Responsive**: Adapts to all screen sizes
- **Fast**: No external dependencies
- **Offline**: Works without internet after first load
- **PWA Ready**: Can be added to home screen

## No Internet Required

All functionality works offline:
- Questions pre-loaded in JavaScript
- Local data storage
- No external API calls
- No user accounts needed

## Privacy

- All data stays on device (localStorage)
- No personal information collected
- No analytics or tracking
- No data sharing
- No cookies

## Installation as App

### iPhone/iPad
1. Open in Safari
2. Tap Share button
3. Select "Add to Home Screen"
4. App icon appears on home screen

### Android
1. Open in Chrome
2. Tap menu (3 dots)
3. Select "Add to Home screen"
4. App icon appears on home screen

This design ensures users can enjoy the app anytime, anywhere, on any device without worries!

