[link to this repo](https://github.com/JokeUrSelf/nix-config)

Add `AppImage` files to `src/appimages`.
When applying the configuration, they'll automatically be added to your system

The strategy behind the configuration:
1. back up previous configuration
2. generate new configuration
3. apply new configuration
4. build system
5. Post-configure the system (optional)

```sh
cp .example.env .env
```
Don't forget to modify your env file, after copying