//
//  MainViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 정유진 on 2022/08/02.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //메인뷰 진입시 뒤로가기를 막기
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}