import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: MainScreen(),
    title: "Ztube",
    debugShowCheckedModeBanner: false,
  ));
}

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

bool windowIsOpen = false;

final String version = "v2023.6";

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  // int agent_type = 0;
  late InAppWebViewController controller;
  String target_url = "https://.www.fyoutube.com";
  final List<String> user_agent = [
    '(Windows NT 10.0; Win64; x64) Chrome/112.0.0.0',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
    // 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
  ];
  bool adblocker_status = true;
  // controller =
  // String test = "";
  String javaScript = "alert(1);";
  String adblock = """
  const clear = (() => {
    const defined = v => v !== null && v !== undefined;
    const timeout = setInterval(() => {
        const ad = [...document.querySelectorAll('.ad-showing')][0];
        if (defined(ad)) {
            const video = document.querySelector('video');
            if (defined(video)) {
                video.currentTime = video.duration;
            }
        }
       
        
    }, 250);
    return function() {
      
        clearTimeout(timeout);
    }
})();
""";

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    // android_window.setHandler((name, data) => {print(name, );});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState;
    // setState(() {
    //   _appLifecycleState = state;
    // });
    // if (state == AppLifecycleState.resumed) {
    //   setState(() {
    //     user_agent = '';
    //   });
    //   // Do something when the app is resumed
    // }
    if (state == AppLifecycleState.paused) {
      setState(() {
        controller.evaluateJavascript(
            source: "document.querySelector('video').play()");
      });
    }
    // Don't call super.didChangeAppLifecycleState(state);
    // to remove the onPause() function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black.withOpacity(.4),
        child: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.white54),
                      )),
                      child: FlatButton.icon(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoPage())),
                          icon: FaIcon(
                            FontAwesomeIcons.infoCircle,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: Text("Info",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.white54),
                      )),
                      child: FlatButton.icon(
                          onPressed: () {
                            // setState(() {
                            //   target_url = "https://www.youtube.com";
                            // });
                            controller.loadUrl(
                              urlRequest: URLRequest(
                                  url: Uri.parse("https://www.youtube.com")),
                            );
                            // setState(() {
                            //   controller.setOptions(
                            //       options: InAppWebViewGroupOptions(
                            //           crossPlatform: InAppWebViewOptions(
                            //               userAgent: user_agent[1])));
                            // });

//                             controller.evaluateJavascript(source: """
//   if (document.visibilityState != 'visible')  {
//     document.querySelector('video').play();
//   }
// """);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.youtube,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: Text("YouTube",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.white54),
                      )),
                      child: FlatButton.icon(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NotReady())),
                          icon: FaIcon(
                            FontAwesomeIcons.spotify,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: Text("Spotify",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.white54),
                      )),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton.icon(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoPage())),
                                icon: Icon(
                                  Icons.block_sharp,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: Text("Ads Blocker",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25))),
                            Switch(
                                value: adblocker_status,
                                activeColor: Colors.greenAccent,
                                inactiveThumbColor: Colors.red,
                                inactiveTrackColor: Colors.redAccent,
                                onChanged: (status) {
                                  // print(status);

                                  if (!status) {
                                    setState(() {
                                      adblock = "";
                                      adblocker_status = status;
                                    });
                                  } else {
                                    setState(() {
                                      adblock = """
  const clear = (() => {
    const defined = v => v !== null && v !== undefined;
    const timeout = setInterval(() => {
        const ad = [...document.querySelectorAll('.ad-showing')][0];
        if (defined(ad)) {
            const video = document.querySelector('video');
            if (defined(video)) {
                video.currentTime = video.duration;
            }
        }
       
    }, 250);
    return function() {
      
        clearTimeout(timeout);
    }
})();
""";
                                      adblocker_status = status;
                                    });
                                  }
                                  controller.reload();
                                })
                          ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(width: 1.5, color: Colors.white54),
                      )),
                      child: FlatButton.icon(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoPage())),
                          icon: Icon(
                            Icons.upgrade_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                          label: Text("Update",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Text(
                      "Developed By WanZ\n" + version,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    )
                  ],
                ))),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Text(
          "ZTube",
          style: TextStyle(fontSize: 17),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () => controller.goBack(),
              icon: Icon(Icons.arrow_back_ios_new)),
          IconButton(
            onPressed: () => controller.reload(),
            icon: Icon(Icons.refresh_outlined),
          ),
          IconButton(
              onPressed: () => controller.goForward(),
              icon: Icon(Icons.arrow_forward_ios_outlined))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InAppWebView(
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(userAgent: user_agent[0]
                  // 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
                  // 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
                  // '(Windows NT 10.0; Win64; x64) Chrome/112.0.0.0'
                  // 'random'
                  ),
              android: AndroidInAppWebViewOptions(
                  thirdPartyCookiesEnabled: true,
                  needInitialFocus: false,
                  supportMultipleWindows: true,
                  useShouldInterceptRequest: true,
                  useOnRenderProcessGone: true,
                  useHybridComposition: true)),
          onWebViewCreated: (InAppWebViewController _controller) {
            controller = _controller;
          },
          initialUrlRequest: URLRequest(
            url: Uri.parse("https://music.youtube.com"),
          ),
          onLoadStart: (_, url) {
            _.evaluateJavascript(source: adblock);
          },
          onLoadError: (controller, url, code, message) => controller.reload(),
          // onLoadStop: (_, url) => _.evaluateJavascript(
          //     source:
          //         "while (true){document.querySelector('video').play();}")
        ),
      ),
    );
  }
}

class NotReady extends StatelessWidget {
  const NotReady({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Not Ready");
    ;
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              child: Image(
                  image: NetworkImage(
                      "https://wallpapers.com/images/hd/pixel-phone-2wsahoe1mtv0nqwp.jpg"),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover)),
          Positioned(
              top: 50,
              child: Text(
                textAlign: TextAlign.center,
                "ZTUBE \nIS ONLINE STREAMING APP \nPOWERED BY YT MUSICS, YOUTUBE AND SPOTIFY \nWITH EXTRA FEATURES LIKE \nOFF SCREEN PLAYBACK, BACKGROUND PLAYBACK, \nAND AD BLOCKER. \nDEVELOPED BY WANZ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
          Positioned(
              bottom: MediaQuery.of(context).size.height / 7,
              child: Text("Contact developer: ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          Positioned(
              bottom: 40,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => launch(
                              "https://www.instagram.com/wan.__________"),
                          child: FaIcon(FontAwesomeIcons.instagram,
                              color: Colors.white, size: 50)),
                      GestureDetector(
                          onTap: () => launch(
                              "https://www.youtube.com/c/MuhammadNajwan"),
                          child: FaIcon(FontAwesomeIcons.youtube,
                              color: Colors.white, size: 50)),
                      GestureDetector(
                          onTap: () =>
                              launch("https://www.tiktok.com/@wan._77"),
                          child: FaIcon(FontAwesomeIcons.tiktok,
                              color: Colors.white, size: 50)),
                      GestureDetector(
                          onTap: () => launch("https://www.github.com/wanZ772"),
                          child: FaIcon(FontAwesomeIcons.github,
                              color: Colors.white, size: 50)),
                      GestureDetector(
                          onTap: () =>
                              launch("https://www.twitter.com/wanZ772"),
                          child: FaIcon(FontAwesomeIcons.twitter,
                              color: Colors.white, size: 50)),
                    ],
                  ))),
          Positioned(
              bottom: 0,
              child: Text(
                version,
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
