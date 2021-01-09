## User Model

| カラム名 | データ型 |
|----|----|
| name | string |
| email | string |
| password_dijest | string |


## Task Model

| カラム名 | データ型 |
|----|----|
| title | string |
| detail | text |
| deadline | datetime |
| priority | integer |
| status | string |


## Label Model

| カラム名 | データ型 |
|----|----|
| name | string |

## Herokuデプロイの手順

1. Herokuにログインする。  
$ heroku login

2. アセットプリコンパイルをする。  
$ rails assets:precompile RAILS_ENV=production

3. コミットする。  
$ git add -A  
$ git commit -m "init"

4. Herokuに新しいアプリケーションを作成する。  
$ heroku create

5. Heroku buildpackを追加する。  
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs

6. Herokuにデプロイをする。  
$ git push heroku master

7. データベースの移行。  
$ heroku run rails db:migrate

8. アプリケーションにアクセスする。  
$ heroku open