##use

      //For win, empty or creat dir $VIM/vimfiles first
      cd $VIM
      git clone https://github.com/shepherdwind/vim.git vimfiles
      cd vimfiles

      //For *nix, empty or create dir $HOME/.vim/ first
      cd
      git clone https://github.com/shepherdwind/vim.git .vim
      cd .vim

      //vim
      :BundleInstall
      cd bundle/Command-T/
      make install


##配置

vim配置文件，插件使用pathogen.vim来控制，配置文件需要导入config.vim，
*uix修改

      "$HOME/.vimrc
      source $HOME/.vim/config.vim

win下

      "$VIM/_vimrc
      source $VIMFILES/config.vim


###外部依赖

- path路径下[ack](http://betterthangrep.com/)命令,
  ack.vim如果没有无法支持:ack搜索

##修改记录

- 2013-03-26 重新使用vundle管理插件
- 2011-12-24增加win和linux跨平台支持，去除bundle中插
  件的git库全部手动升级。
- 2012-05-30增加永久恢复，增加tagbar插件，增加jsctags依赖
- 2012-10-31删除taglist, winmanage, bufexploder等插件，开始使用<leader>b浏览
  buffer里的文件。大概什么时候，minibuffer也可以删除了。minibuffer容易导致session
  失效。
