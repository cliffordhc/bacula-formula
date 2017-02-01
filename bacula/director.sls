{% from "ge_bacula/params.jinja" import params with context -%}

bacula-director:
  pkg.installed:
    - pkgs: {{ (params.common_pkgs + params.director_pkgs)|json }}
  service.running:
    - enable: True

bacula-director-config:
  file.managed:
    - name: /etc/bacula/bacula-dir.conf
    - source: salt://ge_bacula/files/bacula-dir.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      director_name: {{ salt['pillar.get']("ge_bacula:director:name", "MyDirector") }}
      working_directory: {{ salt['pillar.get']("ge_bacula:director:working_directory", "/var/lib/bacula") }}
      password: {{ salt['pillar.get']("ge_bacula:director:password") }}
      catalog: {{ salt['pillar.get']("ge_bacula:director:catalog", "MyCatalog") }}
      dbuser: {{ salt['pillar.get']("ge_bacula:director:dbuser") }}
      dbpassword: {{ salt['pillar.get']("ge_bacula:director:dbpassword") }}
      dbhost: {{ salt['pillar.get']("ge_bacula:director:dbhost", "localhost") }}
      dbname: {{ salt['pillar.get']("ge_bacula:director:dbname") }}
      max_concurrent: {{ salt['pillar.get']("ge_bacula:director:concurrent", "20") }}
      monitor_password: {{ salt['pillar.get']("ge_bacula:director:monitor_password", False) }} 
    - watch_in:
      - service: bacula-director

bacula-director-pools-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-pools.conf
    - source: salt://ge_bacula/files/bacula-dir-pools.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      pools: {{ salt['pillar.get']("ge_bacula:director:pools", {}) }}
    - watch_in:
      - service: bacula-director

bacula-director-schedules-defaults-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-schedules-defaults.conf
    - source: salt://ge_bacula/files/bacula-dir-schedules-defaults.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      daily_one: {{ salt['pillar.get']("ge_bacula:director:schedule_daily_one", "12:00am") }}
      daily_two: {{ salt['pillar.get']("ge_bacula:director:schedule_daily_two", "1:00am") }}
      daily_three: {{ salt['pillar.get']("ge_bacula:director:schedule_daily_three", "2:00am") }}
      catalog: {{ salt['pillar.get']("ge_bacula:director:schedule_daily_catalog", "3:00am") }}
    - watch_in:
      - service: bacula-director

bacula-director-schedules-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-schedules.conf
    - source: salt://ge_bacula/files/bacula-dir-schedules.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      schedules: {{ salt['pillar.get']("ge_bacula:director:schedules", {}) }}
    - watch_in:
      - service: bacula-director

bacula-director-clients-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-clients.conf
    - source: salt://ge_bacula/files/bacula-dir-clients.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      clients: {{ salt['pillar.get']("ge_bacula:director:clients", {}) }}
      catalog: {{ salt['pillar.get']("ge_bacula:director:catalog", "MyCatalog") }}
    - watch_in:
      - service: bacula-director

bacula-director-jobdefs-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-jobdefs.conf
    - source: salt://ge_bacula/files/bacula-dir-jobdefs.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      jobdefs: {{ salt['pillar.get']("ge_bacula:director:jobdefs", {}) }}
    - watch_in:
      - service: bacula-director

bacula-director-jobs-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-jobs.conf
    - source: salt://ge_bacula/files/bacula-dir-jobs.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      jobs: {{ salt['pillar.get']("ge_bacula:director:jobs", {}) }}
    - watch_in:
      - service: bacula-director

bacula-director-filesets-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-filesets.conf
    - source: salt://ge_bacula/files/bacula-dir-filesets.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      filesets: {{ salt['pillar.get']("ge_bacula:director:filesets", {}) }}
    - watch_in:
      - service: bacula-director

bacula-director-storage-config:
  file.managed:
    - name: /etc/bacula/bacula-dir-storage.conf
    - source: salt://ge_bacula/files/bacula-dir-storage.conf
    - template: jinja
    - user: root
    - group: root
    - defaults:
      storage: {{ salt['pillar.get']("ge_bacula:director:storage", {}) }}
    - watch_in:
      - service: bacula-director