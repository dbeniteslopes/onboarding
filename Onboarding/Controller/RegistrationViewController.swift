//
//  RegistrationViewController.swift
//  Onboarding
//
//  Created by Diego Benites on 22/08/20.
//  Copyright © 2020 Diego Benites Lopes. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [email, fullName, password, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))
    
    private let email = CustomTextField(placeHolder: "Email")
    private let fullName = CustomTextField(placeHolder: "Fullname")
    
    private let password: CustomTextField = {
        let field = CustomTextField(placeHolder: "Password")
        field.isSecureTextEntry = true
        
        return field
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.title = "Sign Up"
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.87), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Already have an account? ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.87), .font: UIFont.boldSystemFont(ofSize: 15)]
        attributedTitle.append(NSAttributedString(string: "Log In", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showLoginController), for: .touchUpInside)
        
        return button
    }()
    
    private var viewModel = RegistrationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureNotificationObservers()
    }
    
    func configureUI() {
        configureGradientBackground()
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        alreadyHaveAnAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconImage)
        view.addSubview(fieldsStack)
        view.addSubview(alreadyHaveAnAccountButton)
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 120),
            iconImage.widthAnchor.constraint(equalToConstant: 120),
            
            email.heightAnchor.constraint(equalToConstant: 50),
            fullName.heightAnchor.constraint(equalToConstant: 50),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            fieldsStack.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            fieldsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            fieldsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            alreadyHaveAnAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            alreadyHaveAnAccountButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func configureNotificationObservers() {
        email.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        password.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullName.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc func handleSignUp() {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        guard let fullName = fullName.text else { return }
     
        Service.registerUserWithFirebase(withEmail: email, password: password, fullName: fullName) { (error, ref) in
            if let error = error {
                print("DEBUG: Failed to sign up with Firebase \(error.localizedDescription)")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func showLoginController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        if sender == email {
            viewModel.email = sender.text
        } else if sender == password {
            viewModel.password = sender.text
        } else {
            viewModel.fullname = sender.text
        }
        
        updateForm()
    }
}

extension RegistrationViewController: FormViewModel {
    
    func updateForm() {
        signUpButton.isEnabled = viewModel.formIsValid
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }
}
