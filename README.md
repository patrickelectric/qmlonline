# 🌍 Qaterial Online

*This project is a hard fork [patrickelectric/qmlonline](https://github.com/patrickelectric/qmlonline).*

It makes [Qaterial](https://github.com/OlivierLDff/Qaterial) available. And is used for Qaterial documentation. It also demonstrate how to use CMake as a build system for Web Assembly.

## 🚀 Build and Deploy

To build this application i use a [Docker Image](https://hub.docker.com/r/reivilo1234/qt-webassembly-cmake).

```bash
git clone https://github.com/OlivierLDff/QaterialOnline
cd QaterialOnline
docker run -it --rm -v $(pwd):/src/ -u $(id -u):$(id -g) reivilo1234/qt-webassembly-cmake:qt5.15-em1.39.10 bash
mkdir build && cd build
cmake ..
make -j
exit
```

To test it in local, run a webserver in `build/deploy`:

```bash
# With python 3
python3 -m http.server
# With python 2
python -m SimpleHTTPServer
```

The page should be accessible from `localhost:8000` in any web brower.