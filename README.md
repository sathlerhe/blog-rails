# Blog on Rails
I've made this app only to study more about ruby and ruby on rails. If you have any tips on how to improve my code, I would be very happy.

## Running the project
```shell
  # with rails
  bundle install
  rails server

  # with docker
  docker-compose up --build
```

## About the app
This app is a blog, with two tables:
Artcle     |
-----------|
title      |
content    |
user_id FK |

User                   |
-----------------------|
name                   |
email                  |
encrypted_password     |
reset_password_token   |
reset_password_sent_at |
jti                    |

## Routes
### User Routes
The user needs authentication, the route to create a signup is:

```shell
  curl --request POST \
    --url localhost:3001/users/signup \
    --header 'Content-Type: application/json' \
    --data "{ \"user\": { \"email\": \"email@mail.com\", \"name\": \"name\", \"password\": \"asdf\" }}"
```

The login route:

```shell
  curl --request POST \
    --url localhost:3001/users/login \
    --header 'Content-Type: application/json' \
    --data "{ \"user\": { \"email\": \"email@mail.com\", \"password\": \"asdf\" }}"
```
**In the singup and login routes, it returns the JWT Token in header**

The route to update user:

```shell
  curl --request PUT \
    --url localhost:3001/users/update \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer JWT_token' \
    --data "{ \"user\": { \"email\": \"email@mail.com\", \"name\": \"name\", \"password\": \"asdf\" }}"
```

The route to delete user:

```shell
  curl --request DELETE \
    --url localhost:3001/users/delete \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer JWT_token'
```

### Article routes

The route to list all articles:

```shell
  curl --request GET \
    --url localhost:3001/articles\?title=&order
```
Query params:
  * title -> Search by title
  * order -> asc || desc

The route to list an especific articles:

```shell
  curl --request GET \
    --url localhost:3001/articles/:id
```

The route to list the articles of an user:

```shell
  curl --request GET \
    --url localhost:3001/users/:id/articles
```

The route to create an article:

```shell
  curl --request POST \
    --url localhost:3001/articles \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer JWT_token' \
    --data "{ \"title\": \"title of article\", \"content\": \"content of the article\" }"
```

The route to update an article:

```shell
  curl --request PUT \
    --url localhost:3001/articles/:id \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer JWT_token' \
    --data "{ \"title\": \"title of article\", \"content\": \"content of the article\" }"
```

The route to Delete an article:

```shell
  curl --request DELETE \
    --url localhost:3001/articles/:id \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer JWT_token'
```
