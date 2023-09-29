---

# 🚀 MemeBaaz - The Ultimate Memes & Short Videos App 

MemeBaaz is your one-stop destination for sharing video clips and images 📸. All submissions go through an admin approval process to maintain the quality of content. 

---

## 🌟 Demo

👉 [Play Store (30K+ Downloads)](https://play.google.com/store/apps/details?id=com.memebaaz.MemeBaaz)   
👉 [Direct APK Download](https://github.com/rawquesh/memebaaz/releases/download/apk/app-armeabi-v7a-release.apk)

---

## 📸 Screenshots

![App Screenshot](https://user-images.githubusercontent.com/27288409/185353359-5df6113a-6c3a-4fbd-845e-58d52d42f0af.png)

---

## ✨ Features

- 👍 Like/Download/Share Options
- 📜 Infinite Scrolling
- 💰 Google Ad Integration
- 💾 Local Save Functionality
- 📚 Categorized Menu
- 📲 Responsive Design
- 👮‍♂️ In-built Admin Page
- 📥 User Uploads Enabled
- 🗃️ Media Caching
- 🔄 Media Compression On Upload
- ❤️ Double Tap Like (Instagram-style)
- ⏩ Pagination

---

## 🛠️ Tech Stack

**Client:** Flutter, Getx, Firebase SDK  
**Server:** Firebase, Cloud Firestore, Cloud Storage

---

## 💻 Run Locally

1️⃣ Clone the repo
```bash
gh repo clone rawquesh/memebaaz
```

2️⃣ Navigate to project directory
```bash
cd memebaaz
```

3️⃣ Install dependencies
```bash
flutter pub get
```

---

## 🔥 Firebase Setup

This project uses Firebase services like Auth, Firestore, Storage, and Messages:

- Create a new Firebase project
- Add Android config with Package Name `com.memebaaz.MemeBaaz` and App Nickname `MemeBaaz`
- Follow Firebase official documentation for setup

---

## 📦 Firestore Data Model

To set up the Firestore, use the following schema:

```json
{
  "config": {
    "categories": {
      "data": ["category 1", "category 2"]
    },
    "keys": {
      "key": "12345"
    }
  },
  "content": [
    // Add your media docs here
  ]
}
```

---

## 👥 Authors

- [@rawquesh](https://www.github.com/rawquesh)

---

## 📝 Feedback

Love the app? Have suggestions? 💌  
Feel free to reach out to us on [Twitter](https://twitter.com/rawquesh).

---
