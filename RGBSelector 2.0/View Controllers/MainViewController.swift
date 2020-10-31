//
//  MainViewController.swift
//  RGBSelector 2.0
//
//  Created by Pavel Grishanin on 31.10.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    var backgroundColor = UIColor(red: 0.5, green: 1, blue: 1, alpha: 1)

    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorSelectorVC = segue.destination as! ColorSelectorViewController
        colorSelectorVC.delegate = self
        colorSelectorVC.modalPresentationStyle = .fullScreen
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard let colorSelectorVC = segue.source as? ColorSelectorViewController else { return }
        guard let selectedColor = colorSelectorVC.selectedColor else { return }
        
        backgroundColor = selectedColor
        updateView()
    }
    
    private func updateView() {
        backgroundView.backgroundColor = backgroundColor
    }

}

extension MainViewController: ColorSelectorViewControllerDelegate {
    func takeStartColor() -> UIColor {
        backgroundColor
    }
}
