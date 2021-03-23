# README

## Run project
> 1. `docker build -dt api-server .`
> 2. `docker run -p 4000:4000 api-server`
> 3. for example:  `curl 127.0.0.1:4000/user/barbara11e`


## Routes
> * get `/user/{user-login}`
> * get `/user/{user-login}/{repository-name}`

## Task description
### BREQ1 Просмотр репозиториев пользователя

При запросе ресурса /user/:login приложение должно возвращать в ответе последние 10 репозиториев пользователя.

Ресурс: /user/:login

Тип запроса: GET

Формат ответа: JSON

Структура ответа:
```
{
  "response": {
    "user": {
      "name": "user name"
    },
    "repositories": [
      {
        "name": "repo name",
        "created_at": "repo created at date"
      }
    ]
  }
}
```

В противном случае, если искомого логина не существует, необходимо вернуть ошибку. Структура ответа:
```
{
  "response": {
    "error": “<Reason>"
  }
}
```


### BREQ2 Отображение коммитов в репозитории

При запросе ресурса GET /user/:login/:repo приложение должно возвращать в ответе последние 10 коммитов из master ветки запрашиваемого репозитория.

Ресурс: /user/:login/:repo

Тип запроса: GET

Формат ответа: JSON

Структура ответа:
```
{
  "response": {
    "repo": {
      "name": "repo name",
      "commits": [
        {
          "message": "commit message",
          "commit_date": "date-of-commit"
        }
      ]
    }
  }
}
```
В противном случае, если искомого репозитория не существует, необходимо вернуть ошибку.

Структура ответа:
```
{
  "response": {
    "error": “<Reason>"
  }
}
```