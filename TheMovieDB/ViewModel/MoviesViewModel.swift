//
//  MoviesViewModel.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/6/21.
//

import Foundation
import SwiftUI
import Combine

class MoviesViewModel : ObservableObject {    
    @Published var nowPlayingMovieRows1 = [NowPlayingMovieCell]()
    @Published var nowPlayingMovieRows2 = [NowPlayingMovieCell]()
    // for Favorites
    @Published var favoritesMovies1 = [NowPlayingMovieCell]()
    @Published var favoritesMovies2 = [NowPlayingMovieCell]()
    
    @Published var errorMessage : String?
    @Published var updated = 0
    
    var nowPlayingResponse : NowPlayingResponse? {
        didSet {
            self.getNowPlayingRow()
        }
    }
    let theMovieDBConnector = TheMovieDBConnector()
    private var disposables = Set<AnyCancellable>()
    var sortKey : Int = 1 {
        didSet {
            self.getNowPlayingRow()
        }
    }
    
    init() {
        getUpdateData()
        NotificationCenter.default.addObserver(self, selector: #selector(updatedDownloadImage), name: .updatedDownloadImage, object: nil)
    }

    func getUpdateData() {
        self.getNowPlayingMovies()
    }
    func updateSortKey(_ newKey: Int) {
        self.sortKey = newKey
    }
    // Get Now_Playing Movies from tmdb web server with Combine
    private func getNowPlayingMovies() {

        theMovieDBConnector.nowPlaying()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.nowPlayingResponse = nil
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] nowPlayingResponse in
                self!.nowPlayingResponse = nowPlayingResponse
              })
            .store(in: &disposables)
    }
    
    // Get Movie List for View
    func getNowPlayingRow() -> Void {
        guard let nowPlayingRes = self.nowPlayingResponse else {
            return
        }

        var results : [NowPlayingResponse.Results]
        if sortKey == ConstantsTable.Rating {
            results = nowPlayingRes.results.sorted(by: { $0.vote_average > $1.vote_average })
        }
        else if sortKey == ConstantsTable.Title {
            results = nowPlayingRes.results.sorted(by: { $0.title < $1.title })
        }
        else {
            results = nowPlayingRes.results.sorted(by: { $0.release_date < $1.release_date })
        }

        self.nowPlayingMovieRows1.removeAll()
        self.nowPlayingMovieRows2.removeAll()
        var i = 0
        results.forEach() { result in
            let id = result.id
            let title = result.title
            let poster_path : String? = result.poster_path
            let genre_ids : [Int] = result.genre_ids
            let nowPlayingMovieCell = NowPlayingMovieCell(id, title, poster_path, genre_ids)
            let idex = i % 2
            if idex == 0 {
                self.nowPlayingMovieRows1.append(nowPlayingMovieCell)
            }
            else {
                self.nowPlayingMovieRows2.append(nowPlayingMovieCell)
            }
            i += 1
        }
    }

    // Get Favorite list
    func updateFavorite(idex: Int, nrow: Int) -> Void {
        var id = 0
        var on = false
        if nrow == 1 {
            if self.nowPlayingMovieRows1.count <= idex {
                return
            }
            id = self.nowPlayingMovieRows1[idex].id
        }
        else {
            if self.nowPlayingMovieRows2.count <= idex {
                return
            }
            id = self.nowPlayingMovieRows2[idex].id
        }

        if var favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            if let index = favorites.firstIndex(of: id) {
                favorites.remove(at: index)
            }
            else {
                if favorites.contains(id) == false {
                    favorites.append(id)
                    on = true
                }
            }
            UserDefaults.standard.set(favorites, forKey: "favorites")
        }
        else {
            var favorites = [Int]()
            favorites.append(id)
            UserDefaults.standard.set(favorites, forKey: "favorites")
        }

        //
        updateBookmarkPlayingRow(id: id, on: on)
        self.updated += 1
    }
    
    func updateBookmarkPlayingRow(id: Int, on: Bool) -> Void {

        self.nowPlayingMovieRows1.forEach { row in
            if row.id == id {
                row.isFavorite = on
                return
            }
        }
        self.nowPlayingMovieRows2.forEach { row in
            if row.id == id {
                row.isFavorite = on
                return
            }
        }
    }

    func getFavoriteMovies() -> Void {
        guard let favorites = UserDefaults.standard.array(forKey: "favorites") as? [Int] else {
            return
        }
        guard let nowPlayingRes = self.nowPlayingResponse else {
            return
        }
        let results = nowPlayingRes.results

        self.favoritesMovies1.removeAll()
        self.favoritesMovies2.removeAll()
        var i = 0
        results.forEach() { result in
            if favorites.contains(result.id) {
                let id = result.id
                let title = result.title
                let poster_path : String? = result.poster_path
                let genre_ids : [Int] = result.genre_ids
                let nowPlayingMovieCell = NowPlayingMovieCell(id, title, poster_path, genre_ids)
                let idex = i % 2
                if idex == 0 {
                    self.favoritesMovies1.append(nowPlayingMovieCell)
                }
                else {
                    self.favoritesMovies2.append(nowPlayingMovieCell)
                }
                i += 1
            }
        }
    }
    
    @objc func updatedDownloadImage(_ notification: Notification) {
        self.updated += 1
    }
}
