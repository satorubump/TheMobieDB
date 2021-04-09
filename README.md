# theMovieDBApp

## Functions
- Downloading "Now Playing" movies data from TMDB
- Downloading the poster images from TMDB
- Show the collection view for the Now Playing Movies
- selection and viewing my favorite movies
- Sort the collection view for the movies data

## Implementation
- Design and implementation has an MVVM Model
- Using SwiftUI for user interface and the update data with observed object
- Using Combine for downloading the movies data in asynchlonising
- Using TMDB api for downloading Now Playing movies data 

## Source Files

### View
- <b>AppTabView.swift</b> - 
Manage the tab views for MoviesView and FavoritesView
- <b>MoviesView.swift</b> - 
Display "Now Playing" movies
- <b>FavoritesView.swift</b> - 
Display a list of my favorite movies 

### ViewModel
- <b>MoviesViewModel.swift</b> -
Update the movies data from TMDB for Views
- <b>NowPlayingMovieCell.swift</b>-
Update and manage the "now playing" movies list for Views 

### Model
- <b>NowPlayingResponse.swift</b> -
"Now Playing Movies" data model. That is decoded download json data from TMDB.

### The Movies DB API
- <b>TheMovieDBConnector.swift</b> -
Download the "Now_Playing" movies data from TMDB with Combine
- <b>PosterImageFetcher.swift</b> -
Download the poster images data from TMDB with Combine

### Helpers
- <b>ConstantsTable.swift</b> - Define constants table
- <b>NotificationName.swift</b> - Notification Center's name table
