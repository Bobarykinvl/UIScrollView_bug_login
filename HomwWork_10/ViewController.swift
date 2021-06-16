//
//  ViewController.swift
//  HomwWork_10
//
//  Created by Vladislav Bobarykin on 27.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var bottomConstraint: NSLayoutConstraint?
    
    @objc func handleTappedround() {
        view.endEditing(true)
    }
    
    @objc func handleKeyboard(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = value.cgRectValue.size.height
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            let newValue = isKeyboardShowing ? keyboardHeight : .zero
            bottomConstraint?.constant = newValue
        }
        switch notification.name {
        case UIResponder.keyboardWillShowNotification: break
        case UIResponder.keyboardWillHideNotification: break
        default: break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
       
//        let screenSize = UIScreen.main.bounds.size
//        scrollView = UIScrollView(frame: .init(origin: .zero, size: screenSize))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint?.isActive = true
    
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTappedround)))
        
        scrollView.backgroundColor = .red
    
        let logoImage: UIImageView = {
            let logo = UIImageView()
            let image = UIImage(named: "Logo")
            logo.image = image
            logo.backgroundColor = .purple
            return logo
        }()
        scrollView.addSubview(logoImage)
        
        let imageViewForUserNameField = UIImageView()
        let imageUser = UIImage(named: "user")
        imageViewForUserNameField.image = imageUser

        let userNameField: UITextField = {
            let textField = UITextField()
            textField.leftViewMode = UITextField.ViewMode.always // для чего это строчка не очень понимаю но в интернете ее советовали
            textField.leftView = imageViewForUserNameField
            textField.backgroundColor = .black
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(string: " Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0) // первое значение добавляет отступ для плэйсхолдера
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.cornerRadius = 20
            return textField
        }()
        scrollView.addSubview(userNameField)
        
        let imageViewForPasswordField = UIImageView()
        let imagePassword = UIImage(named: "lock")
        imageViewForPasswordField.image = imagePassword
        
        let passwordField: UITextField = {
            let textField = UITextField()
            textField.leftViewMode = UITextField.ViewMode.always
            textField.leftView = imageViewForPasswordField
            textField.backgroundColor = .black
            textField.textColor = .white
            textField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0)
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.white.cgColor
            textField.layer.cornerRadius = 20
            return textField
        }()
        scrollView.addSubview(passwordField)
        
        let loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = .green
            button.setTitle("Login", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            return button
        }()
        scrollView.addSubview(loginButton)
        
        let createAccountButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Create Account", for: .normal)
            button.setTitleColor(.white, for: .normal)
            return button
        }()
        
        scrollView.addSubview(createAccountButton)

        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 65),
            logoImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // констрейнты для userNameField и passwordField
        userNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            userNameField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 300),
            userNameField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 50),
            userNameField.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: userNameField.bottomAnchor, constant: 15),
            passwordField.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 50),
            passwordField.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    
        // констрейнты для иконок в полях
        imageViewForUserNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewForUserNameField.heightAnchor.constraint(equalToConstant: 15),
            imageViewForUserNameField.widthAnchor.constraint(equalToConstant: 15)
        ])
        
        imageViewForPasswordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewForPasswordField.heightAnchor.constraint(equalToConstant: 17),
            imageViewForPasswordField.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        // Login констрейнты
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            loginButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // Сreate Account констрейнты
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            createAccountButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -40)
        ])
        
//        stackViewForSocial.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stackViewForSocial.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            stackViewForSocial.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
//            stackViewForSocial.heightAnchor.constraint(equalToConstant: 30)
//        ])

    }
}

