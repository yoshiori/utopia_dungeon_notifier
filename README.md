# UtopiaDungeonNotifier

SummonsBoard's utopia schedule notifier

## Usage
### For im.kayac.com ###
```
> bundle exec bin/utopia_dungeon_notifier check ${uid} ${imKayac_UserName} ${imKayac_SecretKey}
```
or
```
> bundle exec bin/utopia_dungeon_notifier schedule ${uid} ${imKayac_UserName} ${imKayac_SecretKey}
```

### For Pushover ###
```
> bundle exec bin/utopia_dungeon_notifier checkpo ${uid} ${user_token} ${app_token}
```
or
```
> bundle exec bin/utopia_dungeon_notifier schedulepo ${uid} ${user_token} ${app_token}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
