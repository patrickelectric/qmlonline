#include <string>
#include <QtGlobal>

struct Version {
    const std::string hash = GIT_VERSION;
    const std::string date = GIT_VERSION_DATE;
    const std::string url = GIT_URL;
    const std::string qtVersion = qVersion();
};
