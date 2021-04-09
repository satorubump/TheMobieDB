//
//  ContentView.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 3/31/21.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel : MoviesViewModel
    @State var sortKey = ConstantsTable.ReleaseDate
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Text("Now Playing Movies")
                    .font(.body)
                    .foregroundColor(Color.gray)
                    .padding()
            }
            // Select Sort Key
            SelectSortKeySection
            // Movies Collection View
            List {
                ForEach(viewModel.nowPlayingMovieRows1.indices, id: \.self) { index in
                    HStack {
                        VStack {
                            // Poster Image
                            if viewModel.nowPlayingMovieRows1[index].poster_image != nil {
                                    Image(uiImage: viewModel.nowPlayingMovieRows1[index].poster_image!)
                                    .resizable()
                                    .aspectRatio(0.75, contentMode: .fit)
                            }
                            // Title
                            Text(viewModel.nowPlayingMovieRows1[index].title)
                                .font(.system(size: 21))
                                .foregroundColor(Color.black)

                            // Genre
                            HStack(alignment: .top) {
                                Text(viewModel.nowPlayingMovieRows1[index].genre)
                            }
                            .font(.system(size: 16))
                            .foregroundColor(Color.gray)
                            // Favorite Button
                            HStack {
                                    if viewModel.nowPlayingMovieRows1[index].isFavorite {
                                        Image(systemName: "bookmark.circle.fill")
                                            .font(.system(size: 18))
                                            .foregroundColor(Color.red)
                                    }
                                    else {
                                        Text("Add Favorite")
                                            .foregroundColor(Color.blue)
                                    }
                            }
                            // Changed from Button's issues
                            .onTapGesture {
                                viewModel.updateFavorite(idex:index, nrow: 1)
                            }
                            .font(.system(size: 16))
                            Spacer()
                        }
                        Spacer()
                        if viewModel.nowPlayingMovieRows2.count > index {
                            VStack {
                                // Poster Image
                                if viewModel.nowPlayingMovieRows2[index].poster_image != nil {
                                        Image(uiImage: viewModel.nowPlayingMovieRows2[index].poster_image!)
                                        .resizable()
                                        .aspectRatio(0.75, contentMode: .fit)
                                }
                                // Title
                                Text(viewModel.nowPlayingMovieRows2[index].title)
                                    .font(.system(size: 21))
                                    .foregroundColor(Color.black)
                                // Genre
                                HStack(alignment: .top) {
                                    Text(viewModel.nowPlayingMovieRows1[index].genre)
                                }
                                .font(.system(size: 16))
                                .foregroundColor(Color.gray)
                                // Favorite
                                HStack {
                                    if viewModel.nowPlayingMovieRows2[index].isFavorite {
                                        Image(systemName: "bookmark.circle.fill")
                                            .foregroundColor(Color.red)
                                            .font(.system(size: 18))
                                    }
                                    else {
                                        Text("Add Favorite")
                                            .foregroundColor(Color.blue)
                                    }
                                }
                                .onTapGesture {
                                    viewModel.updateFavorite(idex:index, nrow: 2)
                                }
                                .font(.system(size: 16))

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
    }
}

// Select Sort Key Section
private extension MoviesView {
    var SelectSortKeySection : some View {

        Section {
            HStack {
                Spacer()
                Text("sorted by: ")
                if sortKey == ConstantsTable.ReleaseDate {
                    Text("relase_date ")
                    .onTapGesture {
                        viewModel.updateSortKey(ConstantsTable.ReleaseDate)
                        sortKey = ConstantsTable.ReleaseDate
                    }
                    .foregroundColor(Color.blue)
                }
                else {
                    Text("relase_date ")
                    .onTapGesture {
                        viewModel.updateSortKey(ConstantsTable.ReleaseDate)
                        sortKey = ConstantsTable.ReleaseDate
                    }
                }
                if sortKey == ConstantsTable.Rating {
                    Text("rating ")
                    .onTapGesture {
                        viewModel.updateSortKey(ConstantsTable.Rating)
                        sortKey = ConstantsTable.Rating
                    }
                    .foregroundColor(Color.blue)
                }
                else {
                    Text("rating ")
                    .onTapGesture {
                        viewModel.updateSortKey(ConstantsTable.Rating)
                        sortKey = ConstantsTable.Rating
                    }
                }
                if sortKey == ConstantsTable.Title {
                    Text("title   ")
                    .onTapGesture {
                        viewModel.updateSortKey(ConstantsTable.Title)
                        sortKey = ConstantsTable.Title
                    }
                    .foregroundColor(Color.blue)
                }
                else {
                    Text("title   ")
                    .onTapGesture {
                        viewModel.updateSortKey(ConstantsTable.Title)
                        sortKey = ConstantsTable.Title
                    }
                }
            }
            .font(.system(size: 21))
            .foregroundColor(Color.gray)
        }
    }
}


struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView(viewModel: MoviesViewModel())
    }
}
