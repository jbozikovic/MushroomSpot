//
//  MushroomsAPIService.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - MushroomsAPIProtocol
protocol MushroomsAPIProtocol {
    func getMushrooms() -> AnyPublisher<MushroomReponse, Error>
}

//  MARK: - MushroomsAPIService
class MushroomsAPIService: NSObject, MushroomsAPIProtocol {
    private let networkLayerService: NetworkLayerProtocol
    
    init(networkLayerService: NetworkLayerProtocol) {
        self.networkLayerService = networkLayerService
    }
            
    func getMushrooms() -> AnyPublisher<MushroomReponse, Error> {
        let request: HTTPRequest = HTTPRequest(method: .get, url: mushroomsUrl, params: nil, headers: nil)
        return networkLayerService.executeNetworkRequest(request: request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

//  MARK: - Url, header
private extension MushroomsAPIService {
    var mushroomsUrl: String {
        AppUrls.mushrooms
    }
}
