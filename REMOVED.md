# Removed

```yaml
    - name: Start .bashrc customisation
      lineinfile:
        path: ~richeney/.bashrc
        line: "## Start of user customisation via Ansible"

    - name: Set PS1
      lineinfile:
        path: ~richeney/.bashrc
        line: export PS1='\[\033[01;32m\]\w\[\033[01;33m\]$(__git_ps1 " (%s)") \[\033[01;37m\]\$ '
```
