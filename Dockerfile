FROM ros:noetic

ARG USERNAME=admin
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ARG ROS_WS=/imu_ws

WORKDIR $ROS_WS

COPY src ${ROS_WS}/src

# setup non-root user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# install python3-pip
RUN apt-get install -y python3-pip \
    && pip3 install setuptools==58.2.0

# other utilities tools
RUN apt-get install -y vim

RUN echo "source ${ROS_WS}/devel/setup.bash" >> /home/$USERNAME/.bashrc

USER $USERNAME
