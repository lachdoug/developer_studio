Engines Developer Studio
===

Developer Studio is used to create app blueprints, service blueprints and service templates/packages/some-other-term????


Deploy
---
- Rails 5 app
- MySQL2 database
- Persistent directories:
  - A data directory - pass path to ENV['EDS_PERSISTENT_DATA_DIRECTORY']
- Persistent files:
  - config/custom_dropdowns.yml
- Requires an SSH key in the .ssh directory. The public key must have filename 'identity.pub'.
- Rake: db:migrate, db:seed, assets:precompile
- Mail for devise password recovery ?????????

Sign in
---
Username: admin
Default password: password
