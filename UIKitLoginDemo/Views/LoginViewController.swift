//
//  LoginViewController.swift
//  UIKitLoginDemo
//
//  Created by devlink on 2025/10/15.
//


import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GitHub"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "欢迎回来"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "用户名或邮箱"
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("登录", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    private let demoAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "演示账号: demo / demo123"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("忘记密码？", for: .normal)
        button.setTitleColor(UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let signUpPromptLabel: UILabel = {
        let label = UILabel()
        label.text = "新用户？"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("创建账户", for: .normal)
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
        
        // 预填充演示账号
        usernameTextField.text = "demo"
        passwordTextField.text = "demo123"
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(demoAccountLabel)
        view.addSubview(loginButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(signUpPromptLabel)
        view.addSubview(signUpButton)
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        demoAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        signUpPromptLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            demoAccountLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            demoAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: demoAccountLabel.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpPromptLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signUpPromptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -40),
            
            signUpButton.centerYAnchor.constraint(equalTo: signUpPromptLabel.centerYAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: signUpPromptLabel.trailingAnchor, constant: 8)
        ])
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func loginButtonTapped() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "请输入用户名和密码")
            return
        }
        
        showLoading()
        
        AuthService.shared.login(username: username, password: password) { [weak self] result in
            self?.hideLoading()
            
            switch result {
            case .success(let response):
                if response.success {
                    // 登录成功，保存用户数据并跳转到首页
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
    
    @objc private func signUpButtonTapped() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func forgotPasswordTapped() {
        showAlert(message: "密码重置功能")
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
