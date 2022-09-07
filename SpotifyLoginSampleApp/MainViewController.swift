//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 정유진 on 2022/08/02.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //메인뷰 진입시 뒤로가기를 막기
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomeLabel.text = """
        환영합니다.
        \(email)님
        """
        
        let isEmailSignIn = Auth.auth().currentUser?.providerData[0].providerID == "password"
        resetPasswordButton.isHidden = !isEmailSignIn
        
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            //에러가 없다면 popViewController 실행
            try firebaseAuth.signOut()
            self.navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError { //에러발생시
            print("ERROR: signout \(signOutError.localizedDescription)")
        }
        
        
    }
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        let email = Auth.auth().currentUser?.email ?? ""
        Auth.auth().sendPasswordReset(withEmail: email, completion: nil)
    }
    
    @IBAction func profileUpdateButtonTapped(_ sender: UIButton) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "코끼리"
        changeRequest?.commitChanges { _ in
            let displayName = Auth.auth().currentUser?.displayName
            ?? Auth.auth().currentUser?.email ?? "고객"
            
            self.welcomeLabel.text = """
                환영합니다.
                \(displayName)님
                """
        }
    }
}
