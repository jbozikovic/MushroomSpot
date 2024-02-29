//
//  UserAPIService.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - UserAPIProtocol
protocol UserAPIProtocol {
    func getUser() -> AnyPublisher<UserReponse, Error>
}

//  MARK: - MushroomsAPIService
class UserAPIService: NSObject, UserAPIProtocol {
    private let networkLayerService: NetworkLayerProtocol
    
    init(networkLayerService: NetworkLayerProtocol) {
        self.networkLayerService = networkLayerService
    }
            
    func getUser() -> AnyPublisher<UserReponse, Error> {
        let request: HTTPRequest = HTTPRequest(method: .get, url: userUrl, params: nil, headers: nil)
        return networkLayerService.executeNetworkRequest(request: request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

//  MARK: - Url, header
private extension UserAPIService {
    var userUrl: String {
        AppUrls.user
    }
}

