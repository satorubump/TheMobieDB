//
//  TheMovieDBConnector.swift
//  TheMovieDB
//
//  Created by Satoru Ishii on 4/6/21.
//

import Foundation
import Combine

enum APIError: Error {
    case network(description: String)
    case decoding(description: String)
}
protocol TheMovieDBConnectorable {
    func nowPlaying() -> AnyPublisher<NowPlayingResponse, APIError>
}

// The Connector for The Movie DB Service
class TheMovieDBConnector : TheMovieDBConnectorable {
    // Get Now_PlayingResponse data
    func nowPlaying() -> AnyPublisher<NowPlayingResponse, APIError> {
        let urlComponents = self.makeNowPlayingRequestUrl()
        return publishConnector(urlComponents: urlComponents)
    }
    
    // Create the Now_Playing request url
    private func makeNowPlayingRequestUrl() -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = ConstantsTable.Scheme
        urlComp.host = ConstantsTable.Host
        urlComp.path = ConstantsTable.Path + ConstantsTable.Now_PlayingReq
        
        urlComp.queryItems = [
            URLQueryItem(name: ConstantsTable.APIKeyLabel, value: ConstantsTable.APIKey)
        ]
        return urlComp
    }
    
    // Connect Service API, Downloading and Publish the data
    private func publishConnector(urlComponents components: URLComponents) -> AnyPublisher<NowPlayingResponse, APIError> {
        guard let url = components.url else {
            let error = APIError.network(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
    
    // Decode json data to NowPlayingResponse struct data
    private func decode(_ data: Data) -> AnyPublisher<NowPlayingResponse, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        return Just(data)
          .decode(type: NowPlayingResponse.self, decoder: decoder)
            //.print()
          .mapError { error in
            .decoding(description: error.localizedDescription)
          }
          .eraseToAnyPublisher()
    }
}
