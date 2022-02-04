//
//  mainVC.swift
//  registration
//
//  Created by Mac on 11/9/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import UIKit
import AVKit

class MoviesVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mediaSegment: UISegmentedControl!
    //4-
    var arrayOfMedia: [Media] = []
    var user: User!
    var mediaType: MediaType = .all
    var mediaKind = MediaType.all.rawValue
    var email = UserDefaultManager.shared().getUserEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SqliteManager.shared().createMediaTable()
        searchBar.delegate = self
        UserDefaultManager.shared().setIsLoggedIn(value: true)
        // 1-
        tableView.register(UINib(nibName: StoryBroard.cellId, bundle: nil), forCellReuseIdentifier: StoryBroard.cellId)
        // 2-
        tableView.dataSource = self
        tableView.delegate = self
        //6-
        goToProfileBtn()
        cancelNavItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMediaData()
        setupSegmented()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let encoder = JSONEncoder()
        if let encodedMedia = try? encoder.encode(self.arrayOfMedia) {
            SqliteManager.shared().insertMediaTable(email: self.email ?? "", mediaData: encodedMedia, type: mediaKind)
        }
    }
    //5-
    func setMoviesData(term: String, media: String) {
        APIManager.loadMediaArray(term: term, media: media) { (error, mediaArr) in
            if let error = error {
                self.showAlert(message: "error!")
            }
            else if let mediaArr = mediaArr {
                self.arrayOfMedia = mediaArr
                self.tableView.reloadData()
            }
        }
    }
    
    private func getMediaData() {
        if let mediaData = SqliteManager.shared().getMediaData(email: email ?? "")?.0 {
            let decoder = JSONDecoder()
            if let decodedMedia = try? decoder.decode([Media].self, from: mediaData) {
                if let type = SqliteManager.shared().getMediaData(email: email ?? "")?.1 {
                    self.mediaKind = type
                    self.arrayOfMedia = decodedMedia
                    tableView.reloadData()
                }
            }
        }
    }
    
    private func setupSegmented() {
        switch mediaKind {
        case "movie":
            mediaSegment.selectedSegmentIndex = 1
        case "tvShow":
            mediaSegment.selectedSegmentIndex = 2
        case "music":
            mediaSegment.selectedSegmentIndex = 3
        default:
            mediaSegment.selectedSegmentIndex = 0
        }
    }
    
    @objc private func goToProfileVC() {
        let sb = UIStoryboard(name: StoryBroard.main, bundle: nil)
        let profileVC = sb.instantiateViewController(withIdentifier: StoryBroard.ProfileVC) as! ProfileVC
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func goToProfileBtn() {
        navigationItem.title = Title.moviTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Title.profileTitle, style: .plain, target: self, action: #selector(goToProfileVC))
    }
    
    private func segmentedChangedAction(_ sender: UISegmentedControl) {
        SqliteManager.shared().deleteMediaTable()
        let index = sender.selectedSegmentIndex
        switch index {
        case 1:
            self.mediaKind = MediaType.movie.rawValue
            self.mediaType = .movie
        case 3:
            self.mediaKind = MediaType.music.rawValue
            self.mediaType = .music
        case 2:
            self.mediaKind = MediaType.tvShow.rawValue
            self.mediaType = .tvShow
        default:
            self.mediaKind = MediaType.all.rawValue
            self.mediaType = .all
        }
        setMoviesData(term: searchBar.text!, media: self.mediaKind)
    }
    
    private func getUrl(stringUrl: String) {
        if let url = URL(string: stringUrl){
            let player = AVPlayer(url: url)
            let vc = AVPlayerViewController()
            vc.player = player
            present(vc, animated: true) {
                vc.player?.play()
            }
        }
    }
    
    private func cancelNavItem() {
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        segmentedChangedAction(sender)
    }
}
//3- extentions
extension MoviesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMedia.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBroard.cellId, for: indexPath) as! MoviesCell
        let media = arrayOfMedia[indexPath.row]
        cell.setupCellData(type: mediaType, media: media)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 146
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = arrayOfMedia[indexPath.row].trailer {
            getUrl(stringUrl: url)
        }
    }
}

extension MoviesVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        setMoviesData(term: searchBar.text!, media: mediaKind)
    }
}

