FROM openjdk:8

MAINTAINER Thibaut Fabre <thibaut.fabre@opendigitaleducation.com>

# Install different package
RUN dpkg --add-architecture i386 \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install -y zip libncurses5:i386 libstdc++6:i386 zlib1g:i386 zipalign nodejs \
 && apt-get clean

# Set up environment variables
ENV ANDROID_HOME="/root/android-sdk-linux" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" 

WORKDIR /root

# Download Android SDK
RUN mkdir "$ANDROID_HOME" .android \
 && cd "$ANDROID_HOME" \
 && curl -o sdk.zip $SDK_URL \
 && unzip sdk.zip \
 && rm sdk.zip \
 && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

ENV PATH="${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools/25.0.3:${PATH}"
