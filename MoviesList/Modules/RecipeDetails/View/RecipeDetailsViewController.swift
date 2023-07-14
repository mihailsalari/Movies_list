import UIKit

protocol RecipeDetailsViewControllerProtocol: AnyObject {
  func prepare(with viewModel: RecipeDetailsViewModel)
}

class RecipeDetailsViewController: UIViewController, RecipeDetailsViewControllerProtocol {
  var presenter: RecipeDetailsPresenterProtocol!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    presenter.present()
    setupViews()
  }

  private func setupViews() {
    // Setup views
  }

  func prepare(with viewModel: RecipeDetailsViewModel) {
    title = viewModel.title
  }
}
