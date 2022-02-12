//
//  NumberFactsViewModel.swift
//  Math Helper
//
//  Created by Geniusjames on 04/02/2022.
//

import Foundation

class NumberFactsViewModel {

    var service: NetWorkRequest?

    init(service: NetWorkRequest) {
        self.service = service
    }

    func fetchRandomDateFact(date: String) {
        service?.postData(parameters: date) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let err):
                print(err)
            }
        }

        func fetchMathFact() {

        }
    }
}
