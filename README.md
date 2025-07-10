# Vocabulary App 📚

A SwiftUI vocabulary learning app with onboarding flow and word swiping interface. Built for iPhone SE compatibility.

## Features

✅ **What's Built:**
- Onboarding flow (Goals & Topics selection)
- Word learning with swipe gestures (5 words looping)
- iPhone SE responsive design
- Smooth animations and haptic feedback

❌ **What's Excluded:**
- Notifications, app icons, premium features, widgets
- Share, speech, favorite, save buttons
- Bottom navigation (categories, practice, settings)

## Personal Touch
**Mark Learned Vocabulary** - A Button to check that you study this vocabulary good and ready to move to the next one.

## Setup

```bash
git clone https://github.com/ziadali22/Vocabulary.git
cd Vocabulary
open Vocabulary.xcodeproj
```

**Requirements:** Xcode 15.0+, iOS 15.0+

## Project Structure
```
Vocabulary/
├── App/
    ├──VocabularyApp/
├── Core/
    ├──Audio/
    ├──DesignSystem/
    ├──Extentions/
    ├──Haptic/
    ├──ScreenSize/
├── Dashboard/
    ├──Domain/
    ├──Data/
    ├──Presentation/
├── OnBoarding/
    ├──Domain/
    ├──Data/
    ├──Presentation/
├── Intro/
    ├──Domain/
    ├──Data/
    ├──Presentation/
└── Resources/
```

## Task Analysis

**🔴 Feature Spoiling UX:**
- **Problem:** Too many onboarding steps causing user drop-off
- **Solution:** Reduced to 3 essential steps for faster completion

**🟢 Missing Feature:**
- **Gap:** No learning progress tracking
- **Solution:** Added smart Levels from one to 21 Level and add badges for every level and visual progress indicators

---
**Built with SwiftUI | iPhone SE Optimized | Clean Code Focus**
