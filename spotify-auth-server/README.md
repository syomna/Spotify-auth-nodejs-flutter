# Spotify Authentication API Example

This project demonstrates how to use the Spotify authentication API in both Node.js and Flutter.

## Project Structure

The project is organized into two main folders:

- `spotify-auth-server`: Contains the Node.js backend server.
- `test_spotify_auth`: Contains the Flutter frontend application. (you can use any framework you want ofc)

## Prerequisites

Before running the applications, ensure you have the following:

- **Spotify Account:** You need a Spotify account to access the Spotify Developer Dashboard and create a new application.
- **Spotify Application:** Create a new application on the Spotify Developer Dashboard to obtain your client ID and client secret.
- **Redirect URI:** Configure a redirect URI for your application in the Spotify Developer Dashboard.

## Setting Up Spotify Application

1. **Create a Spotify Account:**

   If you don't already have a Spotify account, [sign up here](https://www.spotify.com/signup/).

2. **Create a Spotify Application:**

   - Go to the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/applications).
   - Log in with your Spotify account.
   - Click on **Create an App**.
   - Fill in the required information and click **Create**.
   - Note down your **Client ID** and **Client Secret** for later use.

3. **Configure Redirect URI:**

   - In your Spotify application settings, add the redirect URI
`http://localhost:8888/callback`

## Node.js Backend

### Setup

1. **Clone the Repository**

   ```bash
   git clone
   cd spotify-auth-server
   ```

2. **Install Dependencies**

   ```bash
   npm install
   ```

3. **Set Up Environment Variables**

   Update `.env` file in the `spotify-auth-server` directory with the following:

   ```dotenv
   CLIENT_ID=your_spotify_client_id
   CLIENT_SECRET=your_spotify_client_secret
   REDIRECT_URI=http://localhost:8888/callback
   ```

4. **Run the Application**

   ```bash
   npm start
   ```

### Notes

- This example uses `express` and `axios` to handle the server and HTTP requests.
- Make sure to replace `your_spotify_client_id` and `your_spotify_client_secret` with your actual Spotify credentials.

## Flutter

### Setup

1. **Open the Flutter Project**

   Navigate to the `test_spotify_auth` directory in your terminal:

   ```bash
   cd test_spotify_auth
   ```

2. **Run the Application**

   ```bash
   flutter run
   ```

### Usage

- Open the Flutter application on an iOS or Android simulator/device.
- Tap the "Authorize with Spotify" button to initiate the Spotify authentication flow.
- After authentication, the application will display the user information retrieved from the Spotify API.

---