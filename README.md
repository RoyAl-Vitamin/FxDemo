# CryptoFile

## Develop

Download JavaFX from [Gluon](https://gluonhq.com/products/javafx/) 21 version and unpack
In Idea IDE set as VM option:

```
--module-path "\javaFX\unpack\sdk\javafx-sdk-21\lib" --add-modules javafx.controls,javafx.fxml
```

## How to build

```termional
mvn clean javafx:run
```

## Собираем в исполняемое приложение

Получить список зависимостей проекта:

```bash
/home/alex/.jdks/openjdk-21.0.2/bin/jdeps --ignore-missing-deps --multi-release=21 --print-module-deps target/classes/vi/al/ro/Main.class
```

Создать среду выполнения в папке /target:

```bash
/home/alex/.jdks/openjdk-21.0.2/bin/jlink --no-header-files --no-man-pages --compress=2 --strip-debug --module-path "/home/alex/Documents/javafx-sdk-21/lib" --add-modules "java.base,jdk.localedata,javafx.controls,javafx.fxml" --include-locales=en --output target/java-runtime
```

Перед выполнением следующей команды необходимо положить собранный jar `FxDemo-1.0-SNAPSHOT.jar` в папку, указанную в 
параметре `--input`:

```bash
mkdir -p target/installer/input/libs && cp target/FxDemo-1.0-SNAPSHOT.jar target/installer/input/libs
```

Команда по сборке приложения в формате `app-image`:

```bash
/home/alex/.jdks/openjdk-21.0.2/bin/jpackage --type app-image --dest target/installer --input target/installer/input/libs --name JPackageScriptFX --main-class vi.al.ro.Main --main-jar FxDemo-1.0-SNAPSHOT.jar --module-path "/home/alex/Documents/javafx-sdk-21/lib" --java-options "-Dprism.order=sw,j2d -Dprism.verbose=true -Xmx2048m" --runtime-image target/java-runtime --app-version 1.0-SNAPSHOT --vendor "RoyalVitamin" --copyright "Copyright © 2024 RAV"
```

type: [app-image rpm deb]

Необходимо скопировать библиотеки для запуска следующей командой:

```bash
cp /home/alex/Documents/javafx-sdk-21/lib/libglass.so \
/home/alex/Documents/javafx-sdk-21/lib/libglassgtk3.so \
/home/alex/Documents/javafx-sdk-21/lib/libjavafx_font.so \
/home/alex/Documents/javafx-sdk-21/lib/libjavafx_font_freetype.so \
/home/alex/Documents/javafx-sdk-21/lib/libjavafx_font_pango.so \
/home/alex/Documents/javafx-sdk-21/lib/libprism_sw.so \
/home/alex/IdeaProjects/FxDemo/target/installer/JPackageScriptFX/lib/app/
```

-Djava.library.path добавить путь до JavaFxSdk???

## How to debug app

See instruction:

1. [Debug](https://stackoverflow.com/a/62654500/9401964) javafx app 1;
2. [Debug](https://stackoverflow.com/a/61341407/9401964) javafx app 2;
3. [Debug](https://stackoverflow.com/a/61474494/9401964) javafx app 3;
4. [Create](https://stackoverflow.com/questions/68871952/how-to-use-jpackage-to-make-a-distribution-format-for-javafx-applications) distribution file;
5. [Пример](https://walczak.it/blog/distributing-javafx-desktop-applications-without-requiring-jvm-using-jlink-and-jpackage) с использованием Gradle;
6. [Сборка](https://github.com/dlemmermann/JPackageScriptFX);
7. [Packaging guid](https://docs.oracle.com/en/java/javase/20/jpackage/packaging-tool-user-guide.pdf).