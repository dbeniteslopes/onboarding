//
//  ResetPasswordViewController.swift
//  Onboarding
//
//  Created by Diego Benites on 24/08/20.
//  Copyright © 2020 Diego Benites Lopes. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [email, resetPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))
    
    private let email = CustomTextField(placeHolder: "Email")

    private let resetPasswordButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.title = "Send Reset Link"
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleResetPassword), for: .touchUpInside)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    
    private var viewModel = ResetPasswordViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNotificationObservers()
    }
        
    func configureUI() {
        configureGradientBackground()
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(backButton)
        view.addSubview(iconImage)
        view.addSubview(fieldsStack)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 120),
            iconImage.widthAnchor.constraint(equalToConstant: 120),
            
            email.heightAnchor.constraint(equalToConstant: 50),
            
            fieldsStack.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            fieldsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            fieldsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32)
        ])
    }
    
    func configureNotificationObservers() {
        email.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func handleBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleResetPassword() {
        print("reset password button pressed")
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == email {
            viewModel.email = sender.text
        }
        
        updateForm()
    }
}

extension ResetPasswordViewController: FormViewModel {
    
    func updateForm() {
        resetPasswordButton.isEnabled = viewModel.formIsValid
        resetPasswordButton.backgroundColor = viewModel.buttonBackgroundColor
        resetPasswordButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}
