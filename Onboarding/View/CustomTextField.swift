//
//  CustomTextField.swift
//  Onboarding
//
//  Created by Diego Benites on 22/08/20.
//  Copyright © 2020 Diego Benites Lopes. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        placeholder = placeHolder
        
        attributedPlaceholder = NSAttributedString(
        string: placeHolder,
        attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
