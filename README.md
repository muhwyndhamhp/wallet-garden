# What is this repo?

This repository is part of the recruitment process for https://atask.id for Sr. Ruby on Rails Developer Position. 

## Design Decission
There are various design decission in this repository that tries to satisfy the requirement from the test. Such as 

#### Skipping STI in favor of Polymorphic Relationship
While STI is pretty commonly used. I personally don't like it as a it basically trying to jam several similar-but-not-same models into a single table.
This reduce a lot of what Relational Database can help us about regarding consistencies of our columns, and introduce a lot of exceptional rules on the table level. 

I personally prefer Polymorphic Relationship as it allows a table to loosely related to several different tables at once. Maintaining sync between Table and Model. 

#### Token Based Auth
As the requirement ask us to develop session implementation ourselves, I decided to move on with bearer-token based authentication.
It's fairly rudimentary as it does not have expiration mechanism, so the token will live forever, but I do create proper login and registration logic. 

You can register your account via:
```json
// POST: /api/v1/register
{
  "name": "your name",
  "email": "your email",
  "password": "your password",
  "password_confirmation": "re-confirm your password"
}
```
Then you can login via:
```json
// POST: /api/v1/login
{
  "email": "your email",
  "password": "your password"
}
```
Which then will return:
```json
{
  "auth_token": "your access token"
}
```
And you can use it by attaching to header of every request:
```
Authorization: Bearer <<your access token>>
```
It will also create wallet on every user/team/stock being created. Including during registration process. So your user immediately have wallet ready to go. 


#### API Namespace
All of the API in this code have prefix namespace of `/api/v1/`. This is to make sure the API is flexible enough for future revisions when necessary. 
