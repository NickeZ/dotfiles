# Fish config
setenv ANDROID_SDK /home/niklas/android/android-sdk-linux
setenv ANDROID_NDK /home/niklas/android/android-ndk-r10e
setenv PATH $PATH $ANDROID_SDK/tools $ANDROID_SDK/platform-tools $ANDROID_NDK

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_showcolorhints 'yes'

set __fish_git_prompt_color_branch 'yellow'

function fish_prompt  -d "Write out the prompt"
  set last_status $status

  printf '%s%s%s @ %s%s%s : %s%s%s%s\n' (set_color red) (whoami) (set_color blue) (set_color magenta) (hostname|cut -d . -f 1) (set_color blue) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (__fish_git_prompt)
  set_color normal

  printf '$ '
end

#function fish_right_prompt -d "Write out the right prompt"
#  date "+[%H:%M] %m/%d/%y"
#end

# Base16 Shell
eval sh $HOME/git/dotfiles/vendor/base16-shell/scripts/base16-solarized-dark.sh
