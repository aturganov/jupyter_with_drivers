FROM jupyter/datascience-notebook

#ENV http_proxy msc01-cfw01.pgk.rzd:9090
#ENV https_proxy msc01-cfw01.pgk.rzd:9090
USER root
RUN apt-get update

WORKDIR /opt
ADD /driver/oracle-instantclient19.8-basic_19.8.0.0.0-2_amd64.deb  /opt
RUN apt-get install libaio1 
RUN dpkg -i oracle-instantclient19.8-basic_19.8.0.0.0-2_amd64.deb

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN ACCEPT_EULA=Y apt-get install msodbcsql17
RUN ACCEPT_EULA=Y apt-get install mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
# RUN source ~/.bashrc
RUN apt-get install unixodbc-dev

WORKDIR /home/jovyan/work