FROM jupyter/datascience-notebook

USER root
RUN apt-get update && apt-get install -y gnupg2

WORKDIR /opt
ADD /driver/oracle-instantclient19.8-basic_19.8.0.0.0-2_amd64.deb  /opt
RUN apt-get install libaio1 
RUN dpkg -i oracle-instantclient19.8-basic_19.8.0.0.0-2_amd64.deb

RUN sudo su
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
# update registry again
RUN apt-get update
# to close question Do you want to continue [Y/n]?  -> echo "y"
RUN echo "y" | ACCEPT_EULA=Y apt-get install msodbcsql17
RUN ACCEPT_EULA=Y apt-get install mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
# RUN source ~/.bashrc
RUN apt-get install -y unixodbc-dev

WORKDIR /home/jovyan/work