<!-- Header -->
<img src="./Assets/AppIcon.png" width="60" align="right"/>
<h1>TheMovieDB App</h1>

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.2+-lightgrey.svg?longCache=true&?style=flat&logo=apple)](https://developer.apple.com/ios/)
[![](https://img.shields.io/badge/@BEstelrichS-1A94E0.svg?logoColor=white&logo=twitter)](https://twitter.com/BEstelrichS)


<!-- Body -->
## Documentation
- [The Movie DB API](https://developers.themoviedb.org/3/getting-started/introduction)


## Frameworks/External dependencies
- Foundation
- UIKit
- AVKit
- WebKit
- Kingfisher


## Description
The purpose of this app is to create a quick concept that, using The Movie DB API, **fetches trending movies and shows them in a clean interface**. Tapping on any movie a new view is presented **displaying the movie details** and allowing the user to **play the trailer within the application itself**.

Movies are displayed using a collection-view object adapting the view to landscape and portrait modes by the **traits variations usage**.

<p align="left">
	<img src="./GitHubAssets/Screenshot1.png" height="500"/>
	<img src="./GitHubAssets/Screenshot3.png" width="500"/>
</p>

Filtering movies through the search bar is made with the implementation of **DiffableDataSource snapshots**, making the actual user experience smooth and transparent besides of update data in real time.

<p align="left">
	<img src="./GitHubAssets/SearchFilter.gif" height="500"/>
</p>

Finally the app adapts properly to **light and dark mode** as well and the trailer is played through a WKWebView object.

<p align="left">
	<img src="./GitHubAssets/Screenshot4.png" width="500"/>
	<img src="./GitHubAssets/Screenshot2.png" height="500"/>
</p>


## Preview
The app preview presents the functionality and overall flow.

<p align="left">
	<img src="./GitHubAssets/Preview.gif" height="500"/>
</p>


<!-- Footer -->