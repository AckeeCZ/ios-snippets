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
fastlane run install_snippets
```

#### Version compatibility

As snippets are installed directly to shared Xcode folder, it's tricky for this repo to be versioned but as far as it's possible we at least provide you with branch you can use.

| Swift Version | branch |
| ------------- | ------ |
| 3.X           | master |
| 2.X           | swift2 |

To install Swift 2 compatible version use
```
fastlane run install_snippets git_repo:git@github.com:AckeeCZ/ios-snippets.git branch:swift2
```

### Add all snippets
To share snippets with your colleagues you can run

```
fastlane run add_all_snippets
```

which will copy your snippets to the repository and can be also commited with predefined commit message

### Add snippet

To share just one particular snippet you can call

```
fastlane run add_snippet
```
and a list of currently installed snippets to choose from will be presented. You can also specify key directly using

```
fastlane upload_snippet key:xcode-abbr
```

### Locations

If you dont trust us you can manually copy files from `snippets` folder to
```
~/Library/Developer/Xcode/UserData/CodeSnippets
```

### Fastlane support

To add *install* functionality to your Fastlane project, simply copy the action in [install_snippets.rb](fastlane/actions/install_snippets.rb) to your fastlane/actions folder. You will then be able to use the action in you Fastfile like this:

```
install_snippets(git_repo: "https://github.com/AckeeCZ/ios-snippets.git")
```

## Naming
To make our work easier, we use the ack prefix for the most of the snippets. If you want to contribute to this repository please follow this guideline.

Feel free to fork this repo and name the snippets to whatever you want (we are kind we know it)

### CamelCase or snake_case
Use the `snake_case`  or `camelCase` notation for Xcode shortcuts. Avoid the ` - ` symbol as it prevents the Xcode's code completion feature

## Forking this repository
If you would like to use our fastlane actions and our repo scheme within your team we would love to hear about it. Drop us a tweet at [@ackeecz][2] or leave a star here on Github. BTW we would also like to know what snippets you use!

## Sharing is caring
This tool and repo has been opensourced within our `#sharingiscaring` action when we have decided to opensource our internal projects

[1]:	https://github.com/fastlane/fastlane
[2]:	https://twitter.com/AckeeCZ
