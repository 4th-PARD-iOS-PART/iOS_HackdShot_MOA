//
//  SplashViewController.swift
//  Shortkathon_Project
//
//  Created by 도현학 on 11/16/24.
//

import UIKit

class SplashViewController: UIViewController {

    private let splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "splash")  // "image1" 이미지 파일을 로드
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black  // 배경색을 검정으로 설정 (이미지가 잘 보이도록)
        
        // 이미지 뷰 추가
        view.addSubview(splashImageView)
        
        // 이미지 뷰 제약조건 설정
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: view.topAnchor),
            splashImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splashImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 2초 후에 메인 화면으로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.transitionToMainScreen()
        }
    }
    
    // 메인 화면으로 전환
    private func transitionToMainScreen() {
        let mainVC = ViewController() // 메인 화면의 ViewController
        let navigationController = UINavigationController(rootViewController: mainVC) // 네비게이션 컨트롤러로 감싸기 (선택 사항)
        
        // 루트 뷰 컨트롤러로 설정
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navigationController
            sceneDelegate.window?.makeKeyAndVisible() // 새로 설정된 루트 뷰 컨트롤러 표시
        }
    }
}
