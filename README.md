
# DogBreedsList

This project is an iOS application that displays a list of dog breeds. When a user taps on a breed, a new screen is presented showing a list of dogs belonging to that breed. This app uses public API to get the list of breeds and dogs on the basis of breeds. The app also uses Core Data for managing and persisting breed and dog data.

## Features

- Displays a list of dog breeds.
- On tap of a breed, shows a list of dogs of that breed.
- Uses Core Data for handling data persistence.
- Easy-to-use interface with responsive navigation.


## Screenshots

![App ScreenSHot](https://github.com/user-attachments/assets/e14c7dc6-f933-43b5-9cd4-a5dc3fde2ae3)

![App Screenshot](https://github.com/user-attachments/assets/79ad6e15-ef1f-4132-8152-721f0f79877d)

![App Screenshot](https://github.com/user-attachments/assets/467614b0-336a-439d-93e3-fdc24067888c)


## Requirements

- iOS 13.0+
- Xcode 12.0+
- Swift 5.0+
## Installation
Clone the repository:
```bash
  https://github.com/sumitaggarwal23021999/DogBreedsList.git
```

Open the project in Xcode:
```bash
  cd DogBreedsList
  open DogBreeds.xcodeproj
```

Build and run the project on your desired simulator or device.
    
## Core Data Model

### Entities
1. DogsBreeds

- breedName: String

2. DogsImageData

- breedName: String
- imageName: String

### Relationships
- Each DogsBreeds entity can have multiple DogsImageData entities associated with it.
## How It Works

1. Listing Dog Breeds:

- The main screen displays a list of dog breeds using data fetched from the Core Data DogsBreeds entity.

2. Displaying Dogs:

- When a user taps on a breed, the app navigates to a new screen that fetches and displays all dogs associated with the selected breed from the DogsImageData entity.

3. Core Data Integration:

- The app uses Core Data for storing and retrieving breed and dog information.
- The 'DogsBreeds' entity stores the names of the breeds.
- The 'DogsImageData' entity stores the images and breed names of the dogs.
## Code Structure

- Model: Contains Core Data entities (DogsBreeds, DogsImageData).
- View: UI components and view controllers for displaying lists.
- Controller: Handles the business logic and data flow between the model and view.
## Contributing

Contributions are always welcome!

1. Fork the repository.

2. Create your feature branch:

```bash
git checkout -b feature/AmazingFeature
```

3. Commit your changes:

```bash
git commit -m 'Add some AmazingFeature'
```

4. Push to the branch:

```bash
git push origin feature/AmazingFeature
```

5. Open a pull request.
## License

[MIT](https://choosealicense.com/licenses/mit/)

Distributed under the MIT License. See LICENSE for more information.
## Contact

Your Name - sumitaggarwal23021999@gamil.com

Project Link: https://github.com/sumitaggarwal23021999/DogBreedsList
