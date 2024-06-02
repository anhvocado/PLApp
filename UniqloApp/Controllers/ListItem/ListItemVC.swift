//
//  ListItemVC.swift
//  UniqloApp
//

import UIKit

class ListItemVC: BaseVC {
    @IBOutlet weak var itemCollectionView: UICollectionView!
    var items: [UniqloProduct] = []
    var totalItems: [UniqloProduct] = []
    var brandId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getListItem()
    }
    
    func setupCollectionView() {
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "UniqloItemCell", bundle: nil), forCellWithReuseIdentifier:  "UniqloItemCell")
        self.itemCollectionView.reloadData()
    }

    func getListItem() {
        ProductListAPI().execute(success: {[weak self] response in
            self?.totalItems = response.products
            if let brandId = self?.brandId {
                self?.items = response.products.filter({ $0.brand?.id == brandId })
                self?.itemCollectionView.reloadData()
            }
        }, failure: { error in
            print(error)
        })
    }
    
    func moveToDetail(item: UniqloProduct) {
        DetailRecommendItemsProductAPI(id: item.id ?? 0).execute(success: { [weak self] response in
            let productIDs = response.data.compactMap { $0.productId }
            let similarItems: [UniqloProduct] = self?.totalItems.filter({ productIDs.contains($0.id ?? 0) }) ?? []
            DispatchQueue.main.async {
                let vc = ItemDetailVC()
                vc.item = item
                vc.similarItems = similarItems
                vc.totalItems = self?.items ?? []
                self?.push(to: vc)
            }
        }, failure: { error in
            print(error)
        })
    }
}

extension ListItemVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIScreen.main.bounds.width / 2
        let itemHeight = itemWidth * 1.5
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = itemCollectionView.dequeueReusableCell(withReuseIdentifier: "UniqloItemCell", for: indexPath) as? UniqloItemCell else {
           return UICollectionViewCell()
        }
        cell.setupData(item: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToDetail(item: items[indexPath.item])
    }
}
