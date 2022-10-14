# Contribution Guidelines
This document contains the rules and guidelines that developers are expected to follow, while contributing to this repository.

> All contributions must **NOT** add any SwiftLint warnings or errors. There is a GitHub action setup for any PRs to dev, and Xcode will show any warnings/errors.

# About the Project
This app has always been open source! It began with the [Big Brain Hackathon](https://bigbrainhacks.com) and now during [Hacktoberfest](https://hacktoberfest.digitalocean.com). This app uses the [Twitter API](https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api) (v2 where possible) and [AWS Amplify DataStore](https://docs.amplify.aws/start/q/integration/ios/). AWS Amplify DataSore will soon be depreciated.

### Project Status
This is a deployed app on the [Apple App Store](https://apps.apple.com/us/app/brain-marks/id1577423925), available for iOS 14.0 or later. After Hacktoberfest, a new version will be created and pushed to the App Store by Mikaela Caron (the maintainer).

# Getting Started
## Prerequisites
* You will need an API key from the [Twitter API](https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api)
* If your feature/change requires changing the model you will need install [AWS Amplify DataStore](https://docs.amplify.aws/start/q/integration/ios/) tools - soon to be depreciated
* Install [SwiftLint](https://github.com/realm/SwiftLint) onto your machine via [Homebrew](https://brew.sh/)
   * This is not a requirement, but is preferred.


## Start Here
* Fork the repo to your profile
* Clone to your computer
* Setup the upstream remote

`git remote add upstream https://github.com/mikaelacaron/brain-marks.git`

* Setup the [Secrets.swift file](#setting-up-secrets)

* Checkout a new branch (from the `dev` branch) to work on an issue:

`git checkout -b issueNumber-feature-name`

* When your feature/fix is complete open a pull request, PR, from your feature branch to the `dev` branch
  * Be sure to squash your commits into one single commit, how to do that shown [here](https://www.internalpointers.com/post/squash-commits-into-one-git)

* More information for beginners not familiar with git can be found [here](https://hacktoberfest.com/participation/#beginner-resources).

## Setting Up Secrets
* Once you have your API key, 
* Open the Xcode project (the Secrets.swift file will be red)
* Open Terminal and navigate to the project directory
* cd into `brain-marks` ensure you are in the directory showing `Secrets-Example.swift` NOT the `.xcodeproj` file
* Create a new file called `Secrets.swift` in the brain-marks directory, by typing `touch Secrets.swift` in Terminal
* Copy the contents of `Secrets-Example.swift` as the format for your `Secrets.swift` file
* Paste your API key into the `bearerToken` property
* Include the comment `// swiftlint:disable line_length` in this file otherwise it will trigger a SwiftLint warning
* Build the project!

# Commit Messages

* The commit message must be in the below format : 
  > `<Verb in present tense> <Action>`
  
  ✅ **Examples of valid messages:**
  * Add NewView.swift for users app
  * Update DataStoreManger.swift file
  * Change functionality of authentication process

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
    * Do not remove the headings while opening an issue with the given template. Simply append to it

# Branches and PRs

* No commits should be made to the `main` branch directly. The `main` branch shall only consist of the deployed code
* Developers are expected to work on feature branches, and upon successful development and testing, a PR (pull request) must be opened to merge with `dev`
* A branch must be named as either the feature being implemented, or the issue being fixed
* Use kebab-case for branch names

  ✅ **Examples of valid branch names:**
  * 8123-fix-title-of-issue (issue number)
  * 8123-feature-name (issue number)
  
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

Developers should aim to write clean, maintainable, scalable and testable code. The following guidelines might come in handy for this:

* Swift: [Swift Best Practices](https://github.com/Lickability/swift-best-practices), by [Lickability](https://lickability.com)
