DispatchQueue.global(qos: .default).async {
<#background code#>

DispatchQueue.main.async {
<#foreground code#>
}
}