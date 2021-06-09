//
//  LocationService.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 07.06.21.
//

import Alamofire
import Foundation

let bearerToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsInZlciI6MSwia2lkIjoib2RleG1kYmIifQ.eyJqdGkiOiI4MWVjN2Q5OC01YTNlLTQ3MTEtYTYyOS1mYjE4NTQ3MzhmMDkiLCJzdWIiOiIxMzAtNDkzNTEiLCJ0eXBlIjoxLCJleHAiOiIyMDIxLTA2LTExVDEwOjAzOjQ2WiIsImlhdCI6IjIwMjEtMDYtMDdUMTA6MDM6NDZaIiwiTG9jYXRpb25JRCI6ODczNzIsIlNpdGVJRCI6IjcwMjY2LTA5OTQzIiwiSXNBZG1pbiI6ZmFsc2UsIlRvYml0VXNlcklEIjoxOTQ4MjA4LCJQZXJzb25JRCI6IjEzMC00OTM1MSIsIkZpcnN0TmFtZSI6Ikxlb25oYXJkIiwiTGFzdE5hbWUiOiJEcmllc2NoIiwicHJvdiI6MX0.V9eAsY0Wrjfron-_aL3AVPqMruuuLI8VNvxJS7CJ1LBHVERvxXEcDNyvuWJVdxD3pLvEpJNkJbKpaZMnun6z17jv_2WHNm6Cr2-er3knlc_ayypNsGQLRVLQfsuLT7RoBrAc7MKARv_LAZfPYSU_k5j0PViKbe8XM6gUm0RE5GhDEbRUbTmmd2WAE7JjRNbBOi-HP0aMCBRG6snsyfa_qO4QJRbRrjhuHKwbNjWqwcdhHjqa6AEKzhod5MOwrr9a7uo8iA_vyceMADK2VW_EBXz_krkTRtMNniKJ8PoyLjPZORcOCgH-cqf6MNgg_Ae-Jl60CSaRp1eHdhZ5uvgZKA"

enum NetworkError: Error {
    case parsingError
}

struct LocationService {
    static let instance = LocationService()

    func getLocationData(_ handler: @escaping (Result<[Location], NetworkError>) -> Void) {
        AF.request(
            "https://webapi.tobit.com/dataagg/v1.0/Location/sorted",
            headers: HTTPHeaders(["Authorization": "Bearer \(bearerToken)"])
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
