server {

    server_name dev.bilderstuebchen.de;
    root        /var/www/picobello/web;

    error_log   /var/log/nginx/symfony/error.log;
    access_log  /var/log/nginx/symfony/access.log;

    rewrite     ^/(app|app_dev)\.php/?(.*)$ /$1 permanent;

    location / {
        index       app_dev.php;
        try_files   $uri @rewriteapp;
    }

    location @rewriteapp {
        rewrite     ^(.*)$ /app_dev.php/$1 last;
    }

    client_max_body_size 50M;

    location ~ ^/(app|app_dev|config)\.php(/|$) {
        fastcgi_pass            php;
        fastcgi_buffer_size     16k;
        fastcgi_buffers         4 16k;
        fastcgi_split_path_info ^(.+\.php)(/.*)$;
        include                 fastcgi_params;
        fastcgi_param           SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param           HTTPS           off;
    }
}
