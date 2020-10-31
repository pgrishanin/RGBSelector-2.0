//
//  ColorSelectorViewController.swift
//  RGBSelector 2.0
//
//  Created by Pavel Grishanin on 31.10.2020.
//

import UIKit

protocol ColorSelectorViewControllerDelegate {
    func takeStartColor() -> UIColor
}

class ColorSelectorViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var delegate: ColorSelectorViewControllerDelegate!
    var selectedColor: UIColor? {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedColor = delegate.takeStartColor()
        
        colorView.layer.cornerRadius = 10
        
        initTextField(redTextField)
        initTextField(greenTextField)
        initTextField(blueTextField)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        selectedColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        if let text = sender.text {
            if let doubleValue = Double(text) {
                if doubleValue  > 1 {
                    sender.text = "1.00"
                }
            } else {
                sender.text = "0.00"
            }
        }else {
            sender.text = "0.00"
        }
        
        selectedColor = UIColor(
            red: CGFloat(Double(redTextField.text ?? "") ?? 0),
            green: CGFloat(Double(greenTextField.text ?? "") ?? 0),
            blue: CGFloat(Double(blueTextField.text ?? "") ?? 0),
            alpha: 1)
    }
    
    @objc private func doneAction() {
        
    }
    
    private func updateView() {
        guard isViewLoaded else { return }
        
        colorView.backgroundColor = selectedColor
        
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat)
            = (0, 0, 0, 0)
        selectedColor?.getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
        
        redTextField.text = String(format: "%.2f", red)
        greenTextField.text = String(format: "%.2f", green)
        blueTextField.text = String(format: "%.2f", blue)
        
        redLabel.text = String(format: "%.2f", red)
        greenLabel.text = String(format: "%.2f", green)
        blueLabel.text = String(format: "%.2f", blue)
    }

    private func initTextField(_ textField: UITextField) {
        textField.keyboardType = .decimalPad
        
        let doneToolbar = UIToolbar(
            frame: CGRect.init(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 50
            )
        )
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneAction)
        )

        doneToolbar.items = [flexSpace, doneButton]
        doneToolbar.sizeToFit()

        textField.inputAccessoryView = doneToolbar
    }
}

extension ColorSelectorViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
