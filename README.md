![CleanShot 2025-08-20 at 22 15 00](https://github.com/user-attachments/assets/8e7f1561-8229-458a-867f-5b24f2d6b145)

# Bouncy Presence SwiftUI

A SwiftUI recreation of the delightful bounce-and-shuffle animation when users join a conversation in Marco Polo.

## Overview

One of my favorite contributions at Marco Polo was the presence indicator you get when you send someone a Polo and they open the message right away to start watching it while you're still recording it. It feels really good to see the person's face bounce into view like that - in my opinion it's a perfect moment of "surprise and delight".

Originally I built the presence indicators using UIKit's Autolayout system, and a UIView spring animation. But since I don't work there and don't have access to the code, and for the fun of it, I remade it in SwiftUI.


### SwiftUI Simplicity

The SwiftUI version is quite simple:

- **HStack** for horizontal layout that automatically handles spacing and positioning
- **`.animation()`** modifiers for smooth spring animations
- **Declarative UI** that updates automatically when users join or leave


## Running the Project

Open `BouncyPresenceIndicators.xcodeproj` in Xcode and run on any iOS simulator or device. The app comes preloaded with sample users that you can add/remove to see the animation effects.
