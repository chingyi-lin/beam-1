# Beam
This is a public repositroy of Beam which presents most of the implementations of Beam.
Since the application contains confidential information of paid APIs for notification purpose, we keep it in a private repository.

For more information, please refer to our [project webpage](https://www.ischool.berkeley.edu/projects/2019/beam-reimagining-password-management).

## Prerequisites to build the app
1. Install Carthage
2. Run `carthage update` to build dependencies
3. Install Cocoapods `sudo gem install cocoapods`
4. Run `pop install`

## Prerequisites to deploy Firebase cloud function
1. Install firebase-tools `npm install -g firebase-tools`
2. `firebase login`
3. `firebase deploy --only functions`

## Demo Setup
### Turn on "Autofill" for Beam
1. Install Beam
2. Go to iPhone `Settings` > `Passwords & Accounts` > `AutoFill Passwords`
3. Check Beam as one of autofill credential provider
