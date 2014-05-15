# Include :download:`map file <map.jinja>` of OS-specific package names and
# file paths. Values can be overridden using Pillar.
{% from "ntp/map.jinja" import ntp with context %}

ntp:
  pkg:
    - installed
    - name: {{ ntp.client }}

{% if salt['pillar.get']('ntp:ntp_conf') %}
ntp_conf:
  file:
    - managed
    - name: {{ ntp.ntp_conf }}
    - template: jinja
    - source: {{ salt['pillar.get']('ntp:ntp_conf', 'salt://ntp/ntp-client.conf') }}
    - require:
      - pkg: ntp
{% endif %}
