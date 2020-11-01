//
//  MainViewController.swift
//  RGBSelector 2.0
//
//  Created by Pavel Grishanin on 31.10.2020.
//

import UIKit

protocol ColorSelectorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class MainViewController: UIViewController {
    
    var defaultBackgroundColor = UIColor(red: 0.5, green: 1, blue: 1, alpha: 1)

    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.backgroundColor = defaultBackgroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorSelectorVC = segue.destination as! ColorSelectorViewController
        colorSelectorVC.delegate = self
        colorSelectorVC.modalPresentationStyle = .fullScreen
        colorSelectorVC.selectedColor = backgroundView.backgroundColor
    }
}

extension MainViewController: ColorSelectorViewControllerDelegate {
    func setColor(_ color: UIColor) {
        backgroundView.backgroundColor = color
    }
}
