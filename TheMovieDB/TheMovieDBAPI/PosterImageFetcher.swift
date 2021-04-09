//
//  PosterImageFetcher.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/7/21.
//

import Foundation
import Combine


class ImageFetcher {

    func fetchImage(image_path imagePath: String) -> AnyPublisher<(data: Data, response: URLResponse), URLError>? {
        let urlComponents = self.makeFetchImageRequestUrl(imagePath)
        guard let url = urlComponents.url else {
            return nil
        }
        return URLSession.shared.dataTaskPublisher(for: url)
        .eraseToAnyPublisher()
    }
    
    // Create the fetch Image request url from location coordinates
    private func makeFetchImageRequestUrl(_ imagePath: String) -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = ConstantsTable.Scheme
        urlComp.host = ConstantsTable.ImageHost
        urlComp.path = ConstantsTable.ImagePath + imagePath
        
        return urlComp
    }
}
