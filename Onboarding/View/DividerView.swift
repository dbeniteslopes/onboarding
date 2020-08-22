//
//  DividerView.swift
//  Onboarding
//
//  Created by Diego Benites on 22/08/20.
//  Copyright © 2020 Diego Benites Lopes. All rights reserved.
//

import UIKit

class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor.white.withAlphaComponent(0.87)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        let divider1 = UIView()
        divider1.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        divider1.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider1)
        NSLayoutConstraint.activate([
            divider1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            divider1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            divider1.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            divider1.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        let divider2 = UIView()
        divider2.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        divider2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider2)
        NSLayoutConstraint.activate([
            divider2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            divider2.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8),
            divider2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            divider2.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
