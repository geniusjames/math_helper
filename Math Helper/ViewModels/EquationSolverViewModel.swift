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
        request.fetchResult(parameters: parameters, completion: { data in
            completion(data)
        })
    }

    func equations(_ isValidEquation: Bool, _ equation: String) -> Result<[String: Any], Error> {
        var result: Result<[String: Any], Error>?
        if isValidEquation {
            let equations = equation.components(separatedBy: ",")
            print(equations)
            let request = NetWorkRequest(host: simultaneousEquationHost,
                                         url: simultaneousEquationURL)
            let parameters = ["equations": equations,
                              "unknowns": ["x", "y"]] as [String: Any]
            request.fetchResult(parameters: parameters) { data in
                result = data
            }
        }
        return result!
    }

}
