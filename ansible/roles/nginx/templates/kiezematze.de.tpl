server {

    server_name dev.kiezematze.de;
    root        /var/www/kiezematze.de;

    error_log   /var/log/nginx/symfony/error.log;
    access_log  /var/log/nginx/symfony/access.log;

    index index.php;
    location = /favicon.ico {
            log_not_found off;
            access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    location / {
        # This is cool because no php is touched for static content.
        # include the "?$args" part so non-default permalinks doesn't break when using query string
        try_files $uri $uri/ /index.php?$args;
    }

    location ~ \.php$ {
        #NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
        include fastcgi_params;
        fastcgi_intercept_errors on;
        fastcgi_pass php;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
        expires max;
        log_not_found off;
    }
}
