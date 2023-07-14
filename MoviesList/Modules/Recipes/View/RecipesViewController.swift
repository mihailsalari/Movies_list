import UIKit

protocol RecipesViewControllerProtocol: AnyObject {
  func prepare(with viewModel: RecipesViewModel)
}

class RecipesViewController: UIViewController, RecipesViewControllerProtocol {
  var presenter: RecipesPresenterProtocol!

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    presenter.present()
    setupViews()
  }

  private func setupViews() {
    // Setup views
      view.backgroundColor = .magenta
  }

  func prepare(with viewModel: RecipesViewModel) {
    title = viewModel.title
  }
}
