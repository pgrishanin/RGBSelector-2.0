//
//  ColorSelectorViewController.swift
//  RGBSelector 2.0
//
//  Created by Pavel Grishanin on 31.10.2020.
//

import UIKit

enum ColorTags: Int {
    case red = 0
    case green = 1
    case blue = 2
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
    var selectedColor: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 10
        
        initTextField(redTextField)
        initTextField(greenTextField)
        initTextField(blueTextField)
        
        initValues()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        selectedColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
        
        updateView()
        updateLabelBy(tag: sender.tag, with: sender.value)
        updateTextFieldBy(tag: sender.tag, with: sender.value)
    }
    
//    @IBAction func textFieldChanged(_ sender: UITextField) {
//        var floatValue: Float = 0
//        
//        if let text = sender.text {
//            if let parsedValue = Float(text) {
//                floatValue = parsedValue > 1 ? 1 : parsedValue
//            }
//        }
//
//        selectedColor = UIColor(
//            red: CGFloat(Float(redTextField.text ?? "") ?? 0),
//            green: CGFloat(Float(greenTextField.text ?? "") ?? 0),
//            blue: CGFloat(Float(blueTextField.text ?? "") ?? 0),
//            alpha: 1
//        )
//
//        updateView()
//        updateLabelBy(tag: sender.tag, with: floatValue)
//        updateSliderBy(tag: sender.tag, with: floatValue)
//        updateTextFieldBy(tag: sender.tag, with: floatValue)
//    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        delegate.setColor(selectedColor)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func keyboardDoneAction() {
        view.endEditing(true)
    }
    
    private func initValues() {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat)
            = (0, 0, 0, 0)
        selectedColor?.getRed(
            &red,
            green: &green,
            blue: &blue,
            alpha: &alpha
        )
        
        let floatRed = Float(red)
        let floatGreen = Float(green)
        let floatBlue = Float(blue)
        
        updateView()
        
        updateLabelBy(tag: ColorTags.red.rawValue, with: floatRed)
        updateSliderBy(tag: ColorTags.red.rawValue, with: floatRed)
        updateTextFieldBy(tag: ColorTags.red.rawValue, with: floatRed)

        updateLabelBy(tag: ColorTags.green.rawValue, with: floatGreen)
        updateSliderBy(tag: ColorTags.green.rawValue, with: floatGreen)
        updateTextFieldBy(tag: ColorTags.green.rawValue, with: floatGreen)

        updateLabelBy(tag: ColorTags.blue.rawValue, with: floatBlue)
        updateSliderBy(tag: ColorTags.blue.rawValue, with: floatBlue)
        updateTextFieldBy(tag: ColorTags.blue.rawValue, with: floatBlue)
    }

    private func initTextField(_ textField: UITextField) {
        textField.keyboardType = .decimalPad
        textField.delegate = self
        
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
            action: #selector(keyboardDoneAction)
        )

        doneToolbar.items = [flexSpace, doneButton]
        doneToolbar.sizeToFit()

        textField.inputAccessoryView = doneToolbar
    }
}

// MARK: Updates view elements values
extension ColorSelectorViewController {
    
    private func updateView() {
        colorView.backgroundColor = selectedColor
    }
    
    private func updateLabelBy(tag: Int, with value: Float) {
        switch tag {
        case ColorTags.red.rawValue:
            redLabel.text = roundedString(from: value)
        case ColorTags.green.rawValue:
            greenLabel.text = roundedString(from: value)
        case ColorTags.blue.rawValue:
            blueLabel.text = roundedString(from: value)
        default:
            break
        }
    }
    
    private func updateSliderBy(tag: Int, with value: Float) {
        switch tag {
        case ColorTags.red.rawValue:
            redSlider.value = value
        case ColorTags.green.rawValue:
            greenSlider.value = value
        case ColorTags.blue.rawValue:
            blueSlider.value = value
        default:
            break
        }
    }
    
    private func updateTextFieldBy(tag: Int, with value: Float) {
        switch tag {
        case ColorTags.red.rawValue:
            redTextField.text = roundedString(from: value)
        case ColorTags.green.rawValue:
            greenTextField.text = roundedString(from: value)
        case ColorTags.blue.rawValue:
            blueTextField.text = roundedString(from: value)
        default:
            break
        }
    }
}

// MARK: Helpers
extension ColorSelectorViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func roundedString(from value: Float) -> String {
        String(format: "%.2f", value)
    }
}

extension ColorSelectorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var floatValue: Float = 0
        
        if let text = textField.text {
            if let parsedValue = Float(text) {
                floatValue = parsedValue > 1 ? 1 : parsedValue
            }
        }
        
        selectedColor = UIColor(
            red: CGFloat(Float(redTextField.text ?? "") ?? 0),
            green: CGFloat(Float(greenTextField.text ?? "") ?? 0),
            blue: CGFloat(Float(blueTextField.text ?? "") ?? 0),
            alpha: 1
        )
        
        updateView()
        updateLabelBy(tag: textField.tag, with: floatValue)
        updateSliderBy(tag: textField.tag, with: floatValue)
        // update self for correct ronding
        updateTextFieldBy(tag: textField.tag, with: floatValue)
    }
}
