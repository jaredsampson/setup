# setup
A macOS new machine setup script


# Goals
1. Nearly fully automated, and will wait for manual steps to be completed.
2. Can be run at any time repeatedly to restore configured settings without issue.


# What to do

## On a new Mac

Run this command to bootstrap the setup.

```
bash -c "$(curl -LsS https://raw.githubusercontent.com/jaredsampson/setup/main/setup.sh)"
```

The setup script will (eventually (hopefully)):

1. Install the Xcode command line tools.
2. Clone this repository into `~/.setup`.
3. Install dotfiles from `jaredsampson/dotfiles` to `~/.dotfiles`
4. Configure macOS.
5. more stuff


