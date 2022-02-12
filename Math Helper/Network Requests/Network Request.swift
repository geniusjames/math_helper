//
//  Network Request.swift
//  Math Helper
//
//  Created by Geniusjames on 23/12/2021.
//

import Foundation
// swiftlint:disable force_cast
class NetWorkRequest {
    var host: String
    var url: String
    init(host: String, url: String) {
        self.host = host
        self.url = url
    }
    enum CustomError: Error {
        case noInternetConnection, invalidEquation
    }
    func postData<T>(parameters: T, completion: @escaping(Result<T, Error>) -> Void) {
        let headers = [
            "content-type": "application/json",
            "x-rapidapi-host": host,
            "x-rapidapi-key": "b0aa579e61msh2437ab11516ca93p1a7b20jsn75493e831265"
        ]

        guard let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        else {return }
        var request = URLRequest(url: NSURL(string: url)!
                                              as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)

            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            let session = URLSession.shared
            let dataTask = session.dataTask(
                 with: request as URLRequest, completionHandler: { (data, _, error) in
                     if data != nil {
                         do {
                             guard let result = try? JSONSerialization.jsonObject(with: data!) as? T else {return}

                             completion(.success(result))
                         } catch {
                             completion(.failure(error))
                         }
                     }
                    if error != nil {
                        let customerror: CustomError =
                            .noInternetConnection
                        completion(.failure(error ??
                                            customerror))
                     }
            })
            dataTask.resume()

    }
    func getData() {
        let request = URLRequest()
        
        request.httpMethod = "GET"
    }
    deinit {
        print("deinitialised")
    }

}
