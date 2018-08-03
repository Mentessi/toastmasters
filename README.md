[![CircleCI](https://circleci.com/gh/Mentessi/toastmasters.svg?style=svg)](https://circleci.com/gh/Mentessi/toastmasters)

# README

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



