import UIKit

protocol RecipesPresenterProtocol {
  func present()
}

class RecipesPresenter: RecipesPresenterProtocol {
    private weak var view: (RecipesViewControllerProtocol & UIViewController)!
    private let moviesService: MoviesServiceProtocol
    
    init(view: RecipesViewControllerProtocol & UIViewController, moviesService: MoviesServiceProtocol) {
        self.view = view
        self.moviesService = moviesService
    }
    
    func present() {
        let parameters: [String: Any] = [
            "s": "Batman",
            "page": 1,
            "apikey": "86c4b2d9"
        ]
        
        moviesService.getMovies(with: "https://www.omdbapi.com", parameters: parameters, headers: nil) { (result: Result<MovieResult, Error>) in
            switch result {
            case .success(let movies):
                print(movies.search.count)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
