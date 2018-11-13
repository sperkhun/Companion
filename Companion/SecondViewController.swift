//
//  SecondViewController.swift
//  Companion
//
//  Created by Serhii PERKHUN on 10/17/18.
//  Copyright © 2018 Serhii PERKHUN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {

    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelView: UIProgressView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mainInfo: UIView!
    @IBOutlet weak var coalitionImage: UIImageView!
    
    @IBOutlet weak var projectsTable: UITableView!
    @IBOutlet weak var skillsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLabel.text = ProfileInfo.login
        phoneLabel.text = " 📱 \(ProfileInfo.phone!)"
        emailLabel.text = " ✉ \(ProfileInfo.email!)"
        if let loc = ProfileInfo.location {
            locationLabel.text = " Available \(loc)"
        }
        else {
            locationLabel.text = " Unavailable"
        }
        walletLabel.text = " Wallet \(ProfileInfo.wallet!)₳"
        correctionLabel.text = " Evaluation points \(ProfileInfo.correction!)"
        levelLabel.text = "level \(Int(ProfileInfo.level!)) - \(Int(ProfileInfo.level!.truncatingRemainder(dividingBy: 1.0) * 100))%"
        levelView.layer.cornerRadius = 15
        levelView.clipsToBounds = true
        levelView.setProgress(ProfileInfo.level!.truncatingRemainder(dividingBy: 1.0), animated: true)
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        if let data = try? Data(contentsOf: URL(string: ProfileInfo.image!)!) {
            if let im = UIImage(data: data) {
                userImage.image = im
            }
        }
        if let id = ProfileInfo.coalition_id {
            if id >= 5 && id <= 8 {
                if let data = try? Data(contentsOf: ProfileInfo.coalitions[id - 5]!) {
                    if let im = UIImage(data: data) {
                        coalitionImage.image = im
                        coalitionImage.contentMode = .scaleToFill
                        mainInfo.insertSubview(coalitionImage, at: 0)
                    }
                }
            }
            else {
                loadBackground()
            }
        }
        else {
            loadBackground()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.restorationIdentifier == "projects" {
            return ProfileInfo.projects.count
        }
        else {
            return ProfileInfo.skills.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.restorationIdentifier == "projects" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "projCell")
            cell?.textLabel?.text = ProfileInfo.projects[indexPath.row].0
            cell?.detailTextLabel?.text = "\(ProfileInfo.projects[indexPath.row].1)%"
            if ProfileInfo.projects[indexPath.row].2 == false {
                cell?.detailTextLabel?.textColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
            }
            else {
                cell?.detailTextLabel?.textColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
            }
            return cell!
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as! SkillCell
            cell.nameLabel.text = "\(ProfileInfo.skills[indexPath.row].0): \(ProfileInfo.skills[indexPath.row].1)"
            cell.progressSkill.progress = ProfileInfo.skills[indexPath.row].1 / 20.0
            return cell
        }
    }
    
    func loadBackground() {
        self.coalitionImage.image = #imageLiteral(resourceName: "background")
        self.coalitionImage.contentMode = .scaleToFill
        self.mainInfo.insertSubview(self.coalitionImage, at: 0)
    }
}
