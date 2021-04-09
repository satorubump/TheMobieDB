//
//  BookmarksView.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/9/21.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel : MoviesViewModel

    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("My Favorites Movies")
                    .font(.body)
                    .foregroundColor(Color.gray)
                    .padding()
            }
            List {
                ForEach(viewModel.favoritesMovies1.indices, id: \.self) { index in
                    HStack {
                        VStack {
                            // Poster Image
                            if viewModel.favoritesMovies1[index].poster_image != nil {
                                Image(uiImage: viewModel.favoritesMovies1[index].poster_image!)
                                    .resizable()
                                    .aspectRatio(0.75, contentMode: .fit)
                            }
                            // Title
                            Text(viewModel.favoritesMovies1[index].title)
                                .font(.system(size: 21))
                                .foregroundColor(Color.black)
                            // Genre
                            HStack(alignment: .top) {
                                Text(viewModel.favoritesMovies1[index].genre)
                            }
                            .font(.system(size: 16))
                            .foregroundColor(Color.gray)
                            Spacer()
                        }
                        Spacer()
                        if viewModel.favoritesMovies2.count > index {
                            VStack {
                                // Poster Image
                                if viewModel.favoritesMovies2[index].poster_image != nil {
                                    Image(uiImage: viewModel.favoritesMovies2[index].poster_image!)
                                        .resizable()
                                        .aspectRatio(0.75, contentMode: .fit)
                                }
                                // Title
                                Text(viewModel.favoritesMovies2[index].title)
                                    .font(.system(size: 21))
                                    .foregroundColor(Color.black)
                                // Genre
                                HStack(alignment: .top) {
                                    Text(viewModel.favoritesMovies2[index].genre)
                                }
                                .font(.system(size: 16))
                                .foregroundColor(Color.gray)
                                Spacer()
                            }
                        }
                        else {
                            VStack {
                                Spacer()
                            }
                            .frame(width: 180)
                        }
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.getFavoriteMovies()
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(viewModel: MoviesViewModel())
    }
}
