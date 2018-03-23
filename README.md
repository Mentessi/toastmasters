[![CircleCI](https://circleci.com/gh/Mentessi/toastmasters.svg?style=svg)](https://circleci.com/gh/Mentessi/toastmasters)

# README

## About

Each week Toastmaster clubs meet to support people with public speaking. Part of these meetings involve club members creating 'table-topics' which are short impromptu talk topics which other attendees have to talk about for 90 seconds (with no advance preparation).

This project is a site where Toastmaster members can upload and share their table topic ideas for others to use :)

## Database creation

```
cp ./config/database.yml.example ./config/database.yml

rails db:setup

```

## Environment set-up

Product assumes use of direnv to manage environment variables. It can be install with brew:

```
brew install direnv
```

Create a `.envrc` file by copying from the given example.

```
cp .envrc.example .envrc

```



