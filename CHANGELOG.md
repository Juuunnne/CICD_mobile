# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [1.2.0](https://github.com/Juuunnne/CICD_mobile/compare/v1.1.0...v1.2.0) (2025-06-12)


### Features

* add rollback system for releases ([0133802](https://github.com/Juuunnne/CICD_mobile/commit/013380298536c2b01fb53163d04c81755abc3286))


### Bug Fixes

* **ci:** remove invalid hyphen in reusable workflow expression ([2ae2c5e](https://github.com/Juuunnne/CICD_mobile/commit/2ae2c5ed51c0acd03f1cda0da9938569b48f8bc7))
* **ci:** resolve invalid self-reference in reusable workflow ([8d071f7](https://github.com/Juuunnne/CICD_mobile/commit/8d071f783d0c6c29a64163778ab5e07d9a3b4c64))


### Code Refactoring

* **ci:** split backend tests into separate workflow ([cc7eb45](https://github.com/Juuunnne/CICD_mobile/commit/cc7eb45cf65bd73ebf45bdfb1270976f560c8e65))


### CI/CD

* align main pipeline to build only on master ([7bb4b5e](https://github.com/Juuunnne/CICD_mobile/commit/7bb4b5e7db8e9661e52d338fb2619eb97abaf33a))
* refactor workflows to use reusable components ([ff8d549](https://github.com/Juuunnne/CICD_mobile/commit/ff8d549d2064a3d6b6e86f0045b15b1bb1f263a7))


### Documentation

* minor change ([ab4277e](https://github.com/Juuunnne/CICD_mobile/commit/ab4277e39cfdeaadb52fe9f82b868a8d763e0e3d))
* update git strategy with build triggers ([ffa6445](https://github.com/Juuunnne/CICD_mobile/commit/ffa6445d64a39b73d2723c052d3094f6848a09f9))

## 1.1.0 (2025-06-12)


### Features

* add mobile to-do app and integrate with ci ([7813b7e](https://github.com/Juuunnne/CICD_mobile/commit/7813b7e46933fdcb30178969f347697c7a1032b3))
* **backend:** add lowdb database and CRUD API for todos with tests ([6955fd0](https://github.com/Juuunnne/CICD_mobile/commit/6955fd06e0fe75134eb9c2fc2bfdea71568e2774))
* initial release ([a5b0610](https://github.com/Juuunnne/CICD_mobile/commit/a5b0610b2da47d75e73492df9d90ba8c67bb5598))


### Bug Fixes

* **backend:** switch to lowdb v1 for ESM compatibility and update routes/tests ([ba74a79](https://github.com/Juuunnne/CICD_mobile/commit/ba74a7987c6e82001451b0c88d17e00acc7a0de3))
* correct build script and ignore backend db ([ad33443](https://github.com/Juuunnne/CICD_mobile/commit/ad33443bd53554ba7b17bcbc0f6a9377c38d2b86))
* **tests:** update root API test to use backend entry ([50a4c06](https://github.com/Juuunnne/CICD_mobile/commit/50a4c06f7e0af13f9f9c3040d4e452ec533bf974))


### Documentation

* add GIT_STRATEGY with branch and commit guidelines ([2f45983](https://github.com/Juuunnne/CICD_mobile/commit/2f45983b83a7287d7e02bd7e5550f8efd3830c79))


### CI/CD

* **backend:** rename test job to backend-test and run on develop branches ([62982b7](https://github.com/Juuunnne/CICD_mobile/commit/62982b72cf2d7c9ff2d7c9b516716931a110e395))
* **mobile:** add SDK build job triggered by [build-mobile] commit tag ([1bf8219](https://github.com/Juuunnne/CICD_mobile/commit/1bf82192b1ad2d75fd22a0f6ab18ac8dc66f8140))
* **mobile:** add workflow for Expo mobile lint and tests ([e895f1e](https://github.com/Juuunnne/CICD_mobile/commit/e895f1e079d6ebb6d0f372167f81d123328ccbe0))
* **mobile:** add workflow for Expo mobile lint and tests ([b6b1aba](https://github.com/Juuunnne/CICD_mobile/commit/b6b1aba6089006fded2a7723096f9ebe14ada48a))
* **mobile:** fix SDK build - use npx expo and add android.package [build-mobile] ([1601942](https://github.com/Juuunnne/CICD_mobile/commit/16019424c04e4be0d6d5ee87f48e4cdcb5d14249))


### Code Refactoring

* use npm test in ci and remove unused db.json ([e2122c0](https://github.com/Juuunnne/CICD_mobile/commit/e2122c028ac5b36159f9367f3f89f39814719782))

# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.
