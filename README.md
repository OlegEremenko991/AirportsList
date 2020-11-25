# Intro
Below you can read the requirements for the project.

## Login screen
1. Shows text fields for login and password, and the "Log in" button.
2. When the button is tapped, make a request to the server http://www.alarstudios.com/test/auth.cgi with parameters:
* username = XXX
* password = XXX
3. If the "status" in response JSON is "ok", then show the second screen, and if the "status" is not "ok" - inform the user that login or password is incorrect.
4. The server will return "ok" for login = "test", password = "123", then we go to the second screen remembering data from the "code" field in JSON.

## Main screen
1. Show TableView with data from JSON.
2. Get the data from http://www.alarstudios.com/test/data.cgi with request parameters:
* code = XXX from the previous request on login screen
* p = N - page starting from 1), returns 10 elements for every page.
3. Endless pagination must be supported: when we reach the bottom of the list - load new page.
4. Each element of the table must contain a picture (choose any external URL),
loaded asynchronously, and a name from JSON.
5. When you click on a cell, show the third screen with a map (Map screen).

## Map screen
1. Show all the fields from JSON and a map with a point, coordinates are the "lat" / "lon" fields from JSON.
2. Give the user an opportunity to go back to the Main screen.

## Screenshots and video

[Link to google drive](https://drive.google.com/drive/folders/1c4HiP1h8j98Mr-JlbZ7q2FrWNlOVMesq?usp=sharing)
