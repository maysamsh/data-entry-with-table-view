//
//  DataEntryCell.swift
//  DataEntryWithTableView
//
//  Created by Maysam Shahsavari on 12/15/19.
//  Copyright © 2019 Maysam Shahsavari. All rights reserved.
//

import UIKit

@IBDesignable
class DataEntryCell: UITableViewCell {

    var view: UIView!
    private var _isOptional: Bool = true
    private var _keyboardType: Int = 0
    private var _isValid: Bool = false
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    
    @IBInspectable var title: String? {
        get {
            return titleLabel?.text
        }
        
        set {
            titleLabel?.text = newValue
        }
    }
    
    @IBInspectable var value: String? {
        get {
            return dataTextField?.text
        }
        
        set {
            dataTextField?.text = newValue
        }
    }
    
    @IBInspectable var placeholder: String? {
        get {
            return dataTextField.placeholder
        }
        
        set {
            dataTextField?.placeholder = newValue
        }
    }
    
    @IBInspectable var isOptional: Bool {
        get {
            return _isOptional
        }
        set {
            _isOptional = newValue
        }
    }
        
    @IBInspectable var keyboardType: Int{
        get {
            return _keyboardType
        }
        
        set {
            switch newValue {
            case 1:
                dataTextField.keyboardType = .numberPad
                dataTextField.semanticContentAttribute = .forceLeftToRight
            case 2:
                dataTextField.keyboardType = .URL
                dataTextField.semanticContentAttribute = .forceLeftToRight
            default:
                dataTextField.keyboardType = .default
                dataTextField.autocapitalizationType = .words
            }
        }
    }
    
    public var isValid: Bool {
        get {
            if _isOptional {
                return true
            } else {
                return (dataTextField.text ?? "").isEmpty ? false : true
            }
        }
    }
    
    // MARK: Initializer
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
        setup()
    }

    // MARK: Setup
    private func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        view.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(view)
        self.view = view
        configureUI()
    }

    override func prepareForInterfaceBuilder() {
        dataTextField.borderStyle = .none
    }
    
    private func configureUI(){
        dataTextField.borderStyle = .none
        self.selectionStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        let numberToolbar = UIToolbar()
        numberToolbar.barStyle = .default
        numberToolbar.setItems(
        [UIBarButtonItem(title: "Copy Text", style: .plain, target: self, action: #selector(copyText)),
        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        UIBarButtonItem(title: "Dimiss Keyboard", style: .plain, target: self, action: #selector(dismissKeyboard))], animated: false)
        numberToolbar.sizeToFit()
        dataTextField.inputAccessoryView = numberToolbar
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    // MARK: Functions
    @objc private func copyText() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = dataTextField.text
    }
    
    @objc private func dismissKeyboard() {
        dataTextField.resignFirstResponder()
    }
    
    func setWarning(){
        titleLabel.textColor = .systemRed
    }
    
    func clearWarning(){
        titleLabel.textColor = .label
    }
    
    func validationWarning(){
        if self.isValid {
            titleLabel.textColor = .label
        }else{
            titleLabel.textColor = .systemRed
        }
    }
}
