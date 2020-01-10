<!-- Header -->
<p align="left">
	<img src="./GitHubAssets/AppIcon.png" alt="App icon" width="60" maxHeight="60" align="right"/>
	<h1>TheMovieDB App</h1>
</p>

<p align="left">
  <a href="https://www.swift.org">
		<img src=https://img.shields.io/badge/Swift-5.0-green.svg?longCache=true&style=flat-square] alt="Swift version">
  </a>
  <a href="https://developer.apple.com/ios/">
		<img src="https://img.shields.io/badge/iOS-13.2+-blue.svg?longCache=true&style=flat-square]" alt="iOS version" />
  </a>
  <a href="https://developers.themoviedb.org/3/getting-started/introduction">
		<img src="https://img.shields.io/badge/Documentation-The Movie DB API-red.svg?longCache=true&style=flat-square]" alt="Apple Documentation" />
  </a>
  <a href="https://twitter.com/BEstelrichS">
	<img src="https://img.shields.io/badge/Contact-@BEstelrichS-lightgrey.svg?style=flat" alt="Twitter: @BEstelrichS" />
  </a>
</p>


<!-- Body -->
## Frameworks
- Foundation
- UIKit
- AVKit
- WebKit
- Kingfisher

## Description
The goal of this short project is to create a simple iOS application that fetches Trending Movies from [TheMovieDB API](https://developers.themoviedb.org/3/getting-started/introduction) showing them in a nice interface, with their correspondent movie details and being able to play their trailers within the app.


Movies are displayed using a CollectionView object and adapting the autolayout to landscape and portrait modes by traits variations.
<p align="center">
  <a >
		<img src="./GitHubAssets/Screenshot1.png" alt="App icon" height="600"/>
  </a>
  <a >
		<img src="./GitHubAssets/Screenshot3.png" alt="App icon" height="300"/>
  </a>
</p>

The app adapts properly to light and dark mode as well and video is played through a WKWebView object. ViewControllers are presented modally according the new iOS13 look, not adapting to fullscreen by default.
<p align="center">
  <a >
		<img src="./GitHubAssets/Screenshot4.png" alt="App icon" height="300"/>
  </a>
  <a >
		<img src="./GitHubAssets/Screenshot2.png" alt="App icon" height="600"/>
  </a>
</p>


## App preview
On the app preview is displayed the functionality described previously and the app's flow itself.
<p align="center">
  <a >
		<img src="./GitHubAssets/Dark.gif" alt="App icon" height="600"/>
  </a>
</p>

## References
- [The Movie DB API documentation](https://developers.themoviedb.org/3/getting-started/introduction)

<!-- Footer -->