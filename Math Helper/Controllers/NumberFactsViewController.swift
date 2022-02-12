//
//  NumberFactsViewController.swift
//  Math Helper
//
//  Created by Geniusjames on 23/12/2021.
//

import UIKit

class NumberFactsViewController: UIViewController {
    let url = "https://numbersapi.p.rapidapi.com/1492/year?fragment=true&json=true"
    let host = "numbersapi.p.rapidapi.com"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        let request = NetWorkRequest(host: host, url: url )
       let viewModel = NumberFactsViewModel(service: request)
        viewModel.fetchRandomDateFact(date: "2345")
        // Do any additional setup after loading the view.
    }
    func displayResult() {

    }

}
