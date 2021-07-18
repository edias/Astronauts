# Astronauts

A small and very simple app that displays a list of astronauts and their profiles.

## Getting Started

Just download the project on the following URL https://github.com/edias/Astronauts/archive/refs/heads/main.zip and unzip the file.

### Prerequisites

The only requirement is XCode 12.5.1

### Installing

Open Astronauts.xcodeproj and run the project on a device or simulator.

### Theming

Support Dark and Light mode.

## Scenarios

These are four possible scenarios.

### Success Scenario

Just run the app on any device or simulator until you can see the list of astronauts. Tap in any astronaut and you should see its profile.

### Network Offline Scenario with Error on the astronaut list

Close the app from the device or simulator, turn off the internet connection and run the app again. You should see a network offline connection page.

From that, you can just turn on the internet connection and tap the try again button. That should take the app to the success scenario.

### Network Offline Scenario with Error on the astronaut profile

On the astronaut list, turn off the internet connection and tap in one of the astronauts. You should see a network offline connection page on the comments page.

From that, you can just turn on the internet connection and tap the try again button. That should display the profile again.

### Network requests limit reached

This issue is intermittent and happens from time to time due to constraints on the number of network requests. The app is handling this scenario and you should see an error page indicating the problem. Unfortunately, there's no much we can do on the client-side to address this problem. The best way to go around is to wait a couple of minutes and try again later.

## Running the tests

Just go to test navigator on XCode and run AstronautsTests. This target contains all unit tests including network services, ViewModels, Serializer, NetworkStatusHandler and Error handlers test classes.
