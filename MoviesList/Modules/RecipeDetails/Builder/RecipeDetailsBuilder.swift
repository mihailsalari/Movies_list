import UIKit
import Swinject

protocol RecipeDetailsBuilderProtocol {
  func buildViewController() -> RecipeDetailsViewController!
}

class RecipeDetailsBuilder: RecipeDetailsBuilderProtocol {
  let container = Container()

  func buildViewController() -> RecipeDetailsViewController! {
    container.register(RecipeDetailsViewController.self) { _ in
      RecipeDetailsBuilder.instantiateViewController()

    }.initCompleted { r, h in
      h.presenter = r.resolve(RecipeDetailsPresenter.self)
    }

    container.register(RecipeDetailsPresenter.self) { c in
      RecipeDetailsPresenter(view: c.resolve(RecipeDetailsViewController.self)!)
    }

    return container.resolve(RecipeDetailsViewController.self)!
  }

  deinit {
    container.removeAll()
  }

  private static func instantiateViewController() -> RecipeDetailsViewController {
    let identifier = String(describing: RecipeDetailsViewController.self)
    let storyboard = UIStoryboard(name: identifier, bundle: .main)
    return storyboard.instantiateViewController(withIdentifier: identifier) as! RecipeDetailsViewController
  }
}
