

# macOS config commands
```
# Remove new caps-lock indicator cursor
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist \
    redesigned_text_cursor -dict-add Enabled -bool NO
```

