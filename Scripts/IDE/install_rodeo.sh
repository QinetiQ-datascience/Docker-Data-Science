    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 33D40BC6
    add-apt-repository -u "deb http://rodeo-deb.yhat.com/ rodeo main"
    apt-get update && apt-get --yes install rodeo 