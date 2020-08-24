//
//  ViewController.swift
//  Kasumi
//
//  Created by docotel on 21/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import UIKit
import DeepDiff
import Kingfisher

class mainViewCell: UITableViewCell {
    
    @IBOutlet var ivPoster: UIImageView!
    
    @IBOutlet var title: UILabel!
    
    @IBOutlet var date: UILabel!
    
    @IBOutlet var language: UILabel!
    
    @IBOutlet var overview: UILabel!
    
}

class ViewController: BaseViewController<ViewPresenter>, ViewDelegates, UITableViewDelegate, UITableViewDataSource {
    
    var movieList = Array<MovieList>()
    
    var page = 1
    
    var isFinish = false
    
    private let refreshControl = UIRefreshControl()
    
    
    func loadMovies(list: Array<MovieList>) {
        if (!list.isEmpty) {
            let before = movieList
            movieList.append(contentsOf: list)
            self.isFinish = false
            tabelView.reload(changes: diff(old: before, new: movieList), updateData: {
              self.movieList = movieList
            })
        } else {
            self.isFinish = true
        }
    }
    

    @IBOutlet var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabelView.delegate = self
        tabelView.dataSource = self

        tabelView.tableFooterView = UIView()
        tabelView.tableFooterView?.isHidden = true
        
        
        presenter = ViewPresenter(view: self)
        presenter.getMovieList(apis: NetworkManager.token, regions: "US", languages: "en", pages: String(self.page))
        
        if #available(iOS 10.0, *) {
            tabelView.refreshControl = refreshControl
        } else {
            tabelView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshMovie(_:)), for: .valueChanged)
        
    }
    
    @objc private func refreshMovie(_ sender: Any) {
        movieList.removeAll()
        tabelView.reloadData()
        self.page = 1
        presenter.getMovieList(apis: NetworkManager.token, regions: "US", languages: "en", pages: String(self.page))
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! mainViewCell
        cell.title.text = movieList[indexPath.row].title
        cell.title.textColor = UIColor.colorOrange
        cell.date.text = Date.convertDateString(string: movieList[indexPath.row].release_date)
        cell.date.textColor = UIColor.colorLightBlack
        let lang = Locale.current.localizedString(forLanguageCode: movieList[indexPath.row].original_language)
        cell.language.text = lang
        cell.language.textColor = UIColor.colorLightBlack
        cell.overview.text = movieList[indexPath.row].overview
        cell.overview.textColor = UIColor.colorBlack
        let posterUrl = "\(NetworkManager.baseImage)\(movieList[indexPath.row].poster_path ?? "")"
        let url = URL(string: posterUrl)
        cell.ivPoster.kf.setImage(with: url, placeholder: UIImage(named: "Placeholder"))
        cell.separatorInset = .zero

        loadMore(indexPath: indexPath)
        return cell
    }
    
    private func loadMore(indexPath: IndexPath){
        if (indexPath.row == movieList.count - 1) && (!isFinish){
            self.page += 1
            presenter.getMovieList(apis: NetworkManager.token, regions: "US", languages: "en", pages: String(self.page))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let baris = movieList[indexPath.row]
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc : DetailController = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailController
        vc.ids = baris.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.colorOrange
        ]

    }
    
    func taskDidBegin() {
        self.refreshControl.endRefreshing()
        var indicatorView = self.navigationController?.view.viewWithTag(88) as? UIActivityIndicatorView
        if (indicatorView == nil) {
            indicatorView = UIActivityIndicatorView.init(style: .whiteLarge)
            indicatorView?.tag = 88
        }
        indicatorView?.frame = self.navigationController!.view.bounds
        indicatorView?.backgroundColor = UIColor.init(white: 0, alpha: 0.50)
        indicatorView?.startAnimating()
        indicatorView?.isHidden = false
        self.navigationController?.view.addSubview(indicatorView!)
        self.navigationController?.view.isUserInteractionEnabled = false
    }
    
    
    func taskDidFinish() {
        self.refreshControl.endRefreshing()
        let indicatorView = self.navigationController?.view.viewWithTag(88) as? UIActivityIndicatorView
        if (indicatorView != nil) {
            indicatorView?.stopAnimating()
            indicatorView?.removeFromSuperview()
        }
        self.navigationController?.view.isUserInteractionEnabled = true
    }
    
    func taskDidError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

}

