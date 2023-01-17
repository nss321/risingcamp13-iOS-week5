//
//  ViewController.swift
//  week5
//
//  Created by BAE on 2023/01/17.
//

import UIKit
import Alamofire
import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon



class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setBackroundColor(){
        
    }
    
    @IBAction func login(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    self.loadUserData()
                    _ = oauthToken
                    /// 로그인 관련 메소드 추가
                }
            }
        } else {

            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    self.loadUserData()
                    _ = oauthToken
                    // 관련 메소드 추가
                }
            }
        }
        
    }
    func loadUserData(){
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                if let userName:String = user?.kakaoAccount?.profile?.nickname{
                    self.nameLabel.text = "환영합니다. \(userName)님."
                } else {
                    print("nil")
                }
                //do something
                _ = user
            }
        }
    }
    
}

