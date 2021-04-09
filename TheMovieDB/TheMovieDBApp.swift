//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 3/31/21.
//

import SwiftUI

@main
struct TheMovieDBApp: App {
    
    var body: some Scene {
        WindowGroup {
            let viewModel = MoviesViewModel()
            AppTabView(viewModel: viewModel)
        }
    }
}
