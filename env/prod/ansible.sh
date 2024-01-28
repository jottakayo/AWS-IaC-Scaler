#! /bin/bash
cd /home/ubuntu
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py
sudo python2 -m pip install ansible
tee -a playbook.yml › /dev/null ‹‹EOT
- hosts: localhost
  tasks:
    - name: Atualiza o sitema operacional
      become: yes
      apt:
        update_cache: yes
    - name: Atualiza bibliotecas
      become: yes
      apt:
        upgrade: yes 
    - name: Instalando o python3
    apt:
      pkg:
      - python3
    - name: verificando instalação do apache
      become: yes
      systemd:
        name: apache2
        state: started
        enabled: yes
    - name: Clonando repositorio Mundo Invertido
      become: yes
      git:
        repo:  https://github.com/denilsonbonatti/mundo-invertido.git
        dest: /opt/mundo-invertido
    - name: Remover o arquivo index.html existente
      become: yes
      file:
        path: /var/www/html/index.html
        state: absent
    - name: Copiar os arquivos da aplicação para a pasta padrão do apache
      become: yes
      copy:
        src: "/opt/mundo-invertido"
        dest: "/var/www/html/"
        remote_src: yes
    - name: Renomeia os conteudos para ser identificados pelo apache
      become: yes
      command: mv /var/www/html/mundo-invertido /var/www/html/index.html
EOT
ansible-playbook playbook.yml