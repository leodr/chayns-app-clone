//
//  LocationService.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 07.06.21.
//

import Alamofire
import Foundation

enum NetworkError: Error {
    case parsingError
}

struct LocationService {
    static let instance = LocationService()

    func getLocationData(_ handler: @escaping (Result<[Location], NetworkError>) -> Void) {
        AF.request(
            "https://webapi.tobit.com/dataagg/v1.0/Location/sorted",
            headers: HTTPHeaders(["Authorization": "Bearer \(TokenService.instance.token)"])
        ).responseDecodable(of: LocationData.self) { response in
            do {
                let data = try response.result.get()
                handler(.success(data.locations))
            } catch {
                handler(.failure(NetworkError.parsingError))
            }
        }
    }
}
