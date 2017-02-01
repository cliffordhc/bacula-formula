{% from "ge_bacula/params.jinja" import params with context -%}

bacula-fd:
  pkg.installed:
    - pkgs: {{ params.client_pkgs|json }}

bacula-fd-config:
  file.managed:
    - name: /etc/bacula/bacula-fd.conf
    - source: salt://ge_bacula/files/bacula-fd.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      client_name: {{ salt['pillar.get']("ge_bacula:client:name", grains['localhost']) }}
      working_directory: {{ salt['pillar.get']("ge_bacula:client:working_directory", "/var/lib/bacula") }}
      max_concurrent: {{ salt['pillar.get']("ge_bacula:client:concurrent", "20") }}
      director_name: {{ salt['pillar.get']("ge_bacula:client:director", "MyDirector") }}
      password: {{ salt['pillar.get']("ge_bacula:client:password") }}
      monitor_password: {{ salt['pillar.get']("ge_bacula:client:monitor_password", False) }}
      encryption: {{ params.encryption }}
    - watch_in:
      - service: bacula-fd

{% if params.encryption %}
bacula-fd-key-pair:
  file.managed:
    - name: /etc/bacula/keypair.pem
    - contents_pillar: ge_bacula:keypair
    - user: root
    - group: root
    - mode: 600

bacula-fd-master-key:
  file.managed:
    - name: /etc/bacula/master.cert
    - contents_pillar: ge_bacula:master_cert
    - user: root
    - group: root
    - mode: 600
{% endif %}