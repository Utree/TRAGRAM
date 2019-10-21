# server Directory

## 環境構築
```
$ python3 -m venv penv
$ source penv/bin/activate
$ pip install  -r requirements.txt
```

## 使い方
```
cd project/
python manage.py makemigrations api_v1
python manage.py migrate
python manage.py runserver
```
