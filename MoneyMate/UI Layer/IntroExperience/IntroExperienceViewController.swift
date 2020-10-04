import UIKit

class IntroExperienceViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    @IBOutlet private weak var primaryButton: UIButton!
    @IBOutlet private weak var secondaryButton: UIButton!
    
    private lazy var dataModel: [IntroExperienceModel] = {
        let data = getDataFromJson() ?? []
        pageControl.numberOfPages = data.count
        return data
    }()
    
    private var isLastPage: Bool {
        let currentPage = pageControl.currentPage
        let numberOfPages = pageControl.numberOfPages - 1
        return currentPage == numberOfPages
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavibationBar()
        setupSkipBarButton()
        setupCollectionView()
        setupUI()
    }
    
    @IBAction func primaryButtonTapped(_ sender: UIButton) {
        guard isLastPage else {
            pageControl.currentPage += 1
            updateButtonsUI(isLastPage: isLastPage)
            let indexPath = IndexPath(row: pageControl.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            return
        }
        
        // TODO Show Video Controller
        Switcher.changeToVideoPlayer()
    }
    
    @IBAction func secondaryButtonTapped(_ sender: UIButton) {
        Switcher.changeRootToTab()
    }
    
    @objc func skipBarButtonTapped() {
        presentAlert(title: "Skip the intro app experience?",
                     message: "Are you sure you want to skip the introductory app experience?",
                     actionOneTitle: "Go back", actionOneStyle: .cancel,
                     actionTwoTitle: "Skip", actionTwoStyle: .default,
                     actionTwoHandler: { _ in Switcher.changeRootToTab() })
    }
}

extension IntroExperienceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(of: IntroExperienceCollectionViewCell.self, for: indexPath) else {
            fatalError("UICollecionView could not dequeue reausable cell of type IntroExperienceCollectionViewCell")
        }
        
        cell.configure(with: dataModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = Int(pageNumber)
        
        updateButtonsUI(isLastPage: isLastPage)
    }
}

private extension IntroExperienceViewController {
    func setupUI() {
        let halfHeight = primaryButton.bounds.height / 2
        primaryButton.roundCorners(radius: halfHeight )
        updateButtonsUI()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: IntroExperienceCollectionViewCell.self)
    }
    
    func setupNavibationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.backgroundColor()
    }
    
    func setupSkipBarButton(isHidden: Bool = false) {
        let barButton = UIBarButtonItem(title: "Skip", style: .plain,
                                        target: self, action: #selector(skipBarButtonTapped))
        
        barButton.setTitleTextAttributesAllStates(font: .systemFont(ofSize: 17),
                                                  color: UIColor.blue)
        navigationItem.setRightBarButton(isHidden ? nil : barButton, animated: true)
    }
        
    func updateButtonsUI(isLastPage: Bool = false) {
        let primaryButtonText = isLastPage ? "Start First Quize" : "Next"
        primaryButton.setTitle(primaryButtonText, for: .normal)
//        secondaryButton.isHidden = !isLastPage
//        setupSkipBarButton(isHidden: isLastPage)
//
        secondaryButton.isHidden = true
        setupSkipBarButton(isHidden: true)
    }
    
    func getDataFromJson() -> [IntroExperienceModel]? {
        do {
            let decoder = JSONDecoder()
            let resource = "IntroExperience"
            let model = [IntroExperienceModel].self
            
            return try decoder.decodeJsonResource(resource, model: model)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
