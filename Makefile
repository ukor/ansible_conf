create_droplet:
	doppler run -- ansible-playbook digital-ocean/01-create-droplet-playbook.yml

setup_droplet:
	doppler run -- ansible-playbook digital-ocean/02-setup-server.yml -i digital-ocean/inventory/do-setup/ppn.ini

install_package:
	doppler run -- ansible-playbook digital-ocean/03-install-packages.yml -i digital-ocean/inventory/do-manage/ppn.ini

install_nodejs:
	doppler run -- ansible-playbook digital-ocean/nodejs.playbook.yml -i digital-ocean/inventory/do-manage/ppn.ini

install_pm2:
	doppler run -- ansible-playbook digital-ocean/pm2.playbook.yml -i digital-ocean/inventory/do-manage/ppn.ini

setup_github_user:
	doppler run -- ansible-playbook digital-ocean/04-setup-ssh-playbook.yml -i digital-ocean/inventory/do-manage/ppn.ini

setup_nginx_reverse_proxy:
	doppler run -- ansible-playbook digital-ocean/05-nginx-reverse-proxy-config.playbook.yml -i digital-ocean/inventory/do-manage/ppn.ini


# sudo certbot certonly --webroot --webroot-path /var/www/html --domain subdomain.example.com --dry-run

