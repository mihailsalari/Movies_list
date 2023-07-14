import UIKit

protocol RecipeDetailsPresenterProtocol {
  func present()
}

class RecipeDetailsPresenter: RecipeDetailsPresenterProtocol {
  private weak var view: (RecipeDetailsViewControllerProtocol & UIViewController)!

  init(view: RecipeDetailsViewControllerProtocol & UIViewController) {
    self.view = view
  }

  func present() {
    // Fetch data or smth else...
  }
}
