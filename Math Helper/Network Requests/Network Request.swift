//
//  Network Request.swift
//  Math Helper
//
//  Created by Geniusjames on 23/12/2021.
//

import Foundation

class NetWorkRequest {
    var host: String
    var url: String
    init(host: String, url: String) {
        self.host = host
        self.url = url
    }
// "equation-solver.p.rapidapi.com"
    enum CustomError: Error {
        case noInternetConnection, invalidEquation
    }
    func fetchResult(parameters: [String: Any], completion: @escaping(Result<[String: Any], Error>) -> Void) {
        let headers = [
            "content-type": "application/json",
            "x-rapidapi-host": host,
            "x-rapidapi-key": "b0aa579e61msh2437ab11516ca93p1a7b20jsn75493e831265"
        ]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
// "https://equation-solver.p.rapidapi.com/solve/"
            let request = NSMutableURLRequest(url: NSURL(string: url)!
                                              as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            let session = URLSession.shared
            let dataTask = session.dataTask(
                 with: request as URLRequest, completionHandler: { (data, _, error) -> Void in
                     if data != nil {
                         do {
                             let result = try JSONSerialization.jsonObject(with: data!) as? [String: Any]
                             completion(.success(result ?? ["": ""]))
                         } catch {
                             completion(.failure(error))
                         }
                     }
                    if error != nil {
                        let customerror: CustomError =
                            .noInternetConnection
                        completion(.failure(error ??
                                            customerror))
                        print(customerror)
                        print(error?.localizedDescription)
                     }
//                    let httpResponse = response as? HTTPURLResponse
            })
            dataTask.resume()

        } catch {
            print("error")
        }

    }

}
