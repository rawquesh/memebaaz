
# MemeBaaz - Memes & Short Videos App

Memebaaz is a Video/images Sharing App, Anyone can share short videos and images through app, the media will go through admin's approval.  


## Demo

[Play Store (30K+ Downloads)](https://play.google.com/store/apps/details?id=com.memebaaz.MemeBaaz) || [Direct Link](https://github.com/rawquesh/memebaaz/releases/download/apk/app-armeabi-v7a-release.apk)


## Screenshots

![App Screenshot](https://user-images.githubusercontent.com/27288409/185353359-5df6113a-6c3a-4fbd-845e-58d52d42f0af.png) 


## Features

- Like/Download/Share button
- Infinite Scroll
- Google Ads
- Local Save
- Categorized Menu
- Responsive Design
- Inbuild Admin Page
- Everyone can upload
- Cache Video/Image
- Media Compression (When uploading)
- Double Tap Like Effect Like Instagram
- Pagination, etc






## Tech Stack

**Client:** Flutter, Getx, Firebase SDK

**Server:** Firebase, Cloud Firestore, Cloud Storage


## Run Locally

Clone the project as you like

```bash
  gh repo clone rawquesh/memebaaz
```

Go to the project directory

```bash
  cd menebaaz
```

Install dependencies

```bash
  flutter pub get
```

## Connect firebase services

This project is connected to Firebase Auth, Firestore, Storage, Messages, etc:

- Create Firebase Project
- Add Android with Package Name: ```com.memebaaz.MemeBaaz```, App nickname: ```MemeBaaz```
- Add Firebase to the Project as official documentation

## Firestore Data Model

You will need to create few Collection/Documents to start the app

```json
{
  "config": {
    "categories": {
      "data": ["category 1", "category 2"] // categories
    },
    "keys": {
      "key": "12345" // Password for accessing admin page
    }
  },
  "content": [
    // Media Documents
  ]
}

```
![image](https://media.discordapp.net/attachments/729341849495666699/1009739494112636939/Screenshot_2022-08-18_134646.png)

## Authors

- [@rawquesh](https://www.github.com/rawquesh)


## Feedback

If you have any feedback, please reach out to us at [Twittter](https://twitter.com/rawquesh)


