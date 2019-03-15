# Interview Assignment
<img src="https://www.themoviedb.org/assets/2/v4/logos/408x161-powered-by-rectangle-green-bb4301c10ddc749b4e79463811a68afebeae66ef43d17bcfd8ff0e60ded7ce99.png" width="100" height="40" />

## Some explainations 
- Third-party libraries used:

  1- [Alamofire](https://github.com/Alamofire/Alamofire): Networking layer.
  
  2- [DropDown](https://github.com/AssistoLab/DropDown): Drop Down menu for search history.
  
  3- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON): Dealing with JSON responses.
  *Sqlite.swift is installed but not used.

- Movie posters on first screen are downloading using "the movie db" APIs as the screen scrolls automatically and they are random.
- Unit tests for API functionality check, parsing and Userdefaults verifications are provided.
- Because of the problem's simplicity "Userdefaults" is used for data persistency. For a more complicated occasion sqlite is prefered.
- By looking at the project navigator (name of files and groups) you'll understand the approach which is a straight forward one and is self explained.
- Please be advised the API cannot be called on a regular internet connection. So as soon as you don't connect to your vpn, error alert will be shown.









