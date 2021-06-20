# XTrack
## Inspiration
For the past 1.5 years, we have been experiencing unprecedented times due to Covid-19. COVID-19 is a rapidly evolving virus that has a high reproduction rate of 5.7. This means that for every one person infected they will infect between 5 to 6 others. I decided to focus on this problem while trying to preserve every user's privacy through anonymity to improve our user participation.

## What it does
My app allows people to stay safe and be notified of a “covid-19 risk” in their specific area. This app also provides information to the public about the potential repercussions of traveling to a specific location, such as a store, office, or other major points of contact within our community. It can also give recommendations on quarantine periods based on any contact with an infected user. Furthermore, my app has posts from the CDC and WHO to further educate the users on the covid-19 virus itself. I believe this would help mitigate Covid 19 by reducing the spread and educating more people about the virus. The features of my app include news, QR contract tracing, Anonymous tracing/reporting, Symptom reporting, Risk assessments, and local notifications.
User Experience: Users enter a location by scanning a QR (if the location does not have one, the user can make a QR), and then, it will take you to the Location Stats page. Here, the user can see Risk Assessment (using Breadth-First Algorithm and # of cases), Number of Cases this week, and Number of People. By clicking the enter button, the user is added to the statistics. The user can report themselves by filling out the Feeling Sick form and then my gamified algorithm decides the Risk assessment and Quarantine date. In addition, if a user enters a high-risk place, it gives an alert to the user. Once a user leaves the location, he/she can exit the place in the app and pick the specific time he/she left to maintain accuracy with contract tracing within a specific time period. If you were in the proximity of an infected user, you will receive a notification in the Notifications section on the Updates page in real-time. If both users were in a location together in the past at the same or overlapped time, the user gets notified because the other user has tested positive. Notifications are calculated through the form and entering/exiting locations.

## How we built it
This application was created in the XCODE environment using the SWIFT programming language. This provided us with Apple application standards and industry-grade design. I used Firebase for our back-end database to store data in the cloud and to provide additional server support while directly talking to the UI in Xcode for real-time updates and data passage. This data is used to make predictions and track statistics. I started by building the architecture (Models and Views) and then worked on each file at a time, finishing a feature before starting another one.

## Challenges we ran into
XCode Bugs
Push Notifications (when the app is offline)
Observable Objects
Short Time frame

## Accomplishments that we're proud of
Building functional UI that connects with Firebase in real-time
Created functioning app with lots of features
Learning and applying software skills in Xcode/Firebase Environment


## What we learned
Learned XCode (SwiftUI) and Firebase (Cloudstore database) functionalities
Wireframing App in XCode
Developing Real-Time updates (Observable Objects)


## What's next for XTrack
Expanding platform to more users
Implementing on Local Basis
Our app be tested in real-life situations
Adding real-time news
Add more ways of reporting other users and complete push notifications functionality
