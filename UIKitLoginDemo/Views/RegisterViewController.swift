//
//  RegisterViewController.swift
//  UIKitLoginDemo
//
//  Created by devlink on 2025/10/15.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "创建账户"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "加入GitHub社区"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "用户名"
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(white: 0.3, alpha: 1.0).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "邮箱地址"
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(white: 0.3, alpha: 1.0).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "密码"
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(white: 0.3, alpha: 1.0).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "确认密码"
        textField.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        textField.textColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(white: 0.3, alpha: 1.0).cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("创建账户", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let loginPromptLabel: UILabel = {
        let label = UILabel()
        label.text = "已有账户？"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("立即登录", for: .normal)
        button.setTitleColor(UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    private var loadingVC: LoadingViewController?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(registerButton)
        view.addSubview(loginPromptLabel)
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        loginPromptLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 24),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginPromptLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            loginPromptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            
            loginButton.centerYAnchor.constraint(equalTo: loginPromptLabel.centerYAnchor),
            loginButton.leadingAnchor.constraint(equalTo: loginPromptLabel.trailingAnchor, constant: 8)
        ])
    }
    
    private func setupActions() {
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        title = "注册"
        navigationController?.navigationBar.tintColor = UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0)
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Actions
    @objc private func registerButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "请填写所有字段")
            return
        }
        
        guard password == confirmPassword else {
            showAlert(message: "密码不匹配")
            return
        }
        
        guard email.isValidEmail() else {
            showAlert(message: "请输入有效的邮箱地址")
            return
        }
        
        showLoading()
        
        AuthService.shared.register(username: username, email: email, password: password) { [weak self] result in
            self?.hideLoading()
            
            switch result {
            case .success(let response):
                if response.success {
                    // 注册成功，保存用户数据并跳转到首页
                    if let user = response.user, let token = response.token {
                        self?.saveUserData(user: user, token: token)
                        self?.navigateToHome(user: user)
                    }
                } else {
                    self?.showAlert(message: response.message)
                }
                
            case .failure(let error):
                self?.showAlert(message: "网络错误: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func loginButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showLoading() {
        loadingVC = LoadingViewController()
        guard let loadingVC = loadingVC else { return }
        addChild(loadingVC)
        loadingVC.view.frame = view.bounds
        view.addSubview(loadingVC.view)
        loadingVC.didMove(toParent: self)
    }
    
    private func hideLoading() {
        loadingVC?.willMove(toParent: nil)
        loadingVC?.view.removeFromSuperview()
        loadingVC?.removeFromParent()
        loadingVC = nil
    }
    
    private func saveUserData(user: User, token: String) {
        UserDefaults.standard.set(token, forKey: "userToken")
        
        let encoder = JSONEncoder()
        if let userData = try? encoder.encode(user) {
            UserDefaults.standard.set(userData, forKey: "userData")
        }
    }
    
    private func navigateToHome(user: User) {
        let homeVC = HomeViewController(user: user)
        let navigationController = UINavigationController(rootViewController: homeVC)
        
        // 配置导航栏
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .white
        
        // 动画切换根视图控制器
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionFlipFromRight,
                              animations: {
                window.rootViewController = navigationController
            },
                              completion: nil)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Email Validation Extension
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
