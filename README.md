# News App (HarmonyOS / ArkTS)

Project Duration: Oct 2023 – Jan 2024

A mobile news and content application built with **HarmonyOS ArkTS**, featuring multiple pages, reusable components, and integration with a RESTful backend service.  
The app demonstrates declarative UI development, state management with `@State`, navigation with `@ohos.router`, and HTTP communication using `@ohos.net.http`.

## Features

### Multi-tab Home Page

- The main screen (`IndexPage.ets`) loads a list of navigation items from the backend:
  - Navigation data is fetched from an API such as `/nav/app`.
  - Each navigation tab corresponds to a different content category (for example: news, shopping, sports).
- Uses `@State` to keep UI reactive:
  - `navList: Nav[]` – navigation tabs
  - `index: number` – currently selected tab index
- On appearance (`aboutToAppear`), the page:
  - Sends an HTTP GET request using the custom `Http` class.
  - Parses backend JSON into strongly-typed `Nav` and `News` objects.

### News Listing

- News data is modeled in `model/Clazz.ets` as the `News` class:
  - Typical fields include `id`, `title`, `content`, `ctime`, `image`, `price`, and a category `type`.
- Each news item is rendered using the `NewsItem` component (`views/NewsItem.ets`):
  - Shows the category label (e.g. news / shopping / sports).
  - Displays title, thumbnail image, timestamp, price, and summary.
  - Uses ArkTS declarative layout APIs (`Column`, `Row`, `Text`, `Image`) to compose the UI.

### Sports Page

- `SportPage.ets` provides a sports-focused view:
  - Fetches `Team` and `Player` data from backend API (`/team/app`).
  - Uses `Player` and `Team` model classes defined in `Clazz.ets`.
  - Displays:
    - Team logo, name, introduction, and star rating.
    - A list or grid of players with their images and names.
  - Uses `@State` fields such as:
    - `playerList: Player[]`
    - `teamList: Team[]`
    - `team: Team`
    - `cnt` (star count)
  - Images are loaded from a file server using a base URL such as `http://localhost:3000/file/`.

### Order / Purchase Flow

- `OrderPage.ets` implements a simple order form:
  - Receives a `News` object from the previous page (via `router` parameters).
  - Shows selected item information:
    - Title
    - Image
    - Price
  - Provides inputs to fill in:
    - Receiver name
    - Phone number
    - Shipping address (default value is set, e.g. a campus address)
    - Quantity
  - Uses a shared `TitleBar` component at the top of the page.

### Authentication Screens

The app also includes basic authentication-related pages with UI layouts:

- `LoginPage.ets`
  - Displays a login form with account and password fields.
  - Uses `TitleBar` and a central avatar/image.
- `RegistePage.ets`
  - Registration page that collects username and other information.
  - Uses `Http` and `@ohos.net.http` to send registration requests.
- `ResetPasswordPage.ets`
  - Password reset page that collects username, security information (e.g. security question answer), and new password.
  - Communicates with backend using the shared `Http` utility.
- All input fields share a common `inputStyle` through `@Extend(TextInput)` for consistent look and feel.


## Architecture

### Core Technologies

- **HarmonyOS / ArkTS** declarative UI
- **@ohos.router** for navigation between pages
- **@ohos.net.http** for backend HTTP requests
- **@ohos.promptAction** for toast-style notifications and dialogs
- Custom `Http` class for:
  - Building URLs
  - Attaching query parameters
  - Parsing JSON responses into typed models

### Networking

The `Http` utility class (`model/Http.ets`) centralizes all network logic:

- `Http.host` defines the backend base URL, e.g.:
  ```ts
  static host = 'http://localhost:3000'
  ```
- `get(data?) `constructs the full URL with optional query parameters.
If `data` is provided, the method appends each key–value pair to the URL as query parameters.  
This allows different pages to request filtered or parameterized API data without rewriting URL logic.

- `parse(resp)` converts the raw HTTP response into usable JavaScript objects:
  - Ensures `resp.result` is treated as a UTF-8 string
  - Outputs raw data to logs for debugging
  - Uses `JSON.parse` to convert JSON into typed model instances (Nav, News, Player, Team)

These helper methods make API communication consistent across the entire app.  
Typical backend endpoints include:

- `/nav/app` – loads navigation categories on the home page
- `/team/app` – fetches sports team and player data
- Authentication-related endpoints (login, registration, password reset)
- Order-related endpoints used in the checkout page


## Reusable Components

### TitleBar

Located in `views/TitleBar.ets`.  
A simple, consistent top bar component used across multiple pages.

- Accepts:
  ```ts
  @Param title: string
  ```
- Provides:
  - A back button using `router.back()`
  - Centered title text

This component ensures a consistent navigation experience across multiple pages and avoids duplicated UI code.

### NewsItem

Located in `views/NewsItem.ets`, this component renders an individual news entry inside the news list.

- Displays:
  - Category tag (based on `news.type`)
  - Main title text
  - Timestamp and metadata
  - Thumbnail image loaded from a remote URL
  - Optional pricing information
- Structured using ArkTS declarative UI primitives such as `Column`, `Row`, `Flex`, `Image`, and `Text`
- Supports a `@Preview` decorator for design-time preview in DevEco Studio

## How to Run

1.Open the project using DevEco Studio.

2.Launch a HarmonyOS simulator or connect a compatible device.

3.Start your backend server (default: http://localhost:3000).

4.Update Http.host in Http.ets if a different backend address is used.

5.Build and run the entry module.

## APP ScreenShots
<img width="516" height="477" alt="image" src="https://github.com/user-attachments/assets/e4df13ee-322d-4cac-a9a7-60eb299ca1dc" />
<img width="456" height="435" alt="image" src="https://github.com/user-attachments/assets/1906c6c7-7fd0-4142-818d-0657aac293ab" />


