//
//  EquationSolverViewModel.swift
//  Math Helper
//
//  Created by Geniusjames on 29/12/2021.
//

import Foundation

class EquationSolverViewModel {
    let polynomailHost = "math-solver1.p.rapidapi.com"
    let polynomialURL = "https://math-solver1.p.rapidapi.com/algebra/"
    let simultaneousEquationHost = "equation-solver.p.rapidapi.com"
    let simultaneousEquationURL = "https://equation-solver.p.rapidapi.com/solve/"

    func polynomials(_ isValidEquation: Bool, _ equation: String, completion: @escaping ((Result<[String: Any], Error>) -> Void)) {
        let parameters = ["problem": equation]
        let request = NetWorkRequest(host: polynomailHost,
                                     url: polynomialURL)
        request.postData(parameters: parameters, completion: { data in
            completion(data)
        })
    }

    func equations(_ isValidEquation: Bool, _ equation: String, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        if isValidEquation {
            let equations = equation.components(separatedBy: ",")
            print(equations)
            let request = NetWorkRequest(host: simultaneousEquationHost,
                                         url: simultaneousEquationURL)
            let parameters = ["equations": equations,
                              "unknowns": ["x", "y"]] as [String: Any]
            request.postData(parameters: parameters) { data in
                completion(data)
            }
        }
    }
    func exponentize(str: String) -> String {
        var str = str
        let supers = [
            "\u{00B9}": "1",
            "\u{00B2}": "2",
            "\u{00B3}": "3",
            "\u{2074}": "4",
            "\u{2075}": "5",
            "\u{2076}": "6",
            "\u{2077}": "7",
            "\u{2078}": "8",
            "\u{2079}": "9"]

        if str.contains("\u{00B9}") {
           str = str.replacingOccurrences(of: "\u{00B9}", with: "^1")
        }
        if str.contains("\u{00B2}") {
            str = str.replacingOccurrences(of: "\u{00B2}", with: "^2")
        }
        if str.contains("\u{00B3}") {
           str = str.replacingOccurrences(of: "\u{00B3}", with: "^3")
        }
        if str.contains("\u{2074}") {
            str = str.replacingOccurrences(of: "\u{2074}", with: "^4")
        }
        if str.contains("\u{2075}") {
           str = str.replacingOccurrences(of: "\u{2075}", with: "^5")
        }
        if str.contains("\u{2076}") {
           str = str.replacingOccurrences(of: "\u{2076}", with: "^6")
        }
        if str.contains("\u{2077}") {
           str = str.replacingOccurrences(of: "\u{2077}", with: "^7")
        }
        if str.contains("\u{2078}") {
            str = str.replacingOccurrences(of: "\u{2078}", with: "^8")
        }
        if str.contains("\u{2079}") {
           str = str.replacingOccurrences(of: "\u{2079}", with: "^9")

        }
        return str
    }

}
