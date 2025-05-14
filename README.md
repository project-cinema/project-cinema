# project cinema

## setup

### windows

* wslにubuntug入っているか確認する
    * wsl -l
* 入っていない場合
    * install wsl
        * https://qiita.com/toshi772/items/05f3c7e3a99df42d4cec
    * install ubuntu on wsl
        * wsl --install -d Ubuntu
* connect wsl by intellij idea
* setup on ubuntu

### ubuntu

* get token
    * https://github.com/settings/tokens
* run script

```bash
sh setup.sh
```

* execute idea back task
* run script

```bash

# npm install
./vendor/bin/sail npm install
# migrate db
./vendor/bin/sail artisan migrate

```

* execute idea front task
* forwerd 8000 and 5173 port
