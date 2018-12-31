# Fedora workstation builder
This project is intended to help teams and individuals currently using a Fedora Project or derivative distribution of Linux to shorten the time it takes to go from _fresh install_ to _ready-to-rock-n-roll!_

Its intended to become flexible and modular by leveraging Ansible best practices, while remaining simple to clone and run to get immediate results. 

### Basic project structure

```
.
├── files
│   └── yum-repos
├── samples
│   └── tomsawyer.yml
├── tasks
│   └── fedora-main.yml
├── templates
│   ├── boto-config.j2
│   ├── gitconfig.j2
│   └── ssh-config.j2
└── vars
    ├── code-repo-lists.yml
    ├── ssh-tunneling.yml
    └── hosts
        └── hostname.yml
```

### Sample call
```bash
ansible-playbook local.yml --ask-become
```

----

### Repo Anatomy
#### Files
```
.
└── files
    └── yum-repos
```
This directoy should hold any `dnf` repositories that you would like to include on your system build. These are traditional _YUM/DNF_ repo files that will be copied _verbatim_ under `/etc/yum.repos.d`. Files placed here must have an `.repo` extension to be processed.

We've included a basic set of repositories in order to enable our sample configuration to be tested via Jenkins. Your mileage may vary.

----

#### Tasks
```
└── tasks
    └── fedora-main.yml
```
This is the _meat_ of the project. The main playbook that is directly invoked to run the builder.

----

#### Templates
```
└── templates
    ├── boto-config.j2
    ├── gitconfig.j2
    └── ssh-config.j2
```
Templates provide flexibility to customize configuration files.

* `gitconfig.j2` to provide out of the box command aliasing and _git_ customizations; can anyone survive without _git_ nowadays?
* `ssh-config.j2` to customize your _ssh configuration_, for instance, to create multiple custom-bastion/proxy sections

----

#### Var & Secret files
```
└── vars
    ├── code-repo-lists.yml
    ├── ssh-tunneling.yml
    └── vault
        └── secrets.yaml
```
_Var_ files can store anythig, ranging from simple key:value pairs to complex multi-level dictionary structures. Their common denominator is that we are not keeping any sensitive information here.

----

#### Blueprints
```
└── samples
    └── tomsawyer.
```
_Blueprint_ files provide the configuration details that you'll use. This is **your** configuration management repo. Here is a basic listing of the configuration keys it contains.

Configuration key|Description
-----------------|-----------
`sys_user`|this is the main system user we are building a profile and rolling out settings for; remember, this is a workstation!
`sys_user_email`|we can use this value to populate your email address where needed; i.e. your Git profile
`git_nickname`|self-explanatory
`default_identity_key_file`|While building your SSH configuration you can customize the default identity key that is used by `sys_user`
`dnf_extras`| Provide a YAML list of packages by name or RPM location that you would like to install; this can sometimes be useful if you run into dependencies that DNF cannot resolve on its own