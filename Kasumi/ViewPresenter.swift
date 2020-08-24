//
//  ViewPresenter.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class ViewPresenter: BasePresenter<ViewDelegates> {
    private let disposeBag = DisposeBag()
    var movieList = Array<MovieList>()

    func getMovieList(apis: String, regions: String, languages: String, pages: String) {
        view.taskDidBegin()
        NetworkManager.sharedInstance.rx.request(ApiProvider.allmovie(api: apis, region: regions, language: languages, page: pages))
                  .asObservable()
                  .subscribe{ [weak self] (event) in
                      switch event {
                      case .next(let result):
                          do {
                              let moviex = try JSONDecoder().decode(Movie.self, from: result.data) as Movie
                            self?.movieList = moviex.results!
                          } catch {
                            print(error as Any)
                            self?.view.taskDidFinish()
                            self?.view.taskDidError(message: error.localizedDescription)
                          }
                      case.error(let error):
                        print(error as Any)
                          self?.view.taskDidFinish()
                          self?.view.taskDidError(message: error.localizedDescription)
                      case .completed:
                          self?.view.taskDidFinish()
                          self?.view.loadMovies(list: self!.movieList)
                      }
                  }
                  .disposed(by: disposeBag)
    }
}

protocol ViewDelegates: BaseDelegate {
    func loadMovies(list: Array<MovieList>)
}

