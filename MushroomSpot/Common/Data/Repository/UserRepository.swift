//
//  UserRepository.swift
//  MushroomSpot
//
//  Created by Jurica Bozikovic on 28.02.2024..
//  Copyright © 2024 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - UserRepositoryProtocol
protocol UserRepositoryProtocol {
    func getUser() -> AnyPublisher<UserReponse, Error>
}

//  MARK: - UserRepository
class UserRepository: NSObject, UserRepositoryProtocol {
    let apiService: UserAPIProtocol
//    let dbService: MushroomsDBProtocol

    init(apiService: UserAPIProtocol) {
        self.apiService = apiService
    }
     
    /** Returns mushrooms list. In production app this function would determine should it return data from API or DB.
    @author Jurica Bozikovic
    */
    func getUser() -> AnyPublisher<UserReponse, Error> {
        guard Utility.hasInternetConnection else {
            return Fail(error: AppError.noInternet).eraseToAnyPublisher()
        }
        return getUserFromAPI()
    }
}

//  MARK: - Check should we fetch data from API or not
private extension UserRepository {
    var shouldFetchFromAPI: Bool {
        true
    }
}

//  MARK: - Fetch data from API
private extension UserRepository {
    func getUserFromAPI() -> AnyPublisher<UserReponse, Error> {
        apiService.getUser()
    }
}

//  MARK: - DB
private extension UserRepository {
    func getUserFromDB() -> User? {
        nil
    }
}
