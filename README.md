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

1. Herokuにログインする。※毎回  
$ heroku login

2. アセットプリコンパイルをする。※初回のみ  
$ rails assets:precompile RAILS_ENV=production

3. コミットする。※初回のみ  
$ git add -A  
$ git commit -m "init"

4. Herokuに新しいアプリケーションを作成する。※初回のみ  
$ heroku create

5. Heroku buildpackを追加する。※初回のみ  
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs

6. Herokuにデプロイをする。※初回のみ  
$ git push heroku master

7. データベースの作成。※初回のみ  
$ heroku run rails db:migrate

8. アプリケーションにアクセスする。※毎回  
$ heroku open