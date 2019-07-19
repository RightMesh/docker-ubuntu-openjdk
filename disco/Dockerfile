FROM ubuntu:19.04
MAINTAINER RightMesh AG, https://github.com/RightMesh

# This docker image has as much of our build chain in it as possible to reduce
# the time for CI/CD runs on gitlab-runner.
# https://github.com/compscidr/gitlab-ci-android/blob/master/Dockerfile
# https://github.com/javiersantos/android-ci/blob/master/Dockerfile

# Note: that we will need to update this anytime the build-tools in AndroidSDK
# is updated
# You can find the SDK tools number here:
# https://developer.android.com/studio/index.html#command-tools
ENV VERSION_SDK_TOOLS "4333796"

ENV ANDROID_HOME "/sdk"
ENV PATH "$PATH:${ANDROID_HOME}/tools"
ENV DEBIAN_FRONTEND noninteractive

# All of the necessary packages required apparently. Might want to confirm
# which are actually needed.
RUN apt-get -qq update && \
  apt-get install -qqy --no-install-recommends \
    bzip2 \
    curl \
    git-core \
    html2text \
    openjdk-8-jdk \
    unzip \
    locales \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Not sure why this is done, must dig in more later.
RUN rm -f /etc/ssl/certs/java/cacerts; \
  /var/lib/dpkg/info/ca-certificates-java.postinst configure

# Download the Android SDK
RUN curl -s https://dl.google.com/android/repository/sdk-tools-linux-${VERSION_SDK_TOOLS}.zip > /sdk.zip && \
  unzip /sdk.zip -d /sdk && \
  rm -v /sdk.zip

# In order to use Android SDK you must accept the licenses. After accepting the
# license using the UI on a computer, these are the output strings that are
# generated, so we add them here. If the version bumps, we need to accept again
# locally, and then add the updated strings into here.
RUN mkdir -p $ANDROID_HOME/licenses/ \
  && echo "8933bad161af4178b1185d1a37fbf41ea5269c55\nd56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-license \
  && echo "84831b9409646a918e30573bab4c9c91346d8abd\n504667f4c0de7af1a06de9f4b1727b84351f2910" > $ANDROID_HOME/licenses/android-sdk-preview-license

# Add the list of packages into the sdk folder and then have the sdk sdkmanager
# obtain the packages
ADD packages.txt /sdk
RUN mkdir -p /root/.android && \
  touch /root/.android/repositories.cfg && \
  ${ANDROID_HOME}/tools/bin/sdkmanager --update
RUN while read -r package; do PACKAGES="${PACKAGES}${package} "; done < /sdk/packages.txt && \
  ${ANDROID_HOME}/tools/bin/sdkmanager ${PACKAGES}

# I suppose this tells the sdkmanager to accept the licenses we have provided,
# but not really sure
RUN yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses
