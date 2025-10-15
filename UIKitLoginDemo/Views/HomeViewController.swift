//
//  HomeViewController.swift
//  UIKitLoginDemo
//
//  Created by devlink on 2025/10/15.
//

import UIKit

// MARK: - Home View Controller
class HomeViewController: UIViewController {
    
    private let user: User
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        return imageView
    }()
    
    private let statsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("退出登录", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        displayUserInfo()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        title = "首页"
        
        view.addSubview(avatarImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(statsStackView)
        view.addSubview(logoutButton)
        
        // 添加统计卡片
        let stats = [
            ("仓库", "12"),
            ("粉丝", "45"),
            ("关注", "23")
        ]
        
        for (title, value) in stats {
            let card = createStatCard(title: title, value: value)
            statsStackView.addArrangedSubview(card)
        }
    }
    
    private func setupConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        statsStackView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            welcomeLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            statsStackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            statsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            statsStackView.heightAnchor.constraint(equalToConstant: 80),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    private func displayUserInfo() {
        welcomeLabel.text = "欢迎回来，\(user.username)！"
        
        // 设置用户头像（模拟）
        if user.avatar != nil {
            // 实际项目中这里会加载网络图片
            avatarImageView.image = UIImage(systemName: "person.circle.fill")
        } else {
            avatarImageView.image = UIImage(systemName: "person.circle.fill")
            avatarImageView.tintColor = .lightGray
        }
    }
    
    private func createStatCard(title: String, value: String) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        card.layer.cornerRadius = 8
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor(white: 0.3, alpha: 1.0).cgColor
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .lightGray
        titleLabel.textAlignment = .center
        
        card.addSubview(valueLabel)
        card.addSubview(titleLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 12),
            valueLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -12)
        ])
        
        return card
    }
    
    @objc private func logoutTapped() {
        // 清除用户数据
        UserDefaults.standard.removeObject(forKey: "userToken")
        UserDefaults.standard.removeObject(forKey: "userData")
        
        // 跳转回登录页面
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        
        // 动画切换根视图控制器
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionFlipFromLeft,
                              animations: {
                window.rootViewController = navigationController
            },
                              completion: nil)
        }
    }
}
