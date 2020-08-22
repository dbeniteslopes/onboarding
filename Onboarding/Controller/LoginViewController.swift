//
//  LoginViewController.swift
//  Onboarding
//
//  Created by Diego Benites on 21/08/20.
//  Copyright © 2020 Diego Benites Lopes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    lazy var fieldsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [email, password, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    lazy var secondaryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [forgotPasswordButton, divider, googleLoginButton])
        stack.axis = .vertical
        stack.spacing = 28
        
        return stack
    }()
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "firebase-logo"))
    
    private let email = CustomTextField(placeHolder: "Email")
    
    private let password: CustomTextField = {
        let field = CustomTextField(placeHolder: "Password")
        field.isSecureTextEntry = true
        
        return field
    }()
    
    private let loginButton: AuthButton = {
        let button = AuthButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.87), .font: UIFont.systemFont(ofSize: 15)]
        let attributedTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.87), .font: UIFont.boldSystemFont(ofSize: 15)]
        attributedTitle.append(NSAttributedString(string: "Get help signing in.", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private let googleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "btn_google_light_pressed_ios").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setTitle("  Log In with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleGoogleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.87), .font: UIFont.systemFont(ofSize: 16)]
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: atts)
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.87), .font: UIFont.boldSystemFont(ofSize: 15)]
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAtts))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(showForgotPassword), for: .touchUpInside)
        
        return button
    }()
    
    private let divider = DividerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureGradient()
        configureUI()
    }
    
    func configureGradient() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        view.layer.insertSublayer(gradient, at: 0)
        gradient.frame = view.frame
    }
    
    func configureUI() {
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        secondaryStack.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(iconImage)
        view.addSubview(fieldsStack)
        view.addSubview(secondaryStack)
        view.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            iconImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 120),
            iconImage.widthAnchor.constraint(equalToConstant: 120),
            
            email.heightAnchor.constraint(equalToConstant: 50),
            password.heightAnchor.constraint(equalToConstant: 50),
            
            fieldsStack.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 32),
            fieldsStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            fieldsStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            secondaryStack.topAnchor.constraint(equalTo: fieldsStack.bottomAnchor, constant: 24),
            secondaryStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            secondaryStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            signUpButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    @objc func handleLogin() {
        print("login button pressed")
    }
    
    @objc func showForgotPassword() {
        print("forgot password button pressed")
    }
    
    @objc func handleGoogleLogin() {
        print("Handle google log in")
    }
    
    @objc func signUpGoogleLogin() {
        print("Handle sign up button")
    }
}