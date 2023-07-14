import UIKit
import Swinject

protocol RecipesBuilderProtocol {
  func buildViewController() -> RecipesViewController!
}

class RecipesBuilder: RecipesBuilderProtocol {
    let container = AppContainer.default

  func buildViewController() -> RecipesViewController! {
    container.register(RecipesViewController.self) { _ in
      RecipesBuilder.instantiateViewController()

    }.initCompleted { r, h in
      h.presenter = r.resolve(RecipesPresenter.self)
    }

    container.register(RecipesPresenter.self) { c in
        let moviesService = c.resolve(MoviesServiceProtocol.self)!
        
        return RecipesPresenter(view: c.resolve(RecipesViewController.self)!, moviesService: moviesService)
    }

    return container.resolve(RecipesViewController.self)!
  }

  deinit {
    container.removeAll()
  }

  private static func instantiateViewController() -> RecipesViewController {
    let identifier = String(describing: RecipesViewController.self)
    let storyboard = UIStoryboard(name: identifier, bundle: .main)
    return storyboard.instantiateViewController(withIdentifier: identifier) as! RecipesViewController
  }
}
