//
//  AuthService.swift
//  UIKitLoginDemo
//
//  Created by devlink on 2025/10/15.
//


import UIKit

// MARK: - Models
struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct RegisterRequest: Codable {
    let username: String
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let success: Bool
    let message: String
    let token: String?
    let user: User?
}

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let avatar: String?
}

// MARK: - Mock API Service
class AuthService {
    
    static let shared = AuthService()
    private init() {}
    
    // 模拟用户数据库
    private var mockUsers: [User] = [
        User(id: 1, username: "demo", email: "demo@github.com", avatar: nil)
    ]
    
    // 模拟登录API
    func login(username: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        // 模拟网络延迟
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            // 模拟网络错误（10%概率）
            if Int.random(in: 1...10) == 1 {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "网络连接错误", code: 500, userInfo: nil)))
                }
                return
            }
            
            // 验证用户
            let user = self.mockUsers.first { $0.username == username || $0.email == username }
            
            if let user = user, password == "demo123" { // 模拟固定密码
                let response = AuthResponse(
                    success: true,
                    message: "登录成功",
                    token: "mock_jwt_token_\(Int.random(in: 1000...9999))",
                    user: user
                )
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } else {
                let response = AuthResponse(
                    success: false,
                    message: "用户名或密码错误",
                    token: nil,
                    user: nil
                )
                DispatchQueue.main.async {
                    completion(.success(response)) // 业务错误仍然使用success
                }
            }
        }
    }
    
    // 模拟注册API
    func register(username: String, email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        // 模拟网络延迟
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            // 模拟网络错误（10%概率）
            if Int.random(in: 1...10) == 1 {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "网络连接错误", code: 500, userInfo: nil)))
                }
                return
            }
            
            // 检查用户名是否已存在
            if self.mockUsers.contains(where: { $0.username == username }) {
                let response = AuthResponse(
                    success: false,
                    message: "用户名已存在",
                    token: nil,
                    user: nil
                )
                DispatchQueue.main.async {
                    completion(.success(response))
                }
                return
            }
            
            // 检查邮箱是否已存在
            if self.mockUsers.contains(where: { $0.email == email }) {
                let response = AuthResponse(
                    success: false,
                    message: "邮箱已被注册",
                    token: nil,
                    user: nil
                )
                DispatchQueue.main.async {
                    completion(.success(response))
                }
                return
            }
            
            // 创建新用户
            let newUser = User(
                id: self.mockUsers.count + 1,
                username: username,
                email: email,
                avatar: nil
            )
            self.mockUsers.append(newUser)
            
            let response = AuthResponse(
                success: true,
                message: "注册成功",
                token: "mock_jwt_token_\(Int.random(in: 1000...9999))",
                user: newUser
            )
            DispatchQueue.main.async {
                completion(.success(response))
            }
        }
    }
}
