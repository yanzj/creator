import {
	checkNpmVersions
} from 'meteor/tmeasday:check-npm-versions';
checkNpmVersions({
	cookies: "^0.6.2",
	mkdirp: "^0.3.5",
}, 'steedos:app-workflow');