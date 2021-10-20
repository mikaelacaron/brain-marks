# Contribution Guidelines
This document contains the rules and guidelines that developers are expected to follow, while contributing to this repository.

> All contributions must **NOT** add any SwiftLint warnings or errors. There is a GitHub action setup for any PRs to dev, and Xcode will show any warnings/errors.

# About the Project
This app has always been open source! It began with the [Big Brain Hackathon](https://bigbrainhacks.com) and now during [Hacktoberfest](https://hacktoberfest.digitalocean.com). This app uses the [Twitter API](https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api) (v2 where possible) and [AWS Amplify DataStore](https://docs.amplify.aws/start/q/integration/ios/).

# Project Status
This is a deployed app on the Apple [App Store](https://apps.apple.com/us/app/brain-marks/id1577423925), available for iOS 14.0 or later. After Hacktoberfest, a new version will be created and pushed to the App Store by Mikaela Caron (the maintainer).

# Getting Started
## Prerequisites
* You will need an API key from the [Twitter API](https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api)
* If your feature/change requires changing the model you will need install [AWS Amplify DataStore](https://docs.amplify.aws/start/q/integration/ios/) tools
* Install [SwiftLint](https://github.com/realm/SwiftLint)
   * This is not a requirement, but is preferred.


## Start Here
* Fork the repo to your profile
* Clone to your computer

`git clone https://github.com/mikaelacaron/brain-marks && cd brain-marks`

* Setup the upstream remote

`git remote add upstream https://github.com/mikaelacaron/brain-marks.git`

* Checkout a new branch (from the `dev` branch) to work on an issue:

`git checkout -b issueNumber-feature-name`

* When your feature/fix is complete open a pull request, PR, from your feature branch to the `dev` branch
  * Be sure to squash your commits into one single commit, how to do that shown [here]([here](https://www.internalpointers.com/post/squash-commits-into-one-git))

* More information for beginners not familiar with git can be found [here](https://hacktoberfest.digitalocean.com/resources).

## Setting Up Secrets
* Once you have your API key, create a new file called `Secrets.swift` in the brain-marks directory of the project, use Xcode to do this
* Use the file `Secrets-Example.swift` as the format for your Secrets.swift file. Paste your API key into the `bearerToken` property
* Include the comment `// swiftlint:disable line_length` in this file otherwise it will trigger a SwiftLint warning

# Commit Messages

* The message following the `-m` flag must be in the below format : 
  > `<Verb in present tense> <Action>`
  
  ✅ **Examples of valid messages:**
  * Add serialisers.py for users app
  * Updated utils/validator.js file
  * Changed functionality of authentication process
  
  ❌ **Examples of invalid messages:**
  * Idk why this is not working
  * Only ui bug fixes left
  * All changes done, ready for production :))
  * Added better code
  
* Before opening a PR, make sure you squash all your commits into one single commit using `git rebase` (squash). Instead of having 50 commits that describe 1 feature implementation, there must be one commit that describes everything that has been done so far. You can read up about it [here](https://www.internalpointers.com/post/squash-commits-into-one-git).
> NOTE: While squashing your commits to write a new one, do not make use of `-m` flag. In this case, a vim editor window shall open. Write a title for the commit within 50-70 characters, leave a line and add an understandable description.

# Issues

* Issues **MUST** be opened any time any of the following events occur:
    * You encounter an issue such that a major (50 lines of code or above) portion of the code needs to be changed/added.
    * You want feature enhancements
    * You encounter bugs
    * Code refactoring is required
    * Test coverage should be increased
* **Open issues with the given template only:**
    * Feel free to label the issues appropriately
    * Do not remove the headings (questions in bold) while opening an issue with the given template. Simply append to it

# Branches and PRs

* No commits should be made to the `main` branch directly. The `main` branch shall only consist of the deployed code
* Developers are expected to work on feature branches, and upon successful development and testing, a PR (pull request) must be opened to merge with `dev`
* A branch must be named as either the feature being implemented, or the issue being fixed
* Use kebab-case for branch names

  ✅ **Examples of valid branch names:**
  * fix/8123-title-of-issue (issue number)
  * feature/8123 (issue number)
  
  ❌ **Examples of invalid branch names**:
  * username-testing
  * attemptToFixAuth
  * SomethingRandom

# Discussion Ethics

* Developers should be clear and concise while commenting on issues or PR reviews. If needed, provide visual reference or a code snippet to give more context
* Everyone should be respectful of everyone's opinion. Any harsh/disrespectful language is **STRICTLY** prohibited and will not be tolerated under any circumstances

# Coding Ethics

* Developers are highly encouraged to write the code clearly and keep it as self documenting as possible. Use comments wherever necessary
* The project structure should be neat and organized. All folders and files should be organized semantically according to their functionality
* The name of the folders and files should not be too long but should be as self explanatory as possible
*  Documentation shall **STRICTLY** have gender neutral terms. Instead of using "he/him" or "she/her", one should use "they/them" or "the user"

# Coding Style Guidelines

Developers should aim to write clean, maintainable, scalable and testable code. If your code is not testable, that means, it's time to refactor it. The following guidelines might come in handy for this:

* Swift: [Swift Best Practices](https://github.com/Lickability/swift-best-practices), by [Lickability](https://github.com/Lickability)