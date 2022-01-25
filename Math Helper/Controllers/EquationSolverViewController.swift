//
//  EquationSolverViewController.swift
//  Math Helper
//
//  Created by Geniusjames on 23/12/2021.
//

import UIKit
import Network

class EquationSolverViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var equationType: UISegmentedControl!
    @IBOutlet weak var solveButton: UIButton!
    let viewModel = EquationSolverViewModel()
    var isValidEquation: Bool = false
    let monitor = NWPathMonitor()

    let alert = UIAlertController(title: "My Title",
                                  message: "This is my message.",
                                  preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
        solveButton.addTarget(self,
                              action: #selector(solveButtonPressed),
                              for: .touchUpInside)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.displayNotification(textToDisplay: "connected",
                                             type: .success )
                    print("connected")
                }
            }
            if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    self.displayNotification(textToDisplay: "disconntected",
                                             type: .err)
                    print("disconnected")
                }
            }
            print(path.isExpensive)
        }
        let queue = DispatchQueue(label: "monitor")
        monitor.start(queue: queue)
        equationType.addTarget(self,
                               action: #selector(formatDisplay),
                               for: .allEvents)
    }
    @IBOutlet weak var notificationLabel: UILabel!
    func validateField() {
        let equation = inputField.text ?? ""
        if equation.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty {
            displayNotification(textToDisplay: "Equation editor cannot be empty",
                                type: .err)
            isValidEquation = false
        } else {
            isValidEquation = true
        }
    }

    enum NotificationType {
        case err, success
    }
    var equation = ""

    @objc func solveButtonPressed() {
        validateField()
        if isValidEquation {
            activityIndicator.startAnimating()
        }
        equation = inputField.text ?? ""
        switch equationType.selectedSegmentIndex {
        case 0:
            solvePolynomials()
        case 1:
            solveEquations()
        default:
            break
        }
    }
    func solvePolynomials() {
        viewModel.polynomials(isValidEquation,
                              equation,
                              completion: { data in
        switch data {
        case .success(let result):
            DispatchQueue.main.async {
                self.resultLabel.text = result["solution"] as? String
            }
            print(result, "passed")
        case .failure(let error):
            DispatchQueue.main.async {
                self.displayNotification(textToDisplay: error.localizedDescription,
                                         type: .err)
            }
        }
            DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }

        })
    }
    func solveEquations() {
        let data = viewModel.equations(isValidEquation, equation)
        switch data {
        case .success(let result):
            DispatchQueue.main.async {
                self.resultLabel.text = result as? String
            }
            print(result)
        case .failure(let error):
            DispatchQueue.main.async {
                self.displayNotification(textToDisplay: error.localizedDescription,
                                         type: .err)
            }
        }
    }
    func displayNotification(textToDisplay: String,
                             type: NotificationType) {
        switch type {
        case .err:
            self.notificationLabel.textColor = .red
        case .success:
            self.notificationLabel.textColor = .green
        }
        UIView.animate(withDuration: 5) {
            self.notificationLabel.text = textToDisplay
            self.notificationLabel.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.notificationLabel.text = ""
            self.notificationLabel.alpha = 1
        }
    }
    @objc func formatDisplay() {
        switch equationType.selectedSegmentIndex {
        case 0:
            inputField.placeholder = "Enter equation to solve or algebraic expressions to simplify"
        case 1:
            inputField.placeholder = "Enter a simultaneous equation"
        default:
            break
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    func activateSpinner() {
    }
}
