//
//  MushroomsRepository.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - MushroomsRepositoryProtocol
protocol MushroomsRepositoryProtocol {
    func getMushrooms() -> AnyPublisher<MushroomReponse, Error>
}

//  MARK: - RepositoryListRepository
class MushroomsRepository: NSObject, MushroomsRepositoryProtocol {
    let apiService: MushroomsAPIProtocol
//    let dbService: MushroomsDBProtocol

    init(apiService: MushroomsAPIProtocol) {
        self.apiService = apiService
    }
     
    /** Returns mushrooms list. In production app this function would determine should it return data from API or DB.
    @author Jurica Bozikovic
    */
    func getMushrooms() -> AnyPublisher<MushroomReponse, Error> {
        guard Utility.hasInternetConnection else {
            return Fail(error: AppError.noInternet).eraseToAnyPublisher()
        }
        return getMushroomsFromAPI()
    }
}

//  MARK: - Check should we fetch data from API or not
private extension MushroomsRepository {
    var shouldFetchFromAPI: Bool {
        true
    }
}

//  MARK: - Fetch data from API
private extension MushroomsRepository {
    func getMushroomsFromAPI() -> AnyPublisher<MushroomReponse, Error> {
        apiService.getMushrooms()
    }
}

//  MARK: - DB
private extension MushroomsRepository {
    func getMushroomsFromDB() -> [Mushroom]? {
        nil
    }
}
