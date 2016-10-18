// ----- Scroll View -----
let scrollView = UIScrollView()
<#superview#>.addSubview(scrollView)
scrollView.snp.makeConstraints { make in
make.edges.equalTo(view)
}

// ----- Content View -----
let contentView = UIView()
scrollView.addSubview(contentView)
contentView.snp.makeConstraints { make in
make.edges.equalTo(scrollView)
make.width.equalTo(scrollView)
}