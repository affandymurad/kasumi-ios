//
//  DetailPresenter.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class DetailPresenter: BasePresenter<DetailDelegates> {
    private let disposeBag = DisposeBag()
    var movieDetail: MovieDetail?

    func getMovieDetail(apis: String, ids: String, videos: String) {
        view.taskDidBegin()
        NetworkManager.sharedInstance.rx.request(ApiProvider.detailmovie(api: apis, id: ids, append_to_response: videos))
                  .asObservable()
                  .subscribe{ [weak self] (event) in
                      switch event {
                      case .next(let result):
                          do {
                              let moviex = try JSONDecoder().decode(MovieDetail.self, from: result.data) as MovieDetail
                            self?.movieDetail = moviex
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
                          self?.view.loadMovieDetail(movieDetail: self?.movieDetail)
                      }
                  }
                  .disposed(by: disposeBag)
    }
}

protocol DetailDelegates: BaseDelegate {
    func loadMovieDetail(movieDetail: MovieDetail?)
}
