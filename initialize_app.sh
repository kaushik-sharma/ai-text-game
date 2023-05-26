#!/bin/bash

mkdir assets
cd assets || exit
mkdir images
mkdir icons
mkdir fonts

cd ..

mkdir lib
cd lib || exit

mkdir core
cd core || exit

mkdir managers
cd managers || exit
touch app_manager.dart
cd ..

mkdir errors
cd errors || exit
touch exceptions.dart
touch failures.dart
cd ..

mkdir network
cd network || exit
touch network_info.dart
cd ..

mkdir usecases
cd usecases || exit
touch usecase.dart
cd ..

mkdir utils
mkdir helpers
mkdir widgets

mkdir constants
cd constants || exit
touch durations.dart
touch urls.dart
touch strings.dart
cd ..

mkdir styles
cd styles || exit
touch colors.dart
touch themes.dart
touch text_styles.dart
cd ..

touch core_imports.dart

cd ..

mkdir features

mkdir routes
cd routes || exit
touch routes.dart

cd ..

touch injection_container.dart
touch app.dart
touch main.dart
