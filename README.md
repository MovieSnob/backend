# I'm a be a Movie Snob

![Psycho](https://immabe-movie-snob.herokuapp.com/psycho.jpeg)

## Backend

I'm a be a Movie Snob is a tiny app to keep track of movies, watched with friends.

## API Docs

### Live domain

https://immabe-movie-snob.herokuapp.com

### Films

#### Create new film

Endpoint: `POST /films`
Params:

- `film[year]` Integer
- `film[title]` String
- `film[director]` String

#### Get all films

Endpoint: `GET /films`