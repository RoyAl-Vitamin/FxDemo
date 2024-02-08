# FxDemo

## Разработка

Скачать JavaFX с сайта [Gluon](https://gluonhq.com/products/javafx/) 21 версию и распаковать
В Idea IDE установить "VM option", заполнив путь до SDK и модули, которые используются в проекте:

```
--module-path "\javaFX\unpack\sdk\javafx-sdk-21\lib" --add-modules javafx.controls,javafx.fxml
```

## Сборка

```termional
mvn clean javafx:run
```

## Собираем в исполняемое приложение

`$JAVA_HOME` - местоположение Java 21 в системе (Пример: /home/username/.jdks/openjdk-21.0.2).  
`$PATH_TO_FX` - местоположение Java FX SDK (Пример: /home/username/.jdks/javafx-sdk-21/lib).  
`$PATH_TO_FX_MODS` - местоположение Java FX jmods (Собранного окружения для сборки независимого приложения, пример: 
/home/username/.jdks/javafx-jmods-21.0.2)  

Получить список зависимостей проекта:

```bash
$JAVA_HOME/bin/jdeps --ignore-missing-deps --multi-release=21 --print-module-deps target/classes/vi/al/ro/Main.class
```

Для создания дистрибутива из чистого Java приложения нужно указать в параметре `module-path` значение 
`$JAVA_HOME/jmods`, для создания дистрибутива на основе Java FX - `$PATH_TO_FX_MODS`. Создать среду выполнения в папке 
/target:

```bash
$JAVA_HOME/bin/jlink --output target/java-runtime --module-path $PATH_TO_FX_MODS --add-modules "java.base,jdk.localedata,javafx.controls,javafx.fxml,javafx.graphics"
```

Перед выполнением следующей команды необходимо положить собранный jar `FxDemo.jar` в папку, указанную в параметре 
`--input`:

```bash
mkdir -p target/lib && cp target/FxDemo.jar target/lib/FxDemo.jar
```

Команда по сборке приложения в формате `app-image`:

```bash
$JAVA_HOME/bin/jpackage --type app-image --name FxDemo --input target/lib --main-jar FxDemo.jar --runtime-image target/java-runtime --main-class vi.al.ro.Main --dest target/installer --java-options "-Dprism.order=sw,j2d -Dprism.verbose=true -Xmx2048m" --app-version 1.0-SNAPSHOT --vendor "RoyalVitamin" --copyright "Copyright © 2024 RAV"
```

Параметр `type` может принимать значение одно из `app-image`, `rpm`, `deb` для Linux-систем.

Ссылки:

1. [Debug](https://stackoverflow.com/a/62654500/9401964) javafx app 1;
2. [Debug](https://stackoverflow.com/a/61341407/9401964) javafx app 2;
3. [Debug](https://stackoverflow.com/a/61474494/9401964) javafx app 3;
4. [Create](https://stackoverflow.com/questions/68871952/how-to-use-jpackage-to-make-a-distribution-format-for-javafx-applications) distribution file;
5. [Пример](https://walczak.it/blog/distributing-javafx-desktop-applications-without-requiring-jvm-using-jlink-and-jpackage) с использованием Gradle;
6. [Сборка](https://github.com/dlemmermann/JPackageScriptFX);
7. [Packaging guid](https://docs.oracle.com/en/java/javase/21/jpackage/packaging-tool-user-guide.pdf);
8. [Packaging overview](https://docs.oracle.com/en/java/javase/21/jpackage/packaging-overview.html);
9. [Распечатка всех модулей](https://onecompiler.com/questions/3ss6yr2as/how-to-print-all-module-names-with-packages-in-java9).
