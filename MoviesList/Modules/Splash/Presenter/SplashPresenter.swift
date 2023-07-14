import UIKit

protocol SplashPresenterProtocol {
  func present()
}

class SplashPresenter: SplashPresenterProtocol {
  private weak var view: (SplashViewControllerProtocol & UIViewController)!

  init(view: SplashViewControllerProtocol & UIViewController) {
    self.view = view
  }

  func present() {
    // Fetch data or smth else...
      
      let controller = RecipesBuilder().buildViewController()!
      controller.modalPresentationStyle = .fullScreen
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
          self?.view.present(controller, animated: false)
      }
  }
}
