//
//  ViewController.swift
//  TinkoffCalculator
//
//  Created by Nikolay Zhukov on 25.01.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let textButton = sender.titleLabel?.text else { return }
        
        print(textButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

