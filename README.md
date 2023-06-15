# About

本アプリは、自分の予定をカレンダーに記録しておけるスケジュールアプリです。  
効果としては、所有アイテムを一元管理することで余剰在庫回避によるコスト削減と釣行先で気づいてしまった忘れ物によるストレス軽減が期待できます。

# Install

本アプリをローカル環境で動作するには次のステップが必要です。

1. このリポジトリをクローンします。

```
$ git clone (your clone code)
```

2. カレントディレクトリを backend ディレクトリに変更します。

```
$ cd my-fishing-item/backend
```

3. backend に必要な依存関係をインストールします。

```
$ npm install
```

4. ローカルの PostgresDB を指定し、マイグレーションを実行します。

```
$ npm run migrate
```

5. ローカルサーバーを立ち上げます。

```
$ npm run start
```

6. カレントディレクトリを frontend ディレクトリに変更します。

```
$ cd ../frontend
```

7. frontend に必要な依存関係をインストールします。

```
$ npm install
```

8. React アプリを起動させます。

```
$ npm start
```

# Technology

- Express.js
- React.js
- Knex.js
- Postgres
- AWS
- Render
- Mocha, Chai

# Future Roadmap

- AWS の S3 を使った画像ファイルの管理
- ログイン機能の実装
