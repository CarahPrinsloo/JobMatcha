# JobMatcha

JobMatcha is an online job-matching networking mobile application. Users "swipe right" to like or "swipe left" to dislike other users' profiles, which include their photo, a short bio, and other relevant information. JobMatcha uses a "double opt-in" system where both users must match before they can exchange messages.

JobMatcha consist of two programs: the server and the client. 

The server program is responsible for managing the database of users. 

The client program is responsible for onboarding a user, allowing the user to login, and providing an interface where the user can interact with other users.

## Usage

Setup:

```
chmod +x script.sh
make setup
```

Executing the server program:

```
chmod +x script.sh
make run-server
```

Executing the client program:

```
chmod +x script.sh
make run-client
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
