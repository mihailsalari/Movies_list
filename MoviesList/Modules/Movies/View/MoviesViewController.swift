import UIKit

protocol MoviesViewControllerProtocol: AnyObject {
    func prepare(with viewModel: MoviesViewModel)
}

class MoviesViewController: UICollectionViewController, MoviesViewControllerProtocol {
    var presenter: MoviesPresenterProtocol!
    private var viewModel: MoviesViewModel?
    
    private var flowLayout: UICollectionViewFlowLayout?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        presenter.present()
        setupViews()
    }
    
    private func setupViews() {
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    func prepare(with viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
}

extension MoviesViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieResult.search.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let search = viewModel?.movieResult.search[indexPath.row] {
            cell.configure(with: search)
        }
        return cell
    }
}

extension MoviesViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let padding: CGFloat = 12
        let cellWidth = collectionViewWidth - padding*2 // 12 pixels padding on left and right
        return CGSize(width: cellWidth, height: 200)
    }
}
