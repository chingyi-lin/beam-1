//
//  BeamTableViewController.swift
//  pass-share
//
//  Created by CY on 2019/4/14.
//  Copyright © 2019 Pass Share. All rights reserved.
//

import UIKit
import RealmSwift

protocol BeamTableViewControllerDelegate {
    func rowDidSelect(identifierInSelectedRow credentialId: String)
    func addBtnClicked()
}

// TODO: implement deletion
class BeamTableViewController: UITableViewController {
    
    var beamTableViewControllerDelegate: BeamTableViewControllerDelegate!
    var credentials = [Credential]()
    var siteImagesCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 90.0
        if (RealmAPI.shared.readAll().count == 0) {
            renderBlankState()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reloading data: child view")
        super.viewWillAppear(animated)
        print("credential empty")
        credentials = [Credential]()
        let queryResult = RealmAPI.shared.readAll()
        if (queryResult.count != 0) {
            removeBlankState()
        }
        for data in queryResult {
            credentials.append(data)
        }
        self.tableView.reloadData()
        print("crednetial fetched")
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row at index: \(indexPath.row)")
        beamTableViewControllerDelegate.rowDidSelect(identifierInSelectedRow: self.credentials[indexPath.row].credentialID)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentials.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeamTableViewCell", for: indexPath) as! BeamTableViewCell
        
        // Configure the cell
        cell.sitenameLabel.text = credentials[indexPath.row].sitename
        cell.usernameLabel.text = credentials[indexPath.row].username
        cell.identifier = credentials[indexPath.row].credentialID
        if (credentials[indexPath.row].myAccess.isOwn && credentials[indexPath.row].accessArr.count == 0) {
            print(credentials[indexPath.row].myAccess.isOwn)
            print(credentials[indexPath.row].accessArr.count)
            
            cell.shareWithPic.image = UIImage()
        }
        // Fetch image
        let domain = credentials[indexPath.row].domain
        if let cachedImage = siteImagesCache.object(forKey: NSString(string: domain)) {
            cell.siteImage.image = cachedImage
        }  else {
            DispatchQueue.global(qos: .background).async {
                self.fetchSiteLogo(for: domain, at: cell)
            }
        }
        return cell
    }
    
    func fetchSiteLogo(for domain: String, at cell: BeamTableViewCell){
        let imgSource = "https://logo.clearbit.com/"
        let targetUrl = URL(string: imgSource + domain + "?size=65") ?? URL(string: imgSource + "nothing.com")!
        let siteLogoRequest = ImageRequest(url: targetUrl)
        cell.request = siteLogoRequest
        siteLogoRequest.load(withCompletion: { [weak self] (siteLogo: UIImage?) in
            guard let siteLogo = siteLogo else {
                return
            }
            self!.siteImagesCache.setObject(siteLogo, forKey: NSString(string: domain))
            cell.siteImage.image = siteLogo
        })
    }
    
    func removeBlankState() {
        tableView.separatorColor = UIColor.gray // set separators back
        tableView.backgroundView = nil
        for subview in self.view.subviews {
            if subview is PrimaryButton {
                subview.removeFromSuperview()
            }
        }
    }
    
    func renderBlankState() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "loginBlankState") as! LoginBlankStateViewController
        tableView.separatorColor = UIColor.clear // will hide standard separators
        tableView.backgroundView = controller.view
        let button = PrimaryButton(frame: CGRect(x: 110, y: 280, width: 160, height: 40))
        button.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        let btnAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .semibold),
            .foregroundColor: UIColor.white
        ]
        let attributedTitle = NSMutableAttributedString(string: "ADD NEW LOGIN", attributes: btnAttributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.center.x = self.view.center.x // for vertical
        self.view.addSubview(button)
    }
    
    @objc func addBtnClicked() {
        beamTableViewControllerDelegate.addBtnClicked()
    }
}
