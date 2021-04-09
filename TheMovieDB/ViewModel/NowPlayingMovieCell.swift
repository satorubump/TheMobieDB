//
//  NowPlayingViewModel.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/7/21.
//

import Foundation
import SwiftUI
import Combine

class NowPlayingMovieCell : ObservableObject {
    let id : Int
    let title : String
    let poster_path : String?
    var genre : String = ""
    var isFavorite : Bool = false
    @Published var poster_image : UIImage? {
        didSet {
            NotificationCenter.default.post(name: .updatedDownloadImage, object: nil)
        }
    }
    
    private var disposables = Set<AnyCancellable>()
    private let imageFetcher = ImageFetcher()

    init(_ id: Int, _ title: String, _ poster_path: String?, _ genre_ids: [Int]) {
        self.id = id
        self.title = title
        self.poster_path = poster_path
        DispatchQueue.global().async {
            self.genre = self.getGenresString(genre_ids)
            self.getPosterImage(poster_path)
        }
        if let favorites : [Int] = UserDefaults.standard.array(forKey: "favorites") as? [Int] {
            if favorites.contains(self.id) {
                self.isFavorite = true
            }
        }
    }
    
    private func getGenresString(_ genre_ids: [Int]) -> String {
        var s_genre = ""
        genre_ids.forEach { gid in
            if s_genre.count > 0 {
                s_genre += "/"
            }
            s_genre += ConstantsTable.GenreIDsMap[gid, default: "General"]
        }
        return s_genre
    }
    
    private func getPosterImage(_ poster_path: String?) -> Void {
        guard let imagepath = poster_path else {
            return
        }
        guard let pub = self.imageFetcher.fetchImage(image_path: imagepath) else {  return }
            pub.receive(on: DispatchQueue.main)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("tryMapError")
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        //print("finished")
                        break
                    case .failure(let error):
                        print("failure: \(error)")
                    }
                },
                receiveValue: { data in
                    if let image = UIImage(data: data) {
                        self.poster_image = image
                    }
                })
            .store(in: &disposables)
    }
}
