### Summary: Include screen shots or a video of your app highlighting its features
Video attached.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized two keys areas of the project: clean architecture and local image caching. Clean architecture was important for ensuring code testability using the MVVM architecture. It also paved the way for future feature expansions, such as offline storage. To optimize performance, especially for recipes with images, I opted for local imaging caching. Swift's async/await feature efficiently handled asynchronous data loading, further reducing network calls.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I dedicated approximately 45 to 50 hours for this project. About 40 percent of my time was spent setting up the MVVM architecture and data modeling to ensure a clean and maintainable codebase. The remaining 30 percent was allocated to designing and building the user interface, adhering to the best practices of SwiftUI. The remaining time was utilized to implement local image caching, write unit tests, and optimize asynchronous operations to enchance the project's performance.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I did make a few significant trade-offs in my project:
- When I implemented custom image caching, I decided to set a maximum cache limit of 1 MB. I chose this value because I was caching small images retrieved from network calls, and my maximum file size was approximately 55 KB. This allowed me to cache around 15 images at the most.
- In my project, I utilized URLSession to make network calls to retrieve data. However, URLSession employs URLCache to cache URls. Consequently, if a user repeatedly requests the same URL, URLSession usually retrives the data from the cache instead of making a new network call. To prevent caching, I employed URLRequest to specify the caching policy before using URLSession. Consequently, if the user successfully retrieved the recipes, they would not make another call for quite some time, as we are not implementing pagination and fetching all recipes simultaneously.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I believe my user interface is the weakest part of my project. Despite my best efforts to design an intuitive interface, I faced challenges in accessing detailed recipe information during network calls. While we have the source URL, we cannot display source information on our device.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
Overall, this project provided an excellent opportunity to enhance my proficiency in SwiftUI, async/await, and local image caching. If I had more time, I would explore into features such as offline caching, advanced filtering, and integration with Core Data to further improve the app’s usability and ensure persistence. This project aligns with my commitment to delivering a high-performing, well-written, and user-focused application.
