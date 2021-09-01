<p align="center">
    <a href="https://sylius.com" target="_blank">
        <img src="https://demo.sylius.com/assets/shop/img/logo.png" />
    </a>
</p>

<h1 align="center">Sylius Standard Edition</h1>

<p align="center">This is Sylius Standard Edition repository for starting new projects.</p>

Documentation
-------------

Documentation is available at [docs.sylius.com](http://docs.sylius.com).

Installation
------------

```bash
$ make up
$ open http://localhost:8080/
```

Rebuild service
------------

```bash
$ make rebuild
$ open http://localhost:8080/
```

Clean up database
------------

```bash
$ make db
$ open http://localhost:8080/
```

Reinstall shop
------------
Remove old db, run sylius:install and migrate up

```bash
$ make reinstall
```

Install sample data
------------

```bash
$ make sample
```

More commands check in makefile

Bug Tracking
------------

If you want to report a bug or suggest an idea, please use [GitHub issues](https://github.com/Sylius/Sylius/issues).

Community Support
-----------------

Have a question? Join our [Slack](https://slackinvite.me/to/sylius-devs) or post it on [StackOverflow](http://stackoverflow.com) tagged with "sylius". You can also join our [group on Facebook](https://www.facebook.com/groups/sylius/)!

MIT License
-----------

Sylius is completely free and released under the [MIT License](https://github.com/Sylius/Sylius/blob/master/LICENSE).

Authors
-------

Sylius was originally created by [Paweł Jędrzejewski](http://pjedrzejewski.com).
See the list of [contributors from our awesome community](https://github.com/Sylius/Sylius/contributors).
Makefile and docker author [malvor](https://github.com/malvor)
