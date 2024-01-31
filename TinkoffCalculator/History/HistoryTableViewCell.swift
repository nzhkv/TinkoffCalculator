//
//  HistoryTableViewCell.swift
//  TinkoffCalculator
//
//  Created by Nikolay Zhukov on 31.01.2024.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var expressionLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    
    func configure(with expression: String, result: String) {
        expressionLabel.text = expression
        resultLabel.text = result
    }
}
