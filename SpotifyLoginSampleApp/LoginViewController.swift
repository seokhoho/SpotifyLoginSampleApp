//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 정유진 on 2022/07/20.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //Navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        //Google Sign In
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        //실제 구글로 로그인 진행
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
    }
    

}
