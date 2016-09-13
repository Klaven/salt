avahi:
  pkg.installed:
    - name: avahi
  file.replace:
    - name: /etc/avahi/avahi-daemon.conf
    - pattern: "#domain-name=local"
    - repl: "domain-name={{ pillar['domain'] }}"
  service.running:
    - name: avahi-daemon
    - require:
      - pkg: avahi
      - file: avahi
    - watch:
      - file: /etc/avahi/avahi-daemon.conf
