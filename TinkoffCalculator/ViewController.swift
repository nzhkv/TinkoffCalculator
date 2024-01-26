//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by Nikolay Zhukov on 25.01.2024.
//

import UIKit

enum CalculationErrors: Error {
    case dividedByZero
}

enum Operation: String {
    case add = "+"
    case substract = "-"
    case miltyply = "x"
    case divide = "/"
    
    func calculate(numberOne: Double, numberTwo: Double) throws -> Double {
        switch self {
        case .add: return numberOne + numberTwo
        case .substract: return numberOne - numberTwo
        case .miltyply: return numberOne * numberTwo
        case . divide: 
            if numberTwo == 0 {
                throw CalculationErrors.dividedByZero
            }
            return numberOne / numberTwo
        }
    }
}

enum CalculationHistoryItem {
    case number(Double)
    case operation(Operation)
}



class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var calculationHistory: [CalculationHistoryItem] = []
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.locale = Locale(identifier: "ru_RU")
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter
    }()
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let textButton = sender.titleLabel?.text else { return }
        
        if textButton == "," && label.text?.contains(",") == true { return }
        
        if label.text == "0" {
            label.text = textButton
        } else {
            label.text?.append(textButton)
        }
    }
    
    @IBAction func operationButtonTapped(_ sender: UIButton) {
        guard 
            let textButton = sender.titleLabel?.text,
            let buttonOperation = Operation(rawValue: textButton) 
            else { return }
        
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue 
            else { return }
        
        calculationHistory.append(.number(labelNumber))
        calculationHistory.append(.operation(buttonOperation))
        
        resetLabelText()
    }
    
    @IBAction func cleanButtonTapped() {
        calculationHistory.removeAll()
        resetLabelText()
    }
    
    @IBAction func calculateButtonTapped() {
        guard
            let labelText = label.text,
            let labelNumber = numberFormatter.number(from: labelText)?.doubleValue
            else { return }
        
        calculationHistory.append(.number(labelNumber))
        
        do {
            let result = try calculate()
            label.text = numberFormatter.string(from: NSNumber(value: result))
        } catch {
            label.text = "Ошибка"
        }
        calculationHistory.removeAll()
        
    }
    
    func calculate() throws -> Double {
        guard case .number(let firstNumber) = calculationHistory[0] else { return 0 }
        
        var currentResult = firstNumber
        
        for index in stride(from: 1, to: calculationHistory.count - 1, by: 2) {
            guard
                case .operation(let operation) = calculationHistory[index],
                case .number(let number) = calculationHistory[index + 1]
            else { break }
            
            currentResult = try operation.calculate(numberOne: currentResult, numberTwo: number)
        }
        
        return currentResult
    }
    
    func resetLabelText() {
        label.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetLabelText()
    }


}

