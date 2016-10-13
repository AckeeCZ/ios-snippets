// ----- <#name#> -----
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
collectionView.delegate = self
collectionView.dataSource = self
<#superview#>.addSubview(collectionView)
collectionView.snp.makeConstraints { make in
<#code#>
}
self.collectionView = collectionView