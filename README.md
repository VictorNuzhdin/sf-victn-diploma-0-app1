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
<details open><summary><h3><b>=Change Log | История изменений</b></h3></summary>

```
#project_status :: IN_PROGRESS

2024-05-22_2016 :: stage02: DONE: разработана CI/CD конфигурация для автоматической сборки и деплоя веб-приложения на сервере [srv]
2024-05-22_2016 :: stage02: TEST: повторный тест ранее разработанной CI/CD конфигурации и описание изменений в файле README
2024-05-17_1530 :: stage02: DONE: реализован начальный CI/CD:
                                  * созданы GitHub Actions Workflow манифесты которые обеспечивают следующее поведение:
                                    - при пуше и установке Git Тега версии текущего коммита, в GitHUb создают "Pull request" (PR) на слияние с веткой "main"
                                    - после подтверждения PR разработчиком, производится Слияние изменений с веткой "main" и создается Релиз от последнео коммита
                                    - средствами GitHub собирается Docker Образ с Тегами "latest" и "версия релиза" (например: 0.0.2)
                                    - собранный Docker Образ с двумя Тегами отправляется в "DockerHub" репозиторий
                                  * т.о реализована GitOps CI/CD практика автоматической сборки Docker Образа при пуше Теггированного кода в GitHub Репозиторий
2024-05-10_2240 :: stage02: TEST: тестирование CI/CD в DockerHub c помощью GitHub Actions
2024-05-08_2156 :: stage01: FIX:  подготовка к CI/CD - исправление ошибок тестового деплоя на [srv]
2024-05-06_1428 :: stage01: DONE: разработано контейнеризированное веб-приложение на связке Python + Django
2024-04-26_1345 :: stage00: DONE: создан пустой репозиторий

#--TODO-------- :: В_ПЛАНАХ

2024-00-00_0000 :: stage03: TODO: разработать конфигурации для автоматического деплоя в Kubernetes Кластере

```
<br>


### =Changes Details | Описание изменений (новые в начале)

<!--START_DETAILS_20-->
<details open><summary><h3><b>Стадия #2: CI/CD средствами GitHub</b></h3></summary>

```bash

#--ВВЕДЕНИЕ

#..в описании ниже будет продемонстрирована работа в двух связанных проектах/репозиториях
#
#  1. инфраструктурный проект "sf-victn-diploma-1-infra" создающий необходимые облачные ресурсы (сеть и ВМ [srv])
#     https://github.com/VictorNuzhdin/sf-victn-diploma-1-infra
#   
#  2. текущий проект "sf-victn-diploma-0-app1" веб-приложения которое будет развернуто на ВМ [srv] в качестве теста развертывания
#     https://github.com/VictorNuzhdin/sf-victn-diploma-0-app1
#


#--ВЫПОЛНЕНИЕ

#..в проекте "sf-victn-diploma-1-infra"
#  *проверяем в каком каталоге находимся
#  *выпускаем новый IAM-токен для авторизации Terraform в Облаке Yandex.Cloud
#  *уничтожаем текущие ресурсы для последующего чистого теста

$ pwd                               ## /home/devops/github/sf-victn-diploma-1-infra
$ ./project_ycTokenChange.sh
$ ./project_tfUndeployAll.sh        ## Destroy complete! Resources: 4 destroyed.


#..в проекте "sf-victn-diploma-0-app1"
#  *проверяем в каком каталоге находимся
#  *в шелл-скрипте который производит тестовые изменения меням значение тега версии на +1
#  *выполняем скрипт внесения тестовых изменений в код
#   - в файл "./app/webapp/APP_VERSION" (отображается на главной странице веб-приложения) будет записана текущая версия
#   - в файл "./_logs/fake.log" будет записано некоторое сообщение для эмитации логирования
#   - эти изменения будут добавлены в коммит с тегом версии и отправлены в GitHub репозиторий (что запустит CI/CD)

$ pwd                                   ## /home/devops/github/sf-victn-diploma-0-app1

$ nano project_makePublishChanges.sh    ## RELEASE_VERSION="0.0.3"

$ ./project_makePublishChanges.sh
        ..
            On branch main
            Your branch is up to date with 'origin/main'.

            Changes not staged for commit:
                (use "git add <file>..." to update what will be committed)
                (use "git restore <file>..." to discard changes in working directory)
                    modified:   _logs/fake.log
                    modified:   app/webapp/APP_VERSION
                    modified:   project_makePublishChanges.sh
        ..
            no changes added to commit (use "git add" and/or "git commit -a")
            ---
            Already up to date.
            ---
            [main eda526e] step02: release 0.0.3
                3 files changed, 3 insertions(+), 2 deletions(-)
            Enumerating objects: 15, done.
            Counting objects: 100% (15/15), done.
            Delta compression using up to 2 threads
            Compressing objects: 100% (7/7), done.
            Writing objects: 100% (8/8), 684 bytes | 342.00 KiB/s, done.
            Total 8 (delta 6), reused 0 (delta 0), pack-reused 0
            remote: Resolving deltas: 100% (6/6), completed with 6 local objects.
            To https://github.com/VictorNuzhdin/sf-victn-diploma-0-app1
                e5c9a08..eda526e  main -> main
            ---
            On branch main
            Your branch is up to date with 'origin/main'.

            nothing to commit, working tree clean

#       (+) все отработало как ожидалось:
#           - изменения успешно ушли в GitHub


#..в GitHub репозитории
#  * проверяем приход изменений
#  * подтверждаем автоматически созданный "Pull request" на вливание изменений в ветку "main"
#  * проверяем выполнение автоматически запускаемых манифестов "Git Hub Actions Workflow" описанных в файлах
#    ./.github/workflows/publishApp_stage1_makeRelease.yml
#    ./.github/workflows/publishApp_stage2_makePushImage.yml
#  * проверяем создание GitHub Релиза кода веб-приложения

https://github.com/VictorNuzhdin/sf-victn-diploma-0-app1
    - видно что последний релиз: v0.0.2
    - проверяем "Pull requests"
    
https://github.com/VictorNuzhdin/sf-victn-diploma-0-app1/pulls
    - видим новый PR "chore(main): release 0.0.3"
    - подтверждаем его
		
chore(main): release 0.0.3 #8
https://github.com/VictorNuzhdin/sf-victn-diploma-0-app1/pull/8
    >This branch has no conflicts with the base branch - Merge pull request

            Message: release 0.0.3
                     *было: "chore(main): release 0.0.3"

    >Commit merge

проверяем состояние GitHub Actions
https://github.com/VictorNuzhdin/sf-victn-diploma-0-app1/actions
    - идет выполнение Workflow инструкций.. ждем
      * GitlabSync #32: Commit 735b7d5        -- УСПЕШНО
      * release-please #16: Commit 735b7d5    -- УСПЕШНО
      * build-docker-image #7: Commit 735b7d5 -- УСПЕШНО

#    (+) все отработало как ожидалось:
#        - ошибок при выполнении "GitHub Actions Workflow" нет
#        - релиз на основе указанной в скрипте версии создан
#        - docker образ создан и отправлен в DockerHub репозиторий (далее будет проверка)


#..в DockerHub репозитории
#  *проверяем Образы в репозитори, теги версий и дату последнего изменения

https://hub.docker.com/repository/docker/dotspace2019/nve-diploma-webapp/tags
				
            latest      Digest: bff6c9643944    Last pull: 2024.05.22 13:53
            0.0.3       Digest: bff6c9643944    Last pull: 2024.05.22 13:53

#    (+) все отработало как ожидалось:
#        - в репозитории DockerHub созданы актуальные версии Docker Образов


#..в проекте "sf-victn-diploma-1-infra"
#  *проверяем в каком каталоге находимся
#  *выпускаем новый IAM-токен для авторизации Terraform в Облаке Yandex.Cloud
#  *выполняем шелл-скрипты которые в Облаке Yandex.Cloud создают виртуальную сеть, подсеть и ВМ [srv]

$ pwd                               ## /home/devops/github/sf-victn-diploma-1-infra
$ ./project_ycTokenChange.sh
$ ./project_tfDeployNetwork.sh      ## Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
$ ./project_tfDeployMonitor.sh      ## Apply complete! Resources: 2 added, 0 changed, 0 destroyed. | Outputs: monitor_external_ip = "158.160.85.78"


#..проверяем результат
#  *проверяем работу основной страницы Nginx веб-сайта на сервере [srv]
#  *проверяем работу основной страницы Python Django веб-приложения на сервере [srv]

https://srv.dotspace.ru/

            Welcome to [srv.dotspace.ru] (Monitoring and CI/CD tasks)
            ---
            *quick_linx
             0. https://dotspace.ru
                *root domain
             1. My Python Django Webapp with PostgreSQL DB
                *internal dockerized service #1
             2. PostgreSQL Administrator (pgAdmin)
                *internal dockerized service #2

https://srv.dotspace.ru/
>My Python Django Webapp with PostgreSQL DB
 https://srv.dotspace.ru/apps/pg-django-greetings/

            Hello Words :: Home
            --
            BLR | CHN | DEU | ENG | ESP | FRA | ITA | JPN | KOR | RUS | UKR | ALL | BONUS
            --
            Webapp version: [2024-05-22T13:47:39+06] :: step02: release 0.0.3
            Webapp time...: 2024-05-22 15:46:31

#        (+) все отработало как ожидалось:
#            - ВМ [srv] успешно создана и домашняя страница ее веб-сайта доступна по HTTPS протоколу
#            - при создании [srv] успешно развернут "Docker Compose" Стек запускающий контейнеризированное Python Django веб-приложение
#              которое работает с БД под управлением СУБД PostgreSQL развернутого также с помощью этого стека


#--ЗАКЛЮЧЕНИЕ

#  (i) на этом Стадия #2 (часть1) разработки CI/CD конфигурации завершена, в результате чего выполнено
#      *созданы манифесты "GitHub Actions Workflow" которые при пуше коммита в репозиторий с Тегом версии
#       - автоматически создают "Pull Request" (PR) на слияние изменений с веткой "main" для ручной проверки кода ведущим разработчиком
#       - после подтверждения PR происходит:
#         1. вливание изменений в ветку "main"
#         2. автоматическое создание Релиза кода на основании переданного Тега версии и на основании последнего коммита
#         3. автоматическое создание Docker Образа и отправки его в Docker Hub репозиторий
#            при этом Docker Образ также Маркируется двумя Docker Тегами: latest и версияРелиза (пример: latest, 0.0.2)
#      *с помощью связанного проекта, в облаке "Yandex.Cloud", с помощью Terraform IaC конфигурации создана ВМ [srv] на которой:
#       1. развернут HTTPS веб-сайт с домашней страницей для удобства перехода на веб-приложения сервера
#       2. с помощью "Docker Compose" развернуто контейнеризированное Python Django веб-приложение 
#          Образы для которого скачивались непосредственно с персонального DockerHub репозитория
#
#      *основная страница веб-сайта сервера [srv] доступна по URL
#       https://srv.dotspace.ru/
#
#      *основная страница веб-приложения развернутого на сервере [srv] доступна по URL
#       https://srv.dotspace.ru/apps/pg-django-greetings/
#
#      *страница авторизации веб-приложения "pgAdmin" для работы с БД PostgreSQL на сервере [srv] доступна по URL
#       https://srv.dotspace.ru/apps/pg-admin/

# (i) на последующих Стадиях планируется к реализации:
#     - разработка эквивалентной CI/CD конфигурацию средствами GitLab,
#       которая по приходу в репозиторий кода с тегом версии будет также выполнять сборку и публикацию Docker Образа в DockerHub Репозиторий,
#       но автоматически развертывать его уже в Kubernetes Кластере,
#       который создается в связанном проекте "sf-victn-diploma-1-infra" (см. ссылки в начале)
#

```

</details>
<!--END_DETAILS_20-->


<!--START_DETAILS_10-->
<details><summary><h3><b>Стадия #1: Разработка контейнеризированного веб-приложения</b></h3></summary>

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
#     - протестировать развертывание Стека веб-приложения на сервере мониторинга [srv] из связанного проекта
#     - разработать CI/CD конфигурацию по автоматической сборке средствами GitHub Docker Образа веб-приложения
#       с его автоматической публикацией в репозиторий DockerHub
#       и полу-автоматическим развертыванием этого Образа на сервере мониторинга [srv] (в качестве теста)
#     - разработать эквивалентную CI/CD конфигурацию средствами GitLab,
#       которая по приходу в репозиторий кода с тегом версии будет также выполнять сборку и публикацию Docker Образа в DockerHub Репозиторий,
#       но автоматически развертывать его уже в Kubernetes Кластере,
#       который создается в связанном проекте "sf-victn-diploma-1-infra" (см. ссылки в начале)
#

```

</details>
<!--END_DETAILS_10-->
<br>


### =SCREENSHOTS | Снимки экрана / Иллюстрации

<!--START_SCREENS_20-->
<details open><summary><h3><b>Стадия #2 : : CI/CD средствами GitHub</b></h3></summary>
* 1. начальное состояние: в GitHub репозитории нет релизов <br>
* 2. пришли изменения кода, видно новый коммит <br>
* 3. созданы манифесты "GitHub Actions Workflow" для создания Релиза и сборки Docker Образа <br>
* 4. подтвержден "Pull request" на слияние коммита с изменениями кода веб-приложения с main веткой <br>
* 5. автоматически сработали манифесты "GitHub Actions Workflow" создания Релиза и сборки Образа <br>
* 6. создан и виден в репозитории новый релиз v0.0.2 <br>
* 7. в репозитории DockerHub появились новые сборки/теги Образов (latest и 0.0.2) <br>
* 8. конечное состояние: страница веб-приложения после создания ВМ "srv" (версии 0.0.2, 0.0.3) <br><br>

![screen](_screens/sf-victn-diploma-0-app1__stage2__1_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__2_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__3_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__4_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__4_02.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__4_03.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__5_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__6_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__6_02.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__7_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__8_01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage2__8_02.png?raw=true)

</details>
<!--END_SCREENS_20-->
<br>

<!--START_SCREENS_10-->
<details><summary><h3><b>Стадия #1 : : Демонстрация веб-приложения</b></h3></summary>
* демонстрация Python Django веб-приложения на учебной ВМ "VMware Workstation" <br>
* демонстрация веб-приложения для работы с СУБД PostgreSQL (pgAdmin4) <br>
* выполнение тестового sql-запроса к таблице БД веб-приложения с помощью "pgAdmin4" <br><br>

![screen](_screens/sf-victn-diploma-0-app1__stage1__01.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage1__02.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage1__03.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage1__04.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage1__05.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage1__06.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage1__07.png?raw=true)
<br>
![screen](_screens/sf-victn-diploma-0-app1__stage1__08.png?raw=true)

</details>
<!--END_SCREENS_10-->
<br>

[Каталог скриншотов](_screens)
<br>
