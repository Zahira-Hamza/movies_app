# 🎬 CineMate — Movie Discovery App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Hive](https://img.shields.io/badge/Hive-FF7F00?style=for-the-badge&logo=hive&logoColor=white)
![TMDB](https://img.shields.io/badge/TMDB%20API-01D277?style=for-the-badge&logo=themoviedatabase&logoColor=white)
![REST API](https://img.shields.io/badge/REST%20APIs-FF6C37?style=for-the-badge&logo=postman&logoColor=white)

A feature-rich movie discovery app powered by the TMDB API — browse trending films, watch trailers, save watchlists offline, and search across thousands of titles.

</div>

---

## ✨ Features

- 🔥 **Trending & Popular** — Discover trending, popular, and top-rated movies powered by TMDB API
- 🎞️ **Trailer Playback** — Watch official trailers directly inside the app via YouTube integration
- 💾 **Offline-First** — Save movies to your watchlist using Hive for access without internet
- ⭐ **User Ratings** — Rate movies and keep track of your personal scores
- 🔍 **Advanced Search** — Search by title with filters for genre, release year, and rating
- 📄 **Movie Detail Page** — Full cast, overview, runtime, genres, and similar movies
- 🌙 **Smooth UI** — Fluid animations and transitions for a cinema-like experience

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|-----------|
| UI Framework | Flutter |
| Language | Dart |
| State Management | Provider / setState |
| Movie Data API | TMDB (The Movie Database) |
| Networking | REST APIs (HTTP) |
| Offline Storage | Hive |
| Video Playback | youtube_player_flutter |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`
- A free API key from [themoviedb.org](https://www.themoviedb.org/settings/api)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Zahira-Hamza/movies_app.git

# 2. Navigate into the project
cd movies_app

# 3. Install dependencies
flutter pub get

# 4. Add your TMDB API key
# Open lib/core/constants/api_constants.dart and replace:
# const String tmdbApiKey = 'YOUR_API_KEY_HERE';

# 5. Run the app
flutter run
```

---

## 📁 Project Structure

```
lib/
├── core/               # Constants, themes, API keys
├── models/             # Movie, Genre, Cast models
├── services/           # TMDB API service
├── repositories/       # Data access layer
├── screens/
│   ├── home/           # Trending, Popular, Top Rated
│   ├── search/         # Search with filters
│   ├── detail/         # Movie detail & trailer
│   └── watchlist/      # Offline saved movies (Hive)
└── widgets/            # Reusable movie cards, loaders
```

---

## 📸 Screenshots

> *Coming soon — screenshots will be added here*

---

## 👩‍💻 Author

**Zahira Hamza** — Flutter Developer
- GitHub: [@Zahira-Hamza](https://github.com/Zahira-Hamza)
- LinkedIn: [zahira-hamza](https://linkedin.com/in/zahira-hamza-91b6ba379)
- Email: zahirahamza659@gmail.com
