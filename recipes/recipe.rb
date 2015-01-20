%w(git vim curl wget tmux screen zsh dstat nkf lsof).each do |pkg|
  package pkg do
    action :install
  end
end

