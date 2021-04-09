//
//  AppTabView.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/9/21.
//

import SwiftUI

struct AppTabView: View {
    @ObservedObject var viewModel : MoviesViewModel

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        TabView {
            MoviesView(viewModel: viewModel)
            .tabItem {
                Image(systemName: "film")
                Text("Now Playing Moviews View")
            }
            FavoritesView(viewModel: viewModel)
            .tabItem {
                Image(systemName: "bookmark")
                Text("Favorites View")
            }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView(viewModel: MoviesViewModel())
    }
}
