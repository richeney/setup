# To Add

```bash
git config --global user.name "Richard Cheney"
git config --global user.mail "richeney@microsoft.com"
git config --global credential.help store
git config --global credential.user richeney

or

# If you have Git in Windows
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-manager.exe"
```


```yaml
    - name: Install other cloud CLIs
      apt:
        name: "{{ packages }}"
        state: present
        update_cache: yes
      vars:
        packages:
          - awscli
          - google-cloud-sdk
    - name: Set gcloud to use python3
      lineinfile:
        path: ~richeney/.bashrc
        line: export CLOUDSDK_PYTHON=python3
```