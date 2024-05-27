const express = require("express");
const axios = require("axios");
require("dotenv").config();
const querystring = require("querystring");

const app = express();
const port = 8888;

const client_id = process.env.CLIENT_ID;
const client_secret = process.env.CLIENT_SECRET;
const redirect_uri = process.env.REDIRECT_URI;


app.get("/login", (req, res) => {
  const state = generateRandomString(16);
  const scope = "user-read-private user-read-email";

  const authURL =
    "https://accounts.spotify.com/authorize?" +
    querystring.stringify({
      response_type: "code",
      client_id: client_id,
      scope: scope,
      redirect_uri: redirect_uri,
      state: state,
    });

  res.redirect(authURL);
});

app.get("/callback", async (req, res) => {
  const code = req.query.code || null;
  const state = req.query.state || null;

  try {
    const response = await axios.post(
      "https://accounts.spotify.com/api/token",
      querystring.stringify({
        grant_type: "authorization_code",
        code: code,
        redirect_uri: redirect_uri,
        client_id: client_id,
        client_secret: client_secret,
      })
    );

    const access_token = response.data.access_token;
      const refresh_token = response.data.refresh_token;
      
      const userInfoResponse = await axios.get(
        "https://api.spotify.com/v1/me",
        {
          headers: {
            Authorization: "Bearer " + access_token,
          },
        }
      );

      const userInfo = userInfoResponse.data;
      const name = userInfo.display_name;
      const email = userInfo.email;
      const id = userInfo.id;


    // Redirect the user to the Flutter app with tokens
    res.redirect(
      `test-spotify-auth://callback?access_token=${access_token}&refresh_token=${refresh_token}&user_name=${name}&user_email=${email}&user_id=${id}`
    );
  } catch (error) {
    res.send("Error during token exchange");
  }
});

const generateRandomString = (length) => {
  let text = "";
  const possible =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for (let i = 0; i < length; i++) {
    text += possible.charAt(Math.floor(Math.random() * possible.length));
  }
  return text;
};

app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}`);
});
