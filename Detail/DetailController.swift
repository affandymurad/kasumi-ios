//
//  DetailController.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import UIKit

class detailViewCell: UITableViewCell {
    
    @IBOutlet var ivThumbnail: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var type: UILabel!
    
    @IBOutlet var language: UILabel!
    
    @IBOutlet var source: UILabel!
    
}

class DetailController: BaseViewController<DetailPresenter>, DetailDelegates, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var ivPoster: UIImageView!
    
    var ids = 0
    
    var videoList = Array<VideoList>()
    
    @IBOutlet var tabelView: UITableView!
   
    @IBOutlet var titleMovie: UILabel!
    
    @IBOutlet var duration: UILabel!
    
    @IBOutlet var genres: UILabel!
    
    @IBOutlet var overview: UILabel!
    
    @IBOutlet var videos: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabelView.delegate = self
        tabelView.dataSource = self

        tabelView.tableFooterView = UIView()
        tabelView.tableFooterView?.isHidden = true
        
        titleMovie.textColor = UIColor.colorOrange
        videos.textColor = UIColor.colorOrange
        
        
        presenter = DetailPresenter(view: self)
        presenter.getMovieDetail(apis: NetworkManager.token, ids: String(self.ids), videos: "videos")
        
    }
    
    func loadMovieDetail(movieDetail: MovieDetail?) {
        var genrex = ""
        if (movieDetail?.genres != nil) {
            for element in movieDetail!.genres {
                genrex += "\(element.name), "
            }
        }
        titleMovie.text = movieDetail?.title
        genres.text = genrex
        duration.text = "\(movieDetail?.runtime ?? 0) Minutes"
        overview.text = movieDetail?.overview
        
        let posterUrl = "\(NetworkManager.baseImage)\(movieDetail?.poster_path ?? "")"
        let url = URL(string: posterUrl)
        self.ivPoster.kf.setImage(with: url, placeholder: UIImage(named: "Placeholder"))
        
        self.videoList = movieDetail?.videos.results ?? []
        tabelView.reloadData()
        
        overview.numberOfLines = 0
        overview.sizeToFit()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! detailViewCell
        cell.title.text = videoList[indexPath.row].name
        cell.title.textColor = UIColor.colorOrange
        cell.type.text = videoList[indexPath.row].type
        cell.type.textColor = UIColor.colorLightBlack
        let lang = Locale.current.localizedString(forLanguageCode: videoList[indexPath.row].iso_639_1)
        cell.language.text = lang
        cell.language.textColor = UIColor.colorLightBlack
        cell.source.text = videoList[indexPath.row].site
        cell.source.textColor = UIColor.colorBlack
        let youtubeUrl = "http://img.youtube.com/vi/\(videoList[indexPath.row].key )/default.jpg"
        let url = URL(string: youtubeUrl)
        cell.ivThumbnail.kf.setImage(with: url, placeholder: UIImage(named: "Placeholder"))
        cell.separatorInset = .zero
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let baris = videoList[indexPath.row]
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : VideoController = storyboard.instantiateViewController(withIdentifier: "Videos") as! VideoController
        vc.data = baris.key
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.colorOrange
        ]
    }
    
    func taskDidError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    

}
