FROM stilliard/pure-ftpd:latest

ENV FTP_USER ftp-user
ENV FTP_PASS ftpuser
ENV FTP_HOME /home/ftp-user/ftp
ENV FTP_UID 1001
ENV FTP_GID 1001

RUN getent group ftpgroup || groupadd -g $FTP_GID ftpgroup

RUN mkdir -p $FTP_HOME && \
    useradd -u $(shuf -i 1000-2000 -n 1) -s /bin/false -d $FTP_HOME -c "FTP user" -g ftpgroup $FTP_USER && \
    echo $FTP_USER:$FTP_PASS | chpasswd && \
    chown $FTP_USER:$FTPGROUP $FTP_HOME && \
    echo "yes" > /etc/pure-ftpd/conf/UnixAuthentication && \
    echo "no" > /etc/pure-ftpd/conf/PAMAuthentication && \
    echo "no" > /etc/pure-ftpd/conf/ChrootEveryone && \
    echo "no" > /etc/pure-ftpd/conf/AnonymousOnly && \
    echo "no" > /etc/pure-ftpd/conf/NoAnonymous && \
    echo "yes" > /etc/pure-ftpd/conf/PureDB && \
    echo "$FTP_HOME" > /etc/pure-ftpd/conf/DefaultChdir && \
    echo "yes" > /etc/pure-ftpd/conf/DontResolve && \
    echo "no" > /etc/pure-ftpd/conf/VerboseLog && \
    echo "no" > /etc/pure-ftpd/conf/DisplayDotFiles && \
    echo "no" > /etc/pure-ftpd/conf/AnonymousCanCreateDirs && \
    echo "no" > /etc/pure-ftpd/conf/NoChmod && \
    echo "no" > /etc/pure-ftpd/conf/NoRename && \
    echo "no" > /etc/pure-ftpd/conf/NoRMD && \
    echo "no" > /etc/pure-ftpd/conf/NoMKD && \
    echo "no" > /etc/pure-ftpd/conf/AllowUserFXP && \
    echo "no" > /etc/pure-ftpd/conf/AllowAnonymousFXP
    
EXPOSE 21
