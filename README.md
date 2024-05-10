My Ansible configuration for automating boring task. It is no where near perfect and was started as a learning project. I will continue to make improvement as my knowledge grows. 

## Ansible

Ansible is use to set up provission infrastracture on digital ocean and
configure all the neccessary components. properly

## Requirements

This project requires the following

- python 3.7 - 3.10.11

## Secret Management

Doppler is use to manage secret for this project.

It is HIGHLY recommended that before you run any of the commands against a live
host. That the command is tested with your local environment and dev secret.

## Installing Ansible

This project uses `pip`, but you can use a system wild installation as

- Using `pip install`

See this URL for more information
https://docs.ansible.com/ansible/7/installation_guide/intro_installation.html

Step into the `ansible` directory

```bash
cd ansible
```

Alternatively, you can set up `venv`

```bash
python3 -m venv ./.venv
```

Activate the virtual environment

```bash
source .venv/bin/activate
```

Then run, to install all dependency

```bash
pip3 install --no-cache-dir -r requirements.txt
```

### Installing Ansible Collection

To install ansible collection, run the following command

```bash
ansible-galaxy collection install -r requirements.yml
```

### Set up Doppler

create a `doppler.yaml` file in the ansible directory, with the following
contents:

```yaml
---
setup:
  project: ansible
  config: dev_<name>
```

`<name>` should be replaced with the name your team lead/admin has assigned to
you.

---

- Run the following command, to set up doppler

Login - scope the login to the ansible directory

```bash
doppler login
```

Setup doppler configuration - Follow the prompt after running this command

```bash
doppler setup
```

## Verify the doppler setup

```bash
doppler secrets get DOPPLER_ENVIRONMENT DOPPLER_PROJECT DOPPLER_CONFIG
```

You should get a table showing you `DOPPLER_ENVIRONMENT`, `DOPPLER_PROJECT` and
`DOPPLER_CONFIG`

## Verify Playbook

- Doppler can pass secrets to ansible

```bash
doppler run -- ansible-playbook setup-verification/doppler-palybook.v.yml
```

[>>> Click here for documentation](https://community.doppler.com/t/ansible-shell-command-modules-with-doppler/267/2)

---

- Lint

```bash
ansible-lint digital-ocean/01-create-droplet-playbook.yml
```

## Digital Ocean Playbook

- #### Test Host connection

Run the following command, to test that ansible can establish connection with
digital ocean host

```bash
ansible -i digital-ocean/inventory/do-setup-playbook/hosts.ini  -m ping all -K
```

The `-K` flag will prompt for the user `PASSWORD`

- ### Provision new Droplet

Ansible can be use to provision a new Droplet(server) on digital ocean.
[Click here for the list of slugs](https://slugs.do-api.dev/)

`s-2vcpu-4gb` is currently set as the default. This droplet will handle all
requirement need for node perfectly

```bash
doppler run ansible-playbook digital-ocean/01-create-droplet-playbook.yml
```

- #### Setup Digital ocean Droplet playbook

```bash
doppler run -- ansible-playbook digital-ocean/02-setup-server.yml -i digital-ocean/inventory/do-setup-playbook/hosts.ini
```

- #### Install all required packages on droplet

```bash
doppler run -- ansible-playbook digital-ocean/03-install-packages.yml -i digital-ocean/inventory/do-setup/hosts.ini
```

---

### Load Balancer

To set up `load balancer`, run the code below

```bash
doppler run -- ansible-playbook digital-ocean/05-nginx-config-playbook.yml --inventory digital-ocean/inventory/do-manage/api_gateway_host.ini --limit api_gateways
```

### Krakend

- Staging Environment

```bash
doppler run -- ansible-playbook digital-ocean/09-setup-krakend-playbook.yml --inventory digital-ocean/inventory/do-manage/staging_hosts.ini --limit application_server --extra-vars "mode=staging"
```

- Production

```
doppler run -- ansible-playbook digital-ocean/09-setup-krakend-playbook.yml --inventory digital-ocean/inventory/do-manage/hosts.ini --limit application_server --extra-vars "mode=production"
```

---

### Resources

- [Ansible Playbook command](https://docs.ansible.com/ansible/latest/cli/ansible-playbook.html)

- [Quick Guild to Inventory File](https://www.cherryservers.com/blog/how-to-set-up-ansible-inventory-file)

- [Initial Server Setup](https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-automate-initial-server-setup-on-ubuntu-18-04)

- [DigitalOcean Ansible Collection](https://github.com/ansible-collections/community.digitalocean)

- [Droplet Module](https://docs.ansible.com/ansible/latest/collections/community/digitalocean/digital_ocean_droplet_module.html)
