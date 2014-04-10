export PATH=/opt/local/bin:/opt/local/sbin:$PATH

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi
