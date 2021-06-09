//
//  TokenService.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import Foundation

struct TokenService {
    static let instance = TokenService()

    let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsInZlciI6MSwia2lkIjoib2RleG1kYmIifQ.eyJqdGkiOiI4MWVjN2Q5OC01YTNlLTQ3MTEtYTYyOS1mYjE4NTQ3MzhmMDkiLCJzdWIiOiIxMzAtNDkzNTEiLCJ0eXBlIjoxLCJleHAiOiIyMDIxLTA2LTExVDEwOjAzOjQ2WiIsImlhdCI6IjIwMjEtMDYtMDdUMTA6MDM6NDZaIiwiTG9jYXRpb25JRCI6ODczNzIsIlNpdGVJRCI6IjcwMjY2LTA5OTQzIiwiSXNBZG1pbiI6ZmFsc2UsIlRvYml0VXNlcklEIjoxOTQ4MjA4LCJQZXJzb25JRCI6IjEzMC00OTM1MSIsIkZpcnN0TmFtZSI6Ikxlb25oYXJkIiwiTGFzdE5hbWUiOiJEcmllc2NoIiwicHJvdiI6MX0.V9eAsY0Wrjfron-_aL3AVPqMruuuLI8VNvxJS7CJ1LBHVERvxXEcDNyvuWJVdxD3pLvEpJNkJbKpaZMnun6z17jv_2WHNm6Cr2-er3knlc_ayypNsGQLRVLQfsuLT7RoBrAc7MKARv_LAZfPYSU_k5j0PViKbe8XM6gUm0RE5GhDEbRUbTmmd2WAE7JjRNbBOi-HP0aMCBRG6snsyfa_qO4QJRbRrjhuHKwbNjWqwcdhHjqa6AEKzhod5MOwrr9a7uo8iA_vyceMADK2VW_EBXz_krkTRtMNniKJ8PoyLjPZORcOCgH-cqf6MNgg_Ae-Jl60CSaRp1eHdhZ5uvgZKA"

    var tokenPayload: TokenPayload?

    init() {
        var encodedPayloadString = String(token.split(separator: ".")[1])

        // Pad string with = if it is not divisible by 4
        let remainder = encodedPayloadString.count % 4
        if remainder > 0 {
            encodedPayloadString = encodedPayloadString.padding(
                toLength: encodedPayloadString.count + 4 - remainder,
                withPad: "=",
                startingAt: 0
            )
        }

        if let decodedPayloadData = Data(base64Encoded: encodedPayloadString) {
            tokenPayload = try? JSONDecoder().decode(TokenPayload.self, from: decodedPayloadData)
        }
    }

    var userName: String {
        return
            (tokenPayload?.firstName ?? "")
                + " "
                + (tokenPayload?.lastName ?? "")
    }
}
