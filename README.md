![](http://img.ack.ee/default/image/test/ios_snippets_logo.png)
# Ackee iOS Swift Snippets for Xcode with Fastlane support

This repository is both library of useful swift snippets for Xcode and small yet elegant tool for sharing snippets with your colleagues. 

We will be happy if you will use it either way. 

## Structure 
In the root you will find 
- Readme (no shit sherlock) 🙄
- Fastfile 
- Sources folder containing Swift version of each snippet (just for easier readability)
- Snippets folder (where actual snippets for xcode are located)

## Usage 
You will need [Fastlane][1] for running the script. once installed go to the root of the repo and try one of theese commands

### Install
This command will install all snippets **from** repository to your Xcode. Installation process will override older versions of snippets with same name.
```
fastlane install
```

### Upload all snippets
If you want to share snippets with your colleagues you can run 
```
fastlane upload_all_snippets
```

which will copy your snippets to the repository and commit them

### Upload snippet 

if you want to share just one particular snippet you can call 
```
fastlane upload_snippet key:xcode-abbr
```
where `xcode-abbr` is key of your snippet within Xcode. 

### Locations

If you dont trust us you can manually copy files from `snippets` folder to 
```
/Library/Developer/Xcode/UserData/CodeSnippets
```

### Fastlane support 

You can add install support right into your current project adding this lane to your Fastfile
```ruby
desc "Installs xcode code snippets"
  lane :snippets do
  	repo = "https://github.com/AckeeCZ/ios-snippets.git" #change with your repo 
    FileUtils.rm_rf "/tmp/snippets"      
    install_dir = File.expand_path("~/Library/Developer/Xcode/UserData/CodeSnippets")
    if ! File.exists? install_dir
        UI.message "Creating Code Snippets Xcode directory #{install_dir}"
        FileUtils.mkdir_p install_dir
    end
    sh "git clone #{repo} /tmp/snippets"
    src_dir = File.expand_path("/tmp/snippets/snippets/")
    code_snippets =  Dir.entries(src_dir).select{ |e| File.extname(e) == ".codesnippet"  }
    code_snippets.select.each do |snippet|
      src_snippet_path = "#{src_dir}/#{snippet}"

      UI.message "Installing code snippet #{snippet}"
      FileUtils.cp_r src_snippet_path, install_dir
    end
  end
  ```



## Naming
We use for most of the snippets our ack prefix which makes it easier for us. If you want to contribute to this repository please follow this guideline. 

If you will fork this repo feel free to name the snippets whatever you want (we are kind we know it)

### CamelCase or snake_case
Use the `snake_case`  or `camelCase` notation for Xcode shortcuts. because ` - `
will not work with Xcode code completion feature

## Forking this repository 
If you woul like to use our fastfile script and repo scheme within your team we would be happy to know what it helped to someone. drop us a tweet at [@ackeecz][2] or leave a star here on Github. BTW we would also like to know what snippets you use!

## Sharing is caring
This tool and repo has been opensourced within our `#sharingiscaring` action when we have decided to opensource our internal projects

[1]:	https://github.com/fastlane/fastlane
[2]:	https://twitter.com/AckeeCZ