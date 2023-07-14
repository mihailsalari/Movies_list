import UIKit

protocol MoviesPresenterProtocol {
    func present()
}

final class MoviesPresenter: MoviesPresenterProtocol {
    private weak var view: (MoviesViewControllerProtocol & UIViewController)!
    private let moviesService: MoviesServiceProtocol
    private let imageDownloaderManager: ImageDownloaderManagerProtocol
    
    init(view: MoviesViewControllerProtocol & UIViewController, moviesService: MoviesServiceProtocol,
         imageDownloaderManager: ImageDownloaderManagerProtocol) {
        self.view = view
        self.moviesService = moviesService
        self.imageDownloaderManager = imageDownloaderManager
    }
    
    func present() {
        let parameters: [String: Any] = [
            "s": "Batman",
            "page": 1,
            "apikey": "86c4b2d9"
        ]
        
        moviesService.getMovies(with: "https://www.omdbapi.com", parameters: parameters, headers: nil) { [weak self] (result: Result<MovieResult, Error>) in
            switch result {
            case .success(let movies):
                let viewModel = MoviesViewModel(movieResult: movies)
                DispatchQueue.main.async {
                    self?.view.prepare(with: viewModel)
                    self?.downloadPostersImages(for: viewModel)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func downloadPostersImages(for moviesViewModel: MoviesViewModel) {
        let searchResults = moviesViewModel.movieResult.search
        
        let dispatchGroup = DispatchGroup()
        
        var updatedSearchResults: [MovieSearch] = []
        
        for item in searchResults {
            dispatchGroup.enter()
            
            imageDownloaderManager.downloadImage(for: item.poster) { [weak self] result in
                switch result {
                case .success(let imageData):
                    let searchResult = MovieSearch(title: item.title, year: item.year,
                                                   imdbID: item.imdbID, type: item.type,
                                                   poster: item.poster, posterImage: imageData)
                    updatedSearchResults.append(searchResult)
                case .failure(let error):
                    print("Image download failed: \(error)")
                }
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            var updatedMoviesViewModel = moviesViewModel
            updatedMoviesViewModel.movieResult.search = updatedSearchResults
            
            // Update the view with the updated view model and downloaded images
            self?.view.prepare(with: updatedMoviesViewModel)
        }
    }
}
