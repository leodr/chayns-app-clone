//
//  TokenService.swift
//  ChaynsClone
//
//  Created by Driesch, Leonhard on 09.06.21.
//

import Foundation

struct TokenService {
    static let instance = TokenService()

    let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsInZlciI6MSwia2lkIjoib2RleG1kYmIifQ.eyJqdGkiOiJjNWFhNTk2ZS1kN2MyLTQ5OTEtODVmYS1kOWYyZjQwODY1NGIiLCJzdWIiOiIxMzAtNDkzNTEiLCJ0eXBlIjoxLCJleHAiOiIyMDIxLTA2LTE4VDA4OjA5OjM1WiIsImlhdCI6IjIwMjEtMDYtMTRUMDg6MDk6MzVaIiwiTG9jYXRpb25JRCI6MSwiU2l0ZUlEIjoiNTkxNDAtMDk1MTkiLCJJc0FkbWluIjpmYWxzZSwiVG9iaXRVc2VySUQiOjE5NDgyMDgsIlBlcnNvbklEIjoiMTMwLTQ5MzUxIiwiRmlyc3ROYW1lIjoiTGVvbmhhcmQiLCJMYXN0TmFtZSI6IkRyaWVzY2giLCJwcm92IjoxfQ.VaYTmB4sT-KmyMDn_iLF3ilHIfx_v3MEBZ_j5npiTBzNvMyE2fczvRzIR9uyTXp8pY9fFhnwTvN_VoT5bdHrb4wsij0COgRxKZ6J7D4XOPaK5VIBOFFTVIsuDb8LrVVQMjTMb4LU0HcXVw0Z8vGKDhEuiWaD8s8ypCXGyGTLipIMPKADnwmKrRwISmW4p7WQOxanPlE8j-8BQR7VET4a6MBhgC8TAWwHVGtsFI9sD2KiaG6FSHLh5A6BAKKLxdh7HMKcb2Xa8Dq2funE92TBFMZ-XrxzKRIz9FGnIi1OWTPaVLphN-lxRxq-IjefMAKasFErKCHvs8yONqVcnZF7BQ"

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
