<manifest xmlns:android="http://schemas.android.com/apk/res/android"
xmlns:tools="http://schemas.android.com/tools" package="com.genmak.mak_life_dairy_fresh">

    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.VIDEO_CAPTURE" />
    <uses-permission android:name="android.permission.AUDIO_CAPTURE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>

   <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
    <!-- <uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES" />   -->
    
    <application
        android:label="Mak Life Dairy Fresh"
        android:name="${applicationName}"
        android:icon="@mipmap/launcher_icon"
        android:usesCleartextTraffic="true"
            android:networkSecurityConfig="@xml/network_security_config">
        <meta-data android:name="io.flutter.network-policy"
             android:resource="@xml/network_security_config"/>
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize"
            
            >
            <!-- Specifies an Android theme to apply to this Activity as soon as
                 the Android process has started. This theme is visible to the user
                 while the Flutter UI initializes. After that, this theme continues
                 to determine the Window background behind the Flutter UI. -->
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- Don't delete the meta-data below.
             This is used by the Flutter tool to generate GeneratedPluginRegistrant.java -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
            <!-- Begin FlutterDownloader customization -->
<!-- disable default Initializer -->
<provider
    android:name="androidx.startup.InitializationProvider"
    android:authorities="${applicationId}.androidx-startup"
    android:exported="false"
    tools:node="merge">
    <meta-data
        android:name="androidx.work.WorkManagerInitializer"
        android:value="androidx.startup"
        tools:node="remove" />
</provider>

<!-- declare customized Initializer -->

<provider
    android:name="vn.hunghd.flutterdownloader.FlutterDownloaderInitializer"
    android:authorities="${applicationId}.flutter-downloader-init"
    android:exported="false">
<!-- changes this number to configure the maximum number of concurrent tasks -->
<meta-data
        android:name="vn.hunghd.flutterdownloader.MAX_CONCURRENT_TASKS"
        android:value="5" />
</provider>

<!-- End FlutterDownloader customization -->

<provider
    android:name="com.pichillilorenzo.flutter_inappwebview_android.InAppWebViewFileProvider"
    android:authorities="${applicationId}.flutter_inappwebview_android.fileprovider"
    android:exported="false"
    android:grantUriPermissions="true">
<meta-data
        android:name="android.support.FILE_PROVIDER_PATHS"
        android:resource="@xml/provider_paths" />
</provider>

    </application>
     <queries>
        <package android:name="com.google.android.apps.photos" />
        <package android:name="com.google.android.apps.docs" />
        <package android:name="com.google.android.documentsui" />
     </queries>

</manifest>
