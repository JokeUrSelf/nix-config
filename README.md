# [nix-config](https://github.com/JokeUrSelf/nix-config)

The strategy behind the configuration:
1. back up previous configuration
2. generate new configuration
3. apply new configuration
4. build system
5. post-configure the system (optional)

```sh
cp .env.example .env
```
Specify the path to your `AppImage` files in the `.env` file.
When applying the configuration, they are going to be wrapped as packages automatically.