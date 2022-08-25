<p>

  <a href="http://www.apache.org/licenses/LICENSE-2.0">
   <img src="https://img.shields.io/badge/license-Apache%202-blue.svg">  
  </a>

  <a href="https://docs.osgi.org/specification/#release-8">
   <img src="https://img.shields.io/badge/OSGi-R8-orange?style=flat">
  </a>

  <a href="https://gitter.im/AdeptJ/adeptj-runtime?utm_source=badge&amp;utm_medium=badge&amp;utm_campaign=pr-badge&amp;utm_content=badge">
    <img src="https://camo.githubusercontent.com/64af58db769a4ad81ae61fac30422b835f495326/68747470733a2f2f6261646765732e6769747465722e696d2f41646570744a2f61646570746a2d72756e74696d652e737667" alt="Join the chat at https://gitter.im/AdeptJ/adeptj-runtime" data-canonical-src="https://badges.gitter.im/AdeptJ/adeptj-runtime.svg" style="max-width:100%;">
  </a>

  <a href="https://twitter.com/_AdeptJ">
     <img src="https://img.shields.io/badge/twitter-AdeptJ-f08d1c.svg?style=social&style=flat"> 
  </a>

</p>

**Launcher for AdeptJ Runtime**

**Minimal runnable jar is ~30MB in size with below mentioned modules, starts in ~3000ms and low on resources**

**Steps to build and run:**

1. Make sure you have JDK 11+ and Apache Maven 3.6.x+ installed.
2. Clone [adeptj-parent](https://github.com/AdeptJ/adeptj-parent) and run **mvn clean install** to have the current parent version in local .m2
3. Since adeptj-runtime needs adeptj-modules therefore clone [adeptj-modules](https://github.com/AdeptJ/adeptj-modules) and build it locally by running **mvn clean install** in adeptj-modules base directory.
4. clone [adeptj-runtime](https://github.com/AdeptJ/adeptj-runtime) and run **mvn clean install**.
5. Now come to adeptj-runtime-launcher base directory and execute any of the maven profile script according to your requirements, e.g. ./build/minimal.sh
6. Above step will create AdeptJ Runtime Launcher Uber jar with the /lib directory on the classpath.
7. Now from adeptj-runtime-launcher directory itself execute this command ./bin/start.sh
8. Start script will work on JDK 11 and so on.
9. Go to [AdeptJ OSGi WebConsole](http://localhost:8080/system/console) to configure the services.
10. System will ask for username/password, provide the default ones [admin/admin]
11. For examples on how to consume the modules please look into [adeptj-modules-examples](https://github.com/AdeptJ/adeptj-modules-examples)

**Debug options:**

Start AdeptJ Runtime with jpda option to run it in debug mode(port 8000) i.e ./bin/start.sh jpda

Start Parameters and VM arguments, most of these provided in start script.

1. For specifying port: -Dadeptj.rt.port=8080
2. Enable HTTP2: -Denable.http2=true
3. Enable Async Logging: -Dasync.logging=true
4. Felix Logging Level: -Dfelix.log.level=3
5. For providing server mode: -Dadeptj.rt.mode=PROD or DEV, PROD is default
6. Command line argument for launching browser when server starts: launchBrowser=true

**LICENSE**

Copyright 2016, AdeptJ (http://www.adeptj.com)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.



