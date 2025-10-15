//
//  AppRouter.swift
//  UIKitLoginDemo
//
//  Created by devlink on 2025/10/15.
//

import UIKit

class AppRouter {
    static let shared = AppRouter()
    
    private init() {}
    
    // 获取根视图控制器
    func getRootViewController() -> UIViewController {
        if let userData = UserDefaults.standard.data(forKey: "userData"),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            // 用户已登录，直接跳转到首页
            let homeVC = HomeViewController(user: user)
            let navigationController = UINavigationController(rootViewController: homeVC)
            setupNavigationBarAppearance(navigationController)
            return navigationController
        } else {
            // 用户未登录，显示登录页面
            let loginVC = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginVC)
            setupNavigationBarAppearance(navigationController)
            return navigationController
        }
    }
    
    // 设置导航栏样式
    func setupNavigationBarAppearance(_ navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(white: 0.05, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .white
    }
    
    // 切换根视图控制器（带动画）
    func switchRootViewController(to viewController: UIViewController, animated: Bool = true) {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else { return }
        
        if animated {
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionFlipFromRight,
                              animations: {
                window.rootViewController = viewController
            },
                              completion: nil)
        } else {
            window.rootViewController = viewController
        }
    }
}
