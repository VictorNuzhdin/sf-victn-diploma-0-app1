# sf-victn-diploma-0-app1
Skill Factory Diploma Project - Stage0 :: Dockerized Webapp
<br><br>


### =Linked Projects | Связанные проекты

* [GitHub | sf-victn-diploma-1-infra](https://github.com/VictorNuzhdin/sf-victn-diploma-1-infra)

<!--<br>-->

### =DockerHub Repoes | Репозитории Образов на DockerHub

* [DockerHub | dotspace2019/nve-diploma-webapp](https://hub.docker.com/repository/docker/dotspace2019/nve-diploma-webapp/tags)
* [DockerHub | dotspace2019/nve-diploma-postgres162](https://hub.docker.com/repository/docker/dotspace2019/nve-diploma-postgres162/tags)
* [DockerHub | dotspace2019/nve-diploma-pgadmin4](https://hub.docker.com/repository/docker/dotspace2019/nve-diploma-pgadmin4/tags)

<br>

### =Quick Info | Быстрая информация

```bash
#--Общее описание

В качестве прототипа веб-приложения для текущего проекта
было взято собственное "Python Django" веб-приложение
(подробности см. в app/README.md).

В текущем проекте используется доработанная под специфику контейнеризации версия,
разработаны все необходимые конфигурации для сборки "Docker" Образа
и запуска "Docker Compose" стека содержащего прочие компоненты помимо самого веб-приложения,
а именно: сервис "СУБД PostgreSQL v16.2" и система веб-администрирования "pgAdmin4 v8.6".

После применения "Docker Compose" конфигурации, на текущем сервере в изолированной "Docker" среде
запускаются все необходимые для работы веб-приложения контейнеризированные сервисы,
в результате чего мы получаем полностью работающее веб-приложение взаимодействующее с БД
без необходимости доп. настроек и установки доп. ПО в основную систему.

В дальнейшем, это контейнеризированное веб-приложение будет развернуто в Kubernetes кластере,
который создается в облаке "Yandex.Cloud" в рамках связанного проекта (см. ссылку выше).


```
<!--<br>-->

<!-- ### =Change log : : История изменений (новые в начале) -->
<details open><summary><h3><b>Стадия #1: Разработка контейнеризированного веб-приложения</b></h3></summary>

```
#project_status :: IN_PROGRESS

2024-05-08_2156 :: stage01: FIX:  подготовка к ci/cd - исправление ошибок тестового деплоя на [srv]
2024-05-06_1428 :: stage01: DONE: разработано контейнеризированное веб-приложение на связке Python + Django
2024-04-26_1345 :: stage00: DONE: создан пустой репозиторий

#--TODO-------- :: В_ПЛАНАХ

2024-00-00_0000 :: stage02: TODO: разработать CI/CD конфигурации для автоматической сборки и деплоя на сервере "srv"
2024-00-00_0000 :: stage03: TODO: разработать конфигурации для автоматического деплоя в Kubernetes Кластере

```
<br>


### =Changes Details : : Описание изменений (новые в начале)

<!--START_DETAILS_10-->
<details open><summary><h3><b>Стадия #1: Разработка контейнеризированного веб-приложения</b></h3></summary>

```bash

#--ИНСТРУКЦИЯ по развертыванию на своем локальном хосте

#..ТРЕБОВАНИЯ к хосту для работы с кодом проекта
1. Ubuntu 22.04
2. Git
3. Docker + Docker Compose
4. Веб-браузер (Mozilla Firefox или Google Chrome)


#..ПРОВЕРЯЕМ версии

$ hostnamectl | grep System
$ hostnamectl | grep Kernel | awk '{$1=$1;print}'

        Operating System: Ubuntu 22.04.4 LTS
        Kernel: Linux 5.15.0-105-generic

$ git --version
$ docker --version
$ docker compose version

        git version 2.34.1
        Docker version 26.1.1, build 4cf5afa
        Docker Compose version v2.27.0


#..ОПИСАНИЕ структуры проекта (краткое)

1. в каталоге "app" размещен код "Python Django" веб-приложения
2. в файле "Dockerfile" описаны инструкции по сборке Docker Образа с веб-приложением
3. в файле "docker-compose.yaml" описаны инструкции по развертыванию "Docker Compose" стека сервисов веб-приложения
4. созданы шелл-скрипты для ускорения выполнения частых рутинных операций
#  * project_docker00Show.sh                  :: показывает все текущие Образы, Контейнеры и Разделы
#  * project_docker11ImageBuild.sh            :: создает "Docker" Образ на основе инструкций "Dockerfile" (если требуется ручное создание Образа)
#  * project_docker21ComposeUp.sh             :: запускает "Docker Compose" стек и выводит информацию о созданных Образах, Контейнерах и Разделах
#  * project_docker22ComposeDownPrune.sh      :: уничтожает "Docker Compose" стек и удаляет все неиспользуемые Docker артифакты (кроме Образов)
#  * project_docker30DestroyAppImage.sh       :: удаляет только Образ с веб-приложением (если требуется пересобрать только его)
#  * project_docker31DestroyAllImagesCache.sh :: выполняет полную очистку: удаляет ВСЕ образы Стека, удаляет Кэш Сборки Docker (Build Cache)


#..ПРИМЕНЯЕМ конфигурацию / Docker Compose Стек
#  *работа по развертыванию и уничтожению ресурсов производится с помощью шелл-скриптов
#  *предполагается что на сервере ранее не был развернут данный "Docker Compose" стек (чистая установка)
#  *при первичном запуске  (холодный запуск) из удаленного репозитория скачиваются все необходимые Образы, создаются необходимые Слои для запуска Контейнеров, поэтому процесс может занять некоторое время
#  *при повторных запусках (горячий запуск) все происходит намного быстрее, т.к все Слои с данными уже созданы локально

$ ./project_docker21ComposeUp.sh

        --Running All Containers..

        [+] Running 45/45
        ✔ my-pgadmin Pulled                                           157.4s
        ✔ my-webapp Pulled                                            144.5s
        ✔ my-pgsrv Pulled                                             131.5s
        
        [+] Running 6/6
        ✔ Network sf-victn-diploma-0-app1_default   Created           0.7s
        ✔ Volume "sf-victn-diploma-0-app1_appdata"  Created           0.2s
        ✔ Volume "sf-victn-diploma-0-app1_pgdata"   Created           0.0s
        ✔ Container my-pgsrv                        Started           4.2s
        ✔ Container my-django-webapp                Started           7.1s
        ✔ Container my-pgadmin                      Started           7.6s

        --Checking Docker Images, Containers and Volumes..

        --Docker Images

        REPOSITORY                             TAG       IMAGE ID       CREATED        SIZE
        dotspace2019/nve-diploma-webapp        latest    8e03bcc8238b   13 hours ago   627MB
        dotspace2019/nve-diploma-pgadmin4      latest    5675b83f2460   6 days ago     502MB
        dotspace2019/nve-diploma-postgres162   latest    8e4fc9e18489   2 months ago   431MB


        --Docker Containers

        CONTAINER ID   IMAGE                                         COMMAND                  CREATED         STATUS                  PORTS                                            NAMES
        aaeff21e141d   dotspace2019/nve-diploma-webapp:latest        "/bin/sh -c 'cd /app…"   9 seconds ago   Up 1 second             0.0.0.0:8000->8000/tcp, :::8000->8000/tcp        my-django-webapp
        3028a7d4b5ae   dotspace2019/nve-diploma-pgadmin4             "/entrypoint.sh"         9 seconds ago   Up Less than a second   443/tcp, 0.0.0.0:5051->80/tcp, :::5051->80/tcp   my-pgadmin
        aadf5699255d   dotspace2019/nve-diploma-postgres162:latest   "docker-entrypoint.s…"   9 seconds ago   Up 4 seconds            0.0.0.0:5432->5432/tcp, :::5432->5432/tcp        my-pgsrv


        --Docker Volumes :: Objects

        DRIVER    VOLUME NAME
        local     1b90c13e87066b3dd13f3f1eb50730260debac7842efdd80e78d97f00f1a3c74
        local     sf-victn-diploma-0-app1_appdata
        local     sf-victn-diploma-0-app1_pgdata


        --Docker Volumes :: Directories

        1b90c13e87066b3dd13f3f1eb50730260debac7842efdd80e78d97f00f1a3c74
        backingFsBlockDev
        sf-victn-diploma-0-app1_appdata
        sf-victn-diploma-0-app1_pgdata
        metadata.db


#..ПРОВРЕЯЕМ результат с помощью веб-браузера :: Python Django веб-приложение

http://<IP_АДРЕС_ВАШЕГО_ХОСТА>:8000/
http://localhost:8000/

        Hello Words :: Home

        BLR | CHN | DEU | ENG | ESP | FRA | ITA | JPN | KOR | RUS | UKR | ALL | BONUS

        Webapp version: 2024.0505.235310
        Webapp time...: 2024-05-06 06:36:17

#   (i) если вы увидели тоже самое, значит все работает


#..ПРОВЕРЯЕМ результат с помощью веб-браузера :: pgAdmin4 (опционально, т.к все уже работает)

http://<IP_АДРЕС_ВАШЕГО_ХОСТА>:5051/login?next=/browser/
http://localhost:5051/login?next=/browser/

        pgAdmin | Login

              Email Address / Username: <ВАШ_АДРЕС_УКАЗАННЫЙ_В_ENV__PGADM_DEFAULT_EMAIL>
              Password................: <ВАШ_АДРЕС_УКАЗАННЫЙ_В_ENV__PGADM_DEFAULT_PASSWORD>

        >Login

#..слева добавляем сервер через меню по RMB (правая кнопка мыши)

>Servers - RMB - Register - Server..

        --General

            Name....: pg_local

        --Connection

            Hostname: my-pgsrv   # имя Docker Compose сервиса или "hostname" сервиса (pgserver)
            Port....: 5432
            Username: postgres
            Password: postgres
          
        >Save

#..слева раскрываем структуру и проверям что существует необходимая БД и таблица в БД

>Servers - pg_local - Databases - djangoapp - Schemas - public - Tables - greetings_words
#                                 ^^^ база данных                         ^^^ таблица

#..кликаем RMB по таблице и выбираем "Query Tool" для того чтобы написать тестовый SQL-запрос
#  *пишем select запрос в разделе "Query", кликаем по кнопке "Execute script" (F5)
#  *проверяем результат в разделе "Data Output"

--Query

        select * from greetings_words

--Data Output

        id   lang   word
        --   --    --
         1  ENG   hello
         2  FRA   bonjour
         3  ESP   hola
         4  ITA   ciao
         5  DEU   hallo
         6  UKR   вітаю
         7  BLR   прывітанне
         8  RUS   привет
         9  JPN   こんにちは
        10  CHN   你好
        11  KOR   안녕하세요

#   (i) если вы увидели тоже самое, значит все работает
#   (!) если таблицы не существует или таблица пустая,
#       значит что-то пошло не так при выполнении sql скриптов
#       в процессе применения Docker Compose стека


#--ДИАГНОСТИКА ошибок
#  *если при переходе на страницу веб-приложения мы не видим ничего, либо видим ошибку Django, либо список языков пустой
#   это означает что что-то пошло не так и sql-скрипт инициализации БД или скрипт добавления данных НЕ применились
#  *чтобы выяснить причину необходимо подключиться к оболочкам работающих контейнеров и выяснить причину
#  *диагностика и устранение проблем в веб-сервисах выходит за рамки данного проекта, но в целом это обычная работа в консоли сервера

$ docker ps -a
$ docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"
$ docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"

        NAMES              STATUS             IMAGE
        my-django-webapp   Up About an hour   dotspace2019/nve-diploma-webapp:latest
        my-pgsrv           Up About an hour   dotspace2019/nve-diploma-postgres162:latest
        my-pgadmin         Up About an hour   dotspace2019/nve-diploma-pgadmin4


$ docker exec -it my-django-webapp bash

        root@webapp:/# ls app                           ## webapp  static  sql  manage.py  requirements.txt  README.md
        root@webapp:/# ls app/sql                       ## djangoapp_data_inject.sh  djangoapp_data.sql ..
        
        root@webapp:/# psql postgres://pgserver:5432/djangoapp?sslmode=disable --username=postgres --tuples-only --csv -c "SELECT word FROM greetings_words WHERE lang = 'ENG';"

                hello

        root@webapp:/# exit


$ docker exec -it my-pgsrv bash

      root@pgserver:/# ls docker-entrypoint-initdb.d    ## init.sql

      root@pgserver:/# psql --host=pgserver --port=5432 --username=postgres --tuples-only --csv --command="select version()::varchar(100);"

              "PostgreSQL 16.2 (Debian 16.2-1.pgdg120+2) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14)"

      root@pgserver:/# psql --host=pgserver --port=5432 --username=postgres --db=djangoapp --tuples-only --csv --command="SELECT word FROM greetings_words WHERE lang = 'ENG';"

              hello

      root@pgserver:/# exit


#--ЗАКЛЮЧЕНИЕ

#  (i) на этом Стадия #1 создания контейнеризированного веб-приложения закончена
#      *веб приложение доработано под специфику проекта
#      *разработана "Docker Compose" конфигурация для контейнеризации веб-приложения и связанных сервисов
#      *протестирован локальный запуск конфигурации
#      *проверена локальная работа веб-приложения и связанных сервисов
#       http://localhost:8000
#       http://localhost:5051/browser/

# (i) на следующих Стадиях необходимо выполнить следующее:
#     - протестировать развертывание Стека веб-приложения на сервере мониторинга из всязанного проекта (srv)
#     - разработать CI/CD конфигурации по автоматической сборке Образов и развертыванию Контейнеров из них на сервере (srv)
#     - разработать CI/CD конфигурации по автоматической сборке Образов и развертыванию Контейнеров из них в Кластере Kubernetes
#       который формируется в связанном проекте "sf-victn-diploma-1-infra" (см. ссылки в начале)


```

</details>
<!--END_DETAILS_10-->
<br>


<!--START_SCREENS_10-->
<details open><summary><h3><b>Состояние стека веб-приложения на Стадии #1 : : Базовый функционал</b></h3></summary>
* демонстрация Python Django веб-приложения на учебной ВМ "VMware Workstation" <br>
* демонстрация веб-приложения для работы с СУБД PostgreSQL (pgAdmin4) <br>
* выполнение тестового sql-запроса к таблице БД веб-приложения с помощью "pgAdmin4" <br>
<br>

![screen](_screens/sf-victn-diploma-0-app1__1.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__2.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__3.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__4.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__5.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__6.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__7.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__8.png?raw=true)

</details>
<!--END_SCREENS_10-->
<br>

[Каталог скриншотов](_screens)
<br>
