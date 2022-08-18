//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 정유진 on 2022/08/02.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
       
        //textField가 empty면 비활성화
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? "" //빈값이면 빈값으로 옵셔널 처리
        
        //firebaseAuth sdk에서 제공하는 createUser로 인증플렛폼에 전달가능
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입된 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
            
        }
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
    
}

extension EnterEmailViewController: UITextFieldDelegate {
    //작성 후 return버튼을 누르면 keyboard가 내려가게하기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    //두 텍스트필드에 값이 있는지 확인해서 다음버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
        
    }
}
