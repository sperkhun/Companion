//
//  ViewController.swift
//  Companion
//
//  Created by Serhii PERKHUN on 10/17/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var token: String?
    let params = ["grant_type": "client_credentials",
                  "client_id": "3d7bda93ada566d4e48221054fa31f76989d1cb2300c05708abbcabe8d5c090a",
                  "client_secret": "2d17a49f1963a6ea14b6e13335bc9116db42ba1baa88bd079b828d73c661a7e8"]
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButton(_ sender: UIButton) {
            self.getUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        logoImage.contentMode = .scaleAspectFill
        logoImage.image = #imageLiteral(resourceName: "42_logo")
        let im = UIImageView(frame: view.frame)
        im.contentMode = .scaleAspectFill
        im.image = #imageLiteral(resourceName: "background")
        view.insertSubview(im, at: 0)
        searchButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getToken() {
        request("https://api.intra.42.fr/oauth/token", method: .post, parameters: self.params).validate().responseJSON { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    self.token = json["access_token"].string
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func getUser() {
        let login = loginField.text?.lowercased().trimmingCharacters(in: CharacterSet.whitespaces)
        if login != "" {
            request("https://api.intra.42.fr/v2/users/" + login!, headers: ["Authorization": "Bearer " + self.token!]).validate().responseJSON { response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        ProfileInfo.login = json["login"].string
                        ProfileInfo.phone = json["phone"].string
                        ProfileInfo.email = json["email"].string
                        ProfileInfo.wallet = json["wallet"].int
                        ProfileInfo.correction = json["correction_point"].int
                        ProfileInfo.image = json["image_url"].string
                        ProfileInfo.level = json["cursus_users"][0]["level"].float
                        ProfileInfo.location = json["location"].string
                        ProfileInfo.projects.removeAll()
                        ProfileInfo.skills.removeAll()
                        for proj in json["projects_users"].arrayValue {
                            if proj["status"].string == "finished" && proj["cursus_ids"][0].int == 1 && proj["marked"].bool == true {
                                ProfileInfo.projects.append((proj["project"]["name"].string!, proj["final_mark"].float!, proj["validated?"].bool))
                            }
                        }
                        for skill in json["cursus_users"][0]["skills"].arrayValue {
                            ProfileInfo.skills.append((skill["name"].string!, skill["level"].float!))
                        }
                        self.getCoalition()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func getCoalition() {
        let login = loginField.text?.lowercased().trimmingCharacters(in: CharacterSet.whitespaces)
        request("https://api.intra.42.fr/v2/users/\(login!)/coalitions_users", headers: ["Authorization": "Bearer " + self.token!]).validate().responseJSON{ response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    ProfileInfo.coalition_id = json[0]["coalition_id"].int
                    self.performSegue(withIdentifier: "searchSegue", sender: self)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

