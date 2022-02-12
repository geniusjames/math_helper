//
//  CalculatorViewController.swift
//  Math Helper
//
//  Created by Geniusjames on 23/12/2021.
//

import UIKit

class CalculatorViewController: UIViewController {
    var result: Double = 0
    var expressions: String = ""
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var expressionsTextField: UITextField!
    var operatorCount: Int = 0
    var isValid: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numbers(_ sender: UIButton) {
        if operatorCount == 1 {
            isValid = true
            operatorCount = 0
        }
        expressions.append(String(sender.tag))
        expressionsTextField.text = expressions
    }

    @IBAction func operations(_ sender: UIButton) {
        if expressions.isEmpty {
            isValid = false
        }
        operatorCount += 1
        let exp = String(sender.titleLabel?.text ?? "")
        expressions.append(exp)
        expressionsTextField.text = expressions

    }

    func evaluateExpressions() {
        var result: String = ""
        let nsexpression: NSExpression = NSExpression(format: expressions)
        let solution: Double = nsexpression.toFloatingPoint().expressionValue(with: Double.self, context: nil) as? Double ?? 0.0

        print(type(of: solution))
        if solution.truncatingRemainder(dividingBy: 1)==0 {
           result = "\(Int(solution))"
            resultLabel.text = result
        } else {
            resultLabel.text = String(solution)
        }
    }
    func validateEpression() {
        _ = sin(30.0)
    }
    @IBAction func equalsButton(_ sender: UIButton) {
        if sender.tag == 14 {
            if isValid {
                evaluateExpressions()
                return
            } else {
                resultLabel.text = "Math Error"
            }
        }
    }
    @IBAction func calcControlButton(_ sender: UIButton) {
        if sender.tag == 1 {
            expressions = ""
            expressionsTextField.text = expressions
        }
        if sender.tag == 2 && expressions.count > 0 {
            _ = expressions.popLast()
            expressionsTextField.text = expressions
        }

    }
    enum TrigonmetricFunc {
        case sine, cosine, tangent, logarithm
    }
    func trig(type: TrigonmetricFunc, val: Float) -> String {
        switch type {
        case .sine:
            return "\(sin(val))"
        case .cosine:
            return "\(cos(val))"
        case .tangent:
            return "\(tan(val))"
        case .logarithm:
            return "\(log(val))"
        }
    }

}
