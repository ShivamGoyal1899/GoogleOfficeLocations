
# #CodeWithFlutter — Google Maps Integration

## Introduction

Flutter is Google’s mobile app SDK for crafting high-quality native experiences on iOS and Android in record time.

With the [Google Maps Flutter plugin](https://pub.dartlang.org/packages/google_maps_flutter), you can add maps based on Google maps data to your application. The plugin automatically handles access to the Google Maps servers, map display, and response to user gestures such as clicks and drags. You can also add markers to your map. These objects provide additional information for map locations, and allow the user to interact with the map.

![](https://cdn-images-1.medium.com/max/3000/1*BCBtnHQNa6d-HEvSsiNeVg.png)

### What you’ll build?

In this tutorial, you’ll build a mobile app featuring a Google Map using the Flutter SDK. Your app will:

* Display a Google Map

* Retrieve map data from a web service

* Display this data as markers on the Map

### What is Flutter?

* **Fast to develop:** Build your Android and iOS applications in milliseconds with Stateful Hot Reload.

* **Expressive and flexible:** Quickly ship features with a focus on native end-user experiences.

* **Native performance on both iOS and Android:** Flutter’s widgets incorporate all critical platform differences — such as scrolling, navigation, icons, and fonts — to provide full native performance.

Google Maps has:

* **99% coverage of the world:** Build with reliable, comprehensive data for over 200 countries and territories.

* **25 million updates daily:** Count on accurate, real-time location information.

* **1 billion monthly active users:** Scale confidently, backed by Google Maps’ infrastructure.

This tutorial walks you through creating a Google Maps experience in a Flutter app for both iOS and Android.

### What you’ll learn?

* How to create a new Flutter application.

* How to configure a Google Maps Flutter plugin.

* How to add Markers to a map, using location data from a web service.

This tutorial focuses on adding a Google map to a Flutter app. Non-relevant concepts and code blocks are glossed over and are provided for you to simply copy and paste.

## Set up your Flutter environment

The complete onboarding guide for flutter is [HERE](https://medium.com/enappd/codewithflutter-onboarding-1fd1dde453ba).

You can run this tutorial using any of the following devices:

* A physical device (Android or iOS) connected to your computer and set to developer mode.

* The iOS simulator. (Requires installing Xcode tools.)

* The Android emulator. (Requires setup in Android Studio.)

![](https://cdn-images-1.medium.com/max/3200/1*AwjFcy1vo9i6pkIEluw5kA.png)

## Getting started

### Getting started with Flutter

The easiest way to get started with Flutter is to use the flutter command line tool to create all the required code for a simple getting started experience.

    $ flutter create google_maps_in_flutter
    Creating project google_maps_in_flutter...
    [Listing of created files elided]
    Running "flutter packages get" in google_maps_in_flutter...     6.1s
    Wrote 66 files.
    
    All done!
    [✓] Flutter (Channel dev, v1.5.0, on Mac OS X 10.14.3 18D109, locale en-AU)
    [✓] Android toolchain - develop for Android devices (Android SDK version 28.0.3)
    [✓] iOS toolchain - develop for iOS devices (Xcode 10.2)
    [✓] Android Studio is fully installed. (version 3.1)
    [✓] IntelliJ IDEA Community Edition (version 2018.3.5)
    [✓] VS Code (version 1.33.1)
    [✓] Connected device is fully installed. (1 available)
    
    In order to run your application, type:
    
      $ cd google_maps_in_flutter
      $ flutter run
    
    Your application code is in google_maps_in_flutter/lib/main.dart.

### Adding Google Maps Flutter plugin as a dependency

Adding additional capability to a Flutter app is easy using [Pub packages](https://pub.dartlang.org/flutter). In this tutorial, you introduce the [Google Maps Flutter plugin](https://pub.dartlang.org/packages/google_maps_flutter) by adding a single line to the pubspec.yaml file.

<script src="https://gist.github.com/ShivamGoyal1899/a66de211866441c5e64ba31ab49320be.js"></script>

Download the package with the following command::

    $ flutter packages get
    Running "flutter packages get" in google_maps_in_flutter...    0.9s

## Adding Google Maps to the app

### It’s all about the API keys

To use Google Maps in your Flutter app, you need to configure an API project with the [Google Maps Platform](https://cloud.google.com/maps-platform/), following both the [Maps SDK for Android’s Get API key](https://developers.google.com/maps/documentation/android-sdk/signup), and [Maps SDK for iOS’ Get API key](https://developers.google.com/maps/documentation/ios-sdk/get-api-key) processes. With API keys in hand, carry out the following steps to configure both Android and iOS applications.

### Adding an API key for an Android app

To add an API key to the Android app, edit the AndroidManifest.xml file in android/app/src/main. Add a single meta-data entry containing the API key created in the previous step.

<script src="https://gist.github.com/ShivamGoyal1899/ca8d6f46530b25f318236cac11eb0353.js"></script>

### Adding an API key for an iOS app

To add an API key to the iOS app, edit the AppDelegate.m file in ios/Runner. Unlike Android, adding an API key on iOS requires changes to the source code of the Runner app. The AppDelegate is the core singleton that is part of the app initialization process.

Make two changes to this file. First, add an #import statement to pull in the Google Maps headers, and then call the provideAPIKey() method of the GMSServices singleton. This API key enables Google Maps to correctly serve map tiles.

<script src="https://gist.github.com/ShivamGoyal1899/9f80ded4534ae68ae572462234e575aa.js"></script>

You also need to add a setting to ios/Runner/Info.plist. This entry forces Flutter on iOS into a single threaded mode, which is required for the platform view embedding to work. This technical restriction is being worked on and will be lifted before Google Maps moves out of Developer Preview.

<script src="https://gist.github.com/ShivamGoyal1899/263260058a41fed89d64bb4b89f6d8c3.js"></script>

### Putting a map on the screen

Now it’s time to get a map on the screen. Update lib/main.dart as follows:

<script src="https://gist.github.com/ShivamGoyal1899/88232c297037fc9564ab27f827c3a4bc.js"></script>

### Running the app

Run the Flutter app in either iOS or Android to see a single map view, centered on Portland. Feel free to modify the map center to represent your hometown, or somewhere that is important to you.

    $ flutter run

![](https://cdn-images-1.medium.com/max/1000/1*bDmcsldsYWkHawu2Sn7bjg.png)

## Upgrading to Google Maps SDK for iOS 3.0

### Using the latest version of Maps for iOS

When running the app in the previous step on iOS, you may have seen a warning on the console about the version of the Google Maps for iOS plugin was old. This is due to a minimum version mismatch: Flutter supports a minimum of iOS version 8, while the latest version of Google Maps SDK for iOS supports a minimum iOS version 9. The version that CocoaPods installed by default was the last version of Google Maps SDK for iOS that supports iOS version 8. In this step, you change the iOS Runner project to use the latest version of Google Maps SDK for iOS.
> Please note, this step only applies to iOS, and uses Xcode to make changes to the iOS target. If you are on Windows or Linux, then this step doesn’t apply to you. Please skip ahead to the next step.

### Set a declared platform for CocoaPods

Edit ios/Podfile to declare a minimum platform version.

<script src="https://gist.github.com/ShivamGoyal1899/2ac0dd3583e490a6a0a9cb7df950f021.js"></script>

### Update the CocoaPod dependency

Run CocoaPods to pull the up-to-date version of Google Maps SDK for iOS:

    $ (cd ios && pod update)
    Analyzing dependencies
    Fetching podspec for `Flutter` from `.symlinks/flutter/ios`
    Fetching podspec for `google_maps_flutter` from `.symlinks/plugins/google_maps_flutter/ios`
    Downloading dependencies
    Using Flutter (1.0.0)
    Installing GoogleMaps 3.0.3
    Using google_maps_flutter (0.0.1)
    Generating Pods project
    Integrating client project
    Pod installation complete! There are 2 dependencies from the Podfile and 3 total pods installed.

### Set the deployment target in Xcode

Configure the deployment target iOS version in the iOS Runner Xcode project so that the binary versions of the Runner and Google Maps match. Open the Runner project from the command line as follows.

    $ open ios/Runner.xcworkspace/

This opens up the Xcode workspace for the iOS Runner project. Configure the Deployment Target for Runner in the General preferences pane.

![](https://cdn-images-1.medium.com/max/3200/1*fP8DnUeRrPos_wESCDw-Wg.png)

### Running the app, again

Run the Flutter app in iOS, this time using the latest version of Google Maps SDK for iOS.

    $ flutter run
    Launching lib/main.dart on iPhone XR in debug mode...
    Running pod install...                                       1.2s
    Running Xcode build...
     ├─Assembling Flutter resources...                           1.3s
     └─Compiling, linking and signing...                         4.5s
    Xcode build done.                                            7.6s
    Google Maps SDK for iOS version: 3.0.33124.0
    Syncing files to device iPhone XR...                         1,267ms
    
    🔥  To hot reload changes while running, press "r". To hot restart (and rebuild state), press "R".

## Put Google on the Map

Google has many offices around the world, from [North America](https://about.google/locations/?region=north-america), [Latin America](https://about.google/locations/?region=latin-america), [Europe](https://about.google/locations/?region=europe), [Asia Pacific](https://about.google/locations/?region=asia-pacific), to [Africa & Middle East](https://about.google/locations/?region=africa-middle-east). The nice thing about these maps, if you investigate them, is that they have an easily usable [API endpoint](https://about.google/static/data/locations.json) for supplying the office location information in JSON format. In this step, you put these office locations on the map.

As you grow your codebase, it’s time to start using tooling that Dart provides to make the code more readable and maintainable. In this step, you use code generation to parse JSON, and code linting to surface potential [code smells](https://en.wikipedia.org/wiki/Code_smell).

To use these capabilities, add some new dependencies to the pubspec.yaml file. These dependencies provide access to http requests, the ability to mechanize JSON parsing, a configuration of useful lint rules used widely at Google, and a build runner that ties all of it together. Edit the dependencies stanza of your pubspec.yaml file as follows:

<script src="https://gist.github.com/ShivamGoyal1899/c1c606287ab6b08a5e460370e1f7bd9d.js"></script>

Run flutter packages get on the command line to retrieve these new dependencies, and to prepare the app for the next stages.

    $ flutter packages get 
    Running "flutter packages get" in google_maps_in_flutter...     0.5s

### Using the providing tooling

    $ flutter format .
    Formatting directory .:
    Formatted lib\main.dart
    Unchanged test\widget_test.dart

For linting, Dart provides the ability to [configure a customized code linter](https://www.dartlang.org/guides/language/analysis-options). In this step, you add a handful of linters to the app, but the full list of available lints is specified in the [Linter for Dart documentation](https://dart-lang.github.io/linter/lints/).

Add a file to the root of the project called analysis_options.yaml and fill it with the following content.

<script src="https://gist.github.com/ShivamGoyal1899/738d94c609516664171c316f86224768.js"></script>

The first line includes a default set of rules used widely at Google, and the linter rules section gives a taste of what is possible. The exclude line references a file that hasn't been generated yet. To run the lint rules, analyze the code as follows:

    $ flutter analyze
    Analyzing google_maps_in_flutter...
    No issues found! (ran in 1.8s)

If the analyzer issues warnings, don’t worry, you will fix them shortly.

### Parsing JSON with code generation

You might notice that the JSON data returned from the API endpoint has a regular structure. It would be handy to generate the code to marshal that data into objects that you can use in code. While Dart provides a variety of options for de-serializing JSON data (from build-it-yourself, to signing the data and using built_value), this step uses JSON annotations.

In the lib/src directory, create a locations.dart file and describe the structure of the returned JSON data as follows:

<script src="https://gist.github.com/ShivamGoyal1899/d679dbca70c31fbb3435d484be131166.js"></script>

Once you’ve added this code, your IDE (if you are using one) should display some red squiggles, as it references a nonexistent sibling file, locations.g.dart. This generated file converts between untyped JSON structures and named objects. Create it by running the build_runner:

    $ flutter packages pub run build_runner build
    [INFO] Generating build script...
    [INFO] Generating build script completed, took 291ms
    
    [INFO] Initializing inputs
    [INFO] Reading cached asset graph...
    [INFO] Reading cached asset graph completed, took 65ms
    
    [INFO] Checking for updates since last build...
    [INFO] Checking for updates since last build completed, took 595ms
    
    [INFO] Running build...
    [INFO] 1.2s elapsed, 0/1 actions completed.
    [INFO] Running build completed, took 1.2s
    
    [INFO] Caching finalized dependency graph...
    [INFO] Caching finalized dependency graph completed, took 27ms
    
    [INFO] Succeeded after 1.2s with 1 outputs (1 actions)

Your code should now analyze cleanly again.

Modify the main.dart file to request the map data, and then use the returned info to add offices to the map:

<script src="https://gist.github.com/ShivamGoyal1899/5fc8f8cb19dc8793df9db75ad3c7b9db.js"></script>

This code performs several operations:

* In _onMapCreated, it uses the JSON parsing code from the previous step, awaiting until it's loaded. It then uses the returned data to create Markers inside a setState() callback. Once the app receives new markers, setState flags Flutter to repaint the screen, causing the office locations to display.

* The markers are stored in a Map that is associated with the GoogleMap widget. This links the markers to the correct map. You could, of course, have multiple maps and display different markers in each.

![](https://cdn-images-1.medium.com/max/5024/1*MqWLDQjGVCZGPcT1SYd9uw.png)

Here’s a screenshot of what you have accomplished. There are many interesting additions that can be made at this point. For example, you could add a list view of the offices that moves and zooms the map when the user clicks an office but, as they say, this exercise is left to the reader!

## More Relevant Resources

* Hadrien Lejard’s google_maps_webservice package which makes the Google Maps Web Services, like [Directions API](https://developers.google.com/maps/documentation/directions/start), [Distance Matrix API](https://developers.google.com/maps/documentation/distance-matrix/start), and [Places API](https://cloud.google.com/maps-platform/places/) really easy to use.

* [Build Mobile Apps With Flutter and Google Maps](https://www.youtube.com/watch?v=RpQLFAFqMlw) (a talk given at Cloud Next ‘19)

* My GitHub Profile [@ShivamGoyal1899](https://github.com/ShivamGoyal1899)

## Congratulations!

You have completed this tutorial and have built a Flutter app with a Google Map! You’ve also interacted with a JSON Web Service.
