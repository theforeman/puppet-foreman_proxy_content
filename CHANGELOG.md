# Changelog

## [7.3.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.3.0) (2018-10-18)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.2.0...7.3.0)

**Implemented enhancements:**

- Allow puppetlabs-stdlib 5.x [\#177](https://github.com/theforeman/puppet-foreman_proxy_content/pull/177) ([ekohl](https://github.com/ekohl))
- Fixes [\#12386](https://projects.theforeman.org/issues/12386) - Let qdrouterd listen on IPv6 [\#139](https://github.com/theforeman/puppet-foreman_proxy_content/pull/139) ([ekohl](https://github.com/ekohl))

## [7.2.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.2.0) (2018-07-16)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.1.2...7.2.0)

**Implemented enhancements:**

- Only set up puppet integration if needed [\#168](https://github.com/theforeman/puppet-foreman_proxy_content/pull/168) ([ekohl](https://github.com/ekohl))

**Fixed bugs:**

- Setup pub dir on server and proxies [\#169](https://github.com/theforeman/puppet-foreman_proxy_content/pull/169) ([ehelms](https://github.com/ehelms))

## [7.1.2](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.1.2) (2018-06-08)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.1.1...7.1.2)

**Merged pull requests:**

- refs [\#21350](https://projects.theforeman.org/issues/21350) - use ssl configuration for server profile [\#166](https://github.com/theforeman/puppet-foreman_proxy_content/pull/166) ([stbenjam](https://github.com/stbenjam))

## [7.1.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.1.1) (2018-05-30)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.1.0...7.1.1)

**Implemented enhancements:**

- fixes [\#23557](https://projects.theforeman.org/issues/23557) - log to syslog by default [\#164](https://github.com/theforeman/puppet-foreman_proxy_content/pull/164) ([stbenjam](https://github.com/stbenjam))

**Merged pull requests:**

- Allow puppetlabs-apache 3.x [\#165](https://github.com/theforeman/puppet-foreman_proxy_content/pull/165) ([ekohl](https://github.com/ekohl))

## [7.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.1.0) (2018-05-23)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/6.1.1...7.1.0)

**Implemented enhancements:**

- refs [\#21350](https://projects.theforeman.org/issues/21350) - dispatch router ssl/tls configuration [\#161](https://github.com/theforeman/puppet-foreman_proxy_content/pull/161) ([stbenjam](https://github.com/stbenjam))
- make all repo types configurable [\#160](https://github.com/theforeman/puppet-foreman_proxy_content/pull/160) ([jlsherrill](https://github.com/jlsherrill))

## [7.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.0.0) (2018-01-25)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/6.1.1...7.0.0)

**Breaking changes:**

- refs [\#22289](https://projects.theforeman.org/issues/22289) - fixes for dispatch router 1.0 [\#155](https://github.com/theforeman/puppet-foreman_proxy_content/pull/155) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#21464](https://projects.theforeman.org/issues/21464) - Remove Pulp oauth support [\#151](https://github.com/theforeman/puppet-foreman_proxy_content/pull/151) ([sean797](https://github.com/sean797))

**Implemented enhancements:**

- Refs [\#22338](https://projects.theforeman.org/issues/22338) - add worker\_timeout param [\#156](https://github.com/theforeman/puppet-foreman_proxy_content/pull/156) ([chris1984](https://github.com/chris1984))
- refs [\#21350](https://projects.theforeman.org/issues/21350) - allow config of TLS version on 8443 [\#154](https://github.com/theforeman/puppet-foreman_proxy_content/pull/154) ([stbenjam](https://github.com/stbenjam))
- introduce rhsm\_hostname parameter [\#148](https://github.com/theforeman/puppet-foreman_proxy_content/pull/148) ([timogoebel](https://github.com/timogoebel))
- Fixes [\#21430](https://projects.theforeman.org/issues/21430) - use 1 puppet wsgi process [\#147](https://github.com/theforeman/puppet-foreman_proxy_content/pull/147) ([jlsherrill](https://github.com/jlsherrill))
- Allow katello-certs 4.0 [\#146](https://github.com/theforeman/puppet-foreman_proxy_content/pull/146) ([ekohl](https://github.com/ekohl))
- expose more pulp parameters [\#143](https://github.com/theforeman/puppet-foreman_proxy_content/pull/143) ([timogoebel](https://github.com/timogoebel))
- introduce manage broker parameter [\#141](https://github.com/theforeman/puppet-foreman_proxy_content/pull/141) ([timogoebel](https://github.com/timogoebel))

**Merged pull requests:**

- Update Github URLs [\#150](https://github.com/theforeman/puppet-foreman_proxy_content/pull/150) ([ekohl](https://github.com/ekohl))

## [6.1.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/6.1.1) (2018-02-12)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/6.1.0...6.1.1)

**Breaking changes:**

- refs [\#22289](https://projects.theforeman.org/issues/22289) - fixes for dispatch router 1.0 [\#155](https://github.com/theforeman/puppet-foreman_proxy_content/pull/155) ([stbenjam](https://github.com/stbenjam))

**Implemented enhancements:**

- Allow use of puppet-qpid 4.X [\#158](https://github.com/theforeman/puppet-foreman_proxy_content/pull/158) ([ehelms](https://github.com/ehelms))

## [6.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/6.1.0) (2017-10-18)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/6.0.0...6.1.0)

**Merged pull requests:**

- Allow extlib 2.0 [\#144](https://github.com/theforeman/puppet-foreman_proxy_content/pull/144) ([ekohl](https://github.com/ekohl))
- extract pub dir setup [\#142](https://github.com/theforeman/puppet-foreman_proxy_content/pull/142) ([timogoebel](https://github.com/timogoebel))
- use foreman\_url for reverse proxy upstream [\#140](https://github.com/theforeman/puppet-foreman_proxy_content/pull/140) ([timogoebel](https://github.com/timogoebel))
- Clean up various aspects [\#138](https://github.com/theforeman/puppet-foreman_proxy_content/pull/138) ([ekohl](https://github.com/ekohl))
- Explicitly set ssl\_certs\_dir to an empty string [\#137](https://github.com/theforeman/puppet-foreman_proxy_content/pull/137) ([ekohl](https://github.com/ekohl))

## [6.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/6.0.0) (2017-08-30)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/5.0.1...6.0.0)

**Merged pull requests:**

- Remove mongodb dependency [\#135](https://github.com/theforeman/puppet-foreman_proxy_content/pull/135) ([ekohl](https://github.com/ekohl))
- Allow puppetlabs-apache 2.0 [\#134](https://github.com/theforeman/puppet-foreman_proxy_content/pull/134) ([ekohl](https://github.com/ekohl))
- msync: Puppet 5, parallel tests, .erb templates, cleanups, facter fix [\#131](https://github.com/theforeman/puppet-foreman_proxy_content/pull/131) ([ekohl](https://github.com/ekohl))
- Update the README [\#130](https://github.com/theforeman/puppet-foreman_proxy_content/pull/130) ([ekohl](https://github.com/ekohl))
- Allow pulp 5.x [\#129](https://github.com/theforeman/puppet-foreman_proxy_content/pull/129) ([ekohl](https://github.com/ekohl))
- Bump qpid dependency [\#128](https://github.com/theforeman/puppet-foreman_proxy_content/pull/128) ([ehelms](https://github.com/ehelms))
- Correct pulp certificate integration [\#126](https://github.com/theforeman/puppet-foreman_proxy_content/pull/126) ([ekohl](https://github.com/ekohl))
- Add datacat fixture [\#125](https://github.com/theforeman/puppet-foreman_proxy_content/pull/125) ([ekohl](https://github.com/ekohl))
- Use puppetlabs-apache vhost includes option [\#124](https://github.com/theforeman/puppet-foreman_proxy_content/pull/124) ([ekohl](https://github.com/ekohl))
- Allow theforeman-foreman\_proxy 6.0.0 [\#123](https://github.com/theforeman/puppet-foreman_proxy_content/pull/123) ([ekohl](https://github.com/ekohl))
- Move to puppet 4 [\#122](https://github.com/theforeman/puppet-foreman_proxy_content/pull/122) ([ekohl](https://github.com/ekohl))

## [5.0.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/5.0.1) (2017-06-13)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/5.0.0...5.0.1)

**Merged pull requests:**

- Add crane data dir [\#127](https://github.com/theforeman/puppet-foreman_proxy_content/pull/127) ([jlsherrill](https://github.com/jlsherrill))
- Fix reverse proxy config [\#121](https://github.com/theforeman/puppet-foreman_proxy_content/pull/121) ([ekohl](https://github.com/ekohl))
- fixes [\#19269](https://projects.theforeman.org/issues/19269) - allow browsing /pub over https [\#119](https://github.com/theforeman/puppet-foreman_proxy_content/pull/119) ([stbenjam](https://github.com/stbenjam))

## [5.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/5.0.0) (2017-04-07)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/4.0.1...5.0.0)

**Merged pull requests:**

- Expand ignore with generated files/directories [\#118](https://github.com/theforeman/puppet-foreman_proxy_content/pull/118) ([ekohl](https://github.com/ekohl))
- Modulesync update [\#117](https://github.com/theforeman/puppet-foreman_proxy_content/pull/117) ([ekohl](https://github.com/ekohl))
- Modulesync update [\#116](https://github.com/theforeman/puppet-foreman_proxy_content/pull/116) ([ekohl](https://github.com/ekohl))
- Fixes [\#19016](https://projects.theforeman.org/issues/19016) - change qpid to localhost [\#115](https://github.com/theforeman/puppet-foreman_proxy_content/pull/115) ([Klaas-](https://github.com/Klaas-))
- reload foreman-proxy service when cert changes [\#114](https://github.com/theforeman/puppet-foreman_proxy_content/pull/114) ([timogoebel](https://github.com/timogoebel))
- Update modulesync config [\#112](https://github.com/theforeman/puppet-foreman_proxy_content/pull/112) ([ekohl](https://github.com/ekohl))
- Use Puppet 4 Types [\#111](https://github.com/theforeman/puppet-foreman_proxy_content/pull/111) ([stbenjam](https://github.com/stbenjam))
- Refs [\#16253](https://projects.theforeman.org/issues/16253) - Add max speed var to foreman-proxy-content [\#110](https://github.com/theforeman/puppet-foreman_proxy_content/pull/110) ([sean797](https://github.com/sean797))
- refs [\#17714](https://projects.theforeman.org/issues/17714) - Remove puppet from foreman\_proxy\_content [\#108](https://github.com/theforeman/puppet-foreman_proxy_content/pull/108) ([stbenjam](https://github.com/stbenjam))

## [4.0.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/4.0.1) (2017-01-24)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/4.0.0...4.0.1)

**Merged pull requests:**

- fixes [\#18144](https://projects.theforeman.org/issues/18144) - set /etc/crane.conf data\_dir [\#109](https://github.com/theforeman/puppet-foreman_proxy_content/pull/109) ([thomasmckay](https://github.com/thomasmckay))

## [4.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/4.0.0) (2017-01-03)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/3.1.2...4.0.0)

**Merged pull requests:**

- module sync update [\#107](https://github.com/theforeman/puppet-foreman_proxy_content/pull/107) ([jlsherrill](https://github.com/jlsherrill))
- refs [\#17366](https://projects.theforeman.org/issues/17366) - rename to puppet-foreman\_proxy\_content [\#106](https://github.com/theforeman/puppet-foreman_proxy_content/pull/106) ([stbenjam](https://github.com/stbenjam))
- Crane needs configuration of SSL certs separate from pulp [\#105](https://github.com/theforeman/puppet-foreman_proxy_content/pull/105) ([stbenjam](https://github.com/stbenjam))
- Use crane from puppet-pulp [\#104](https://github.com/theforeman/puppet-foreman_proxy_content/pull/104) ([stbenjam](https://github.com/stbenjam))
- Modulesync, bump major for 1.8.7/el6 drop [\#103](https://github.com/theforeman/puppet-foreman_proxy_content/pull/103) ([stbenjam](https://github.com/stbenjam))
- Modulesync [\#102](https://github.com/theforeman/puppet-foreman_proxy_content/pull/102) ([stbenjam](https://github.com/stbenjam))
- Modulesync [\#100](https://github.com/theforeman/puppet-foreman_proxy_content/pull/100) ([stbenjam](https://github.com/stbenjam))
- fixes [\#16928](https://projects.theforeman.org/issues/16928) - enable logging for qpid dispatch router [\#98](https://github.com/theforeman/puppet-foreman_proxy_content/pull/98) ([stbenjam](https://github.com/stbenjam))
- Document pulp\_master param type as a boolean [\#97](https://github.com/theforeman/puppet-foreman_proxy_content/pull/97) ([stbenjam](https://github.com/stbenjam))
- refs [\#11737](https://projects.theforeman.org/issues/11737) - connect to qpid on localhost [\#96](https://github.com/theforeman/puppet-foreman_proxy_content/pull/96) ([stbenjam](https://github.com/stbenjam))
- Modulesync: rspec-puppet-facts updates [\#95](https://github.com/theforeman/puppet-foreman_proxy_content/pull/95) ([stbenjam](https://github.com/stbenjam))
- fixes [\#11338](https://projects.theforeman.org/issues/11338) - use asymmetric routing for pulp/pulp.task queues [\#53](https://github.com/theforeman/puppet-foreman_proxy_content/pull/53) ([stbenjam](https://github.com/stbenjam))

## [3.1.2](https://github.com/theforeman/puppet-foreman_proxy_content/tree/3.1.2) (2016-09-12)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/3.1.1...3.1.2)

## [3.1.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/3.1.1) (2016-09-12)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/3.1.0...3.1.1)

## [3.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/3.1.0) (2016-09-12)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/3.0.1...3.1.0)

## [3.0.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/3.0.1) (2016-09-12)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/3.0.0...3.0.1)

**Merged pull requests:**

- Fix breaking unit tests [\#94](https://github.com/theforeman/puppet-foreman_proxy_content/pull/94) ([ehelms](https://github.com/ehelms))
- Modulesync update [\#93](https://github.com/theforeman/puppet-foreman_proxy_content/pull/93) ([ehelms](https://github.com/ehelms))
- Only disable passenger on pub if passenger is present [\#92](https://github.com/theforeman/puppet-foreman_proxy_content/pull/92) ([stbenjam](https://github.com/stbenjam))
- refs [\#10283](https://projects.theforeman.org/issues/10283) - mark parameters advanced [\#91](https://github.com/theforeman/puppet-foreman_proxy_content/pull/91) ([stbenjam](https://github.com/stbenjam))
- Pass through server implementation parameter to puppet class [\#90](https://github.com/theforeman/puppet-foreman_proxy_content/pull/90) ([stbenjam](https://github.com/stbenjam))
- Modulesync: pin json\_pure [\#89](https://github.com/theforeman/puppet-foreman_proxy_content/pull/89) ([stbenjam](https://github.com/stbenjam))
- Pin extlib since they dropped 1.8.7 support [\#88](https://github.com/theforeman/puppet-foreman_proxy_content/pull/88) ([stbenjam](https://github.com/stbenjam))
- refs [\#15217](https://projects.theforeman.org/issues/15217) - puppet 4 support [\#87](https://github.com/theforeman/puppet-foreman_proxy_content/pull/87) ([stbenjam](https://github.com/stbenjam))

## [3.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/3.0.0) (2016-06-08)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/2.1.0...3.0.0)

**Merged pull requests:**

- Updating to support 3.X proxy modules [\#86](https://github.com/theforeman/puppet-foreman_proxy_content/pull/86) ([jlsherrill](https://github.com/jlsherrill))
- refs [\#15326](https://projects.theforeman.org/issues/15326) - revert mongo auth [\#85](https://github.com/theforeman/puppet-foreman_proxy_content/pull/85) ([stbenjam](https://github.com/stbenjam))

## [2.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/2.1.0) (2016-05-18)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/2.0.2...2.1.0)

**Merged pull requests:**

- refs [\#15058](https://projects.theforeman.org/issues/15058) - enable mongo auth [\#84](https://github.com/theforeman/puppet-foreman_proxy_content/pull/84) ([stbenjam](https://github.com/stbenjam))
- Add paths for puppet-lint docs check [\#83](https://github.com/theforeman/puppet-foreman_proxy_content/pull/83) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#14534](https://projects.theforeman.org/issues/14534) - ensure we install client-bootstrap [\#81](https://github.com/theforeman/puppet-foreman_proxy_content/pull/81) ([mccun934](https://github.com/mccun934))

## [2.0.2](https://github.com/theforeman/puppet-foreman_proxy_content/tree/2.0.2) (2016-04-11)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/2.0.1...2.0.2)

**Merged pull requests:**

- Fixes [\#14359](https://projects.theforeman.org/issues/14359) - SSL errors on capsule sync [\#79](https://github.com/theforeman/puppet-foreman_proxy_content/pull/79) ([johnpmitsch](https://github.com/johnpmitsch))

## [2.0.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/2.0.1) (2016-03-17)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/2.0.0...2.0.1)

**Merged pull requests:**

- Bump the crane dependency to 1.0.0 [\#78](https://github.com/theforeman/puppet-foreman_proxy_content/pull/78) ([ehelms](https://github.com/ehelms))
- Modulesync [\#77](https://github.com/theforeman/puppet-foreman_proxy_content/pull/77) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#13200](https://projects.theforeman.org/issues/13200) - Ensure that the capsule installer sets up a standart p… [\#76](https://github.com/theforeman/puppet-foreman_proxy_content/pull/76) ([johnpmitsch](https://github.com/johnpmitsch))
- Fixes [\#14075](https://projects.theforeman.org/issues/14075) - ignore deprecated warnings [\#75](https://github.com/theforeman/puppet-foreman_proxy_content/pull/75) ([ares](https://github.com/ares))

## [2.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/2.0.0) (2016-02-24)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/1.0.3...2.0.0)

**Merged pull requests:**

- fixes [\#13451](https://projects.theforeman.org/issues/13451) - Enables lazy sync [\#74](https://github.com/theforeman/puppet-foreman_proxy_content/pull/74) ([cfouant](https://github.com/cfouant))
- Fixes [\#13626](https://projects.theforeman.org/issues/13626) - Enable ostree on capsules [\#73](https://github.com/theforeman/puppet-foreman_proxy_content/pull/73) ([parthaa](https://github.com/parthaa))
- Bump puppet-pulp requirement to 3.X [\#72](https://github.com/theforeman/puppet-foreman_proxy_content/pull/72) ([ehelms](https://github.com/ehelms))
- Refs [\#13607](https://projects.theforeman.org/issues/13607) - Removed pulp.conf [\#71](https://github.com/theforeman/puppet-foreman_proxy_content/pull/71) ([parthaa](https://github.com/parthaa))
- include apache class as it is used to fetch apache version [\#70](https://github.com/theforeman/puppet-foreman_proxy_content/pull/70) ([jlsherrill](https://github.com/jlsherrill))
- Refs [\#13431](https://projects.theforeman.org/issues/13431) - Apache changes for pulp 2.8 [\#69](https://github.com/theforeman/puppet-foreman_proxy_content/pull/69) ([parthaa](https://github.com/parthaa))
- fixes [\#13030](https://projects.theforeman.org/issues/13030) - Mark remote execution boolean parameters as booleans  [\#67](https://github.com/theforeman/puppet-foreman_proxy_content/pull/67) ([stbenjam](https://github.com/stbenjam))
- refs [\#10533](https://projects.theforeman.org/issues/10533) - initial changes to support decoupling puppet-foreman\_proxy from puppet-capsule [\#64](https://github.com/theforeman/puppet-foreman_proxy_content/pull/64) ([bbuckingham](https://github.com/bbuckingham))

## [1.0.3](https://github.com/theforeman/puppet-foreman_proxy_content/tree/1.0.3) (2015-11-20)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/1.0.1...1.0.3)

**Merged pull requests:**

- support 2.0 pulp  module [\#66](https://github.com/theforeman/puppet-foreman_proxy_content/pull/66) ([jlsherrill](https://github.com/jlsherrill))
- fixes [\#12519](https://projects.theforeman.org/issues/12519) - pass dhcp-managed through to foreman-proxy [\#65](https://github.com/theforeman/puppet-foreman_proxy_content/pull/65) ([stbenjam](https://github.com/stbenjam))
- fixes [\#12000](https://projects.theforeman.org/issues/12000) - add support for remote execution ssh plugin [\#62](https://github.com/theforeman/puppet-foreman_proxy_content/pull/62) ([stbenjam](https://github.com/stbenjam))

## [1.0.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/1.0.1) (2015-10-23)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/1.0.2...1.0.1)

## [1.0.2](https://github.com/theforeman/puppet-foreman_proxy_content/tree/1.0.2) (2015-10-23)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/1.0.0...1.0.2)

**Merged pull requests:**

- Additional updates to support puppet-pulp 1.0.0 [\#61](https://github.com/theforeman/puppet-foreman_proxy_content/pull/61) ([bbuckingham](https://github.com/bbuckingham))
- fixes [\#12026](https://projects.theforeman.org/issues/12026) - changes need for dispatch router heartbeat [\#59](https://github.com/theforeman/puppet-foreman_proxy_content/pull/59) ([stbenjam](https://github.com/stbenjam))

## [1.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/1.0.0) (2015-10-15)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/0.2.1...1.0.0)

**Merged pull requests:**

- Use cache\_data and random\_password from extlib [\#60](https://github.com/theforeman/puppet-foreman_proxy_content/pull/60) ([ehelms](https://github.com/ehelms))
- fixes [\#11958](https://projects.theforeman.org/issues/11958): fix node configuration [\#58](https://github.com/theforeman/puppet-foreman_proxy_content/pull/58) ([bbuckingham](https://github.com/bbuckingham))
- Support puppet-pulp 1.0.0 [\#56](https://github.com/theforeman/puppet-foreman_proxy_content/pull/56) ([ehelms](https://github.com/ehelms))

## [0.2.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/0.2.1) (2015-09-03)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/0.2.0...0.2.1)

**Merged pull requests:**

- Fixes [\#11660](https://projects.theforeman.org/issues/11660) - use default CA for client certificates verification [\#54](https://github.com/theforeman/puppet-foreman_proxy_content/pull/54) ([iNecas](https://github.com/iNecas))
- Add forge and travis badges to README [\#52](https://github.com/theforeman/puppet-foreman_proxy_content/pull/52) ([stbenjam](https://github.com/stbenjam))

## [0.2.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/0.2.0) (2015-07-20)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/df8a7710b37b10f1d398c96e605941360034501e...0.2.0)

**Merged pull requests:**

- Prepare puppet-capsule for release [\#51](https://github.com/theforeman/puppet-foreman_proxy_content/pull/51) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#10591](https://projects.theforeman.org/issues/10591): Crane setup references wrong CA path. [\#49](https://github.com/theforeman/puppet-foreman_proxy_content/pull/49) ([ehelms](https://github.com/ehelms))
- Fixes [\#10675](https://projects.theforeman.org/issues/10675) - templates plugin enabled by default [\#48](https://github.com/theforeman/puppet-foreman_proxy_content/pull/48) ([lzap](https://github.com/lzap))
- Refs [\#10616](https://projects.theforeman.org/issues/10616) - use new pulp child ssl fragment for gpg key proxy [\#47](https://github.com/theforeman/puppet-foreman_proxy_content/pull/47) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#10599](https://projects.theforeman.org/issues/10599): Add missing dhcp options. [\#46](https://github.com/theforeman/puppet-foreman_proxy_content/pull/46) ([ehelms](https://github.com/ehelms))
- Updates for modulesync. [\#45](https://github.com/theforeman/puppet-foreman_proxy_content/pull/45) ([ehelms](https://github.com/ehelms))
- fixes [\#10387](https://projects.theforeman.org/issues/10387) - set apache certs properly on crane module [\#44](https://github.com/theforeman/puppet-foreman_proxy_content/pull/44) ([jlsherrill](https://github.com/jlsherrill))
- fixes [\#9892](https://projects.theforeman.org/issues/9892) - deploy crane on both pulp and pulp node [\#40](https://github.com/theforeman/puppet-foreman_proxy_content/pull/40) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#9816](https://projects.theforeman.org/issues/9816): Allow access to /pub on http for things like the boostrap R... [\#39](https://github.com/theforeman/puppet-foreman_proxy_content/pull/39) ([ehelms](https://github.com/ehelms))
- fixes [\#9743](https://projects.theforeman.org/issues/9743) - expose bmc options in capsule [\#38](https://github.com/theforeman/puppet-foreman_proxy_content/pull/38) ([stbenjam](https://github.com/stbenjam))
- refs [\#9668](https://projects.theforeman.org/issues/9668) - configure dispatch router only if pulp or pulp node enabled [\#36](https://github.com/theforeman/puppet-foreman_proxy_content/pull/36) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#7780](https://projects.theforeman.org/issues/7780): Add crane deployment to capsule if Pulp is enabled. [\#35](https://github.com/theforeman/puppet-foreman_proxy_content/pull/35) ([ehelms](https://github.com/ehelms))
- refs [\#8175](https://projects.theforeman.org/issues/8175) - configure dispatch router on pulp and pulp nodes [\#34](https://github.com/theforeman/puppet-foreman_proxy_content/pull/34) ([stbenjam](https://github.com/stbenjam))
- Refs [\#8710](https://projects.theforeman.org/issues/8710) - install katello-debug by default [\#33](https://github.com/theforeman/puppet-foreman_proxy_content/pull/33) ([lzap](https://github.com/lzap))
- refs [\#9102](https://projects.theforeman.org/issues/9102) - enabled trusted hosts for capsule and parent FQDN's [\#32](https://github.com/theforeman/puppet-foreman_proxy_content/pull/32) ([stbenjam](https://github.com/stbenjam))
- fixes [\#8991](https://projects.theforeman.org/issues/8991) - configure templates proxy  [\#31](https://github.com/theforeman/puppet-foreman_proxy_content/pull/31) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#7745](https://projects.theforeman.org/issues/7745): Deploy reverse proxy for RHSM traffic. [\#30](https://github.com/theforeman/puppet-foreman_proxy_content/pull/30) ([ehelms](https://github.com/ehelms))
- fixes [\#8909](https://projects.theforeman.org/issues/8909) - correct version numbers of dependent modules [\#29](https://github.com/theforeman/puppet-foreman_proxy_content/pull/29) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#8756](https://projects.theforeman.org/issues/8756): Generates consumer cert RPM on the Capsule. [\#28](https://github.com/theforeman/puppet-foreman_proxy_content/pull/28) ([ehelms](https://github.com/ehelms))
- Fixes [\#7643](https://projects.theforeman.org/issues/7643): Properly configure whether the puppet master is a CA. [\#27](https://github.com/theforeman/puppet-foreman_proxy_content/pull/27) ([ehelms](https://github.com/ehelms))
- Refs [\#8372](https://projects.theforeman.org/issues/8372) - pass the correct paths to the foreman\_ssl\_certs [\#26](https://github.com/theforeman/puppet-foreman_proxy_content/pull/26) ([iNecas](https://github.com/iNecas))
- Fixes [\#8600](https://projects.theforeman.org/issues/8600) : Fix typos in the help text which show up in the installer [\#25](https://github.com/theforeman/puppet-foreman_proxy_content/pull/25) ([bkearney](https://github.com/bkearney))
- Fixes [\#7741](https://projects.theforeman.org/issues/7741): Include smart proxy if Pulp is installed. [\#24](https://github.com/theforeman/puppet-foreman_proxy_content/pull/24) ([ehelms](https://github.com/ehelms))
- refs [\#7633](https://projects.theforeman.org/issues/7633) - fixing dep version of common [\#23](https://github.com/theforeman/puppet-foreman_proxy_content/pull/23) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#7643](https://projects.theforeman.org/issues/7643): Expose Puppet CA proxy option. [\#21](https://github.com/theforeman/puppet-foreman_proxy_content/pull/21) ([ehelms](https://github.com/ehelms))
- refs [\#7396](https://projects.theforeman.org/issues/7396) - set foreman ENC API version [\#20](https://github.com/theforeman/puppet-foreman_proxy_content/pull/20) ([stbenjam](https://github.com/stbenjam))
- fixes [\#7386](https://projects.theforeman.org/issues/7386) - fixing install with capsule-tftp=true [\#19](https://github.com/theforeman/puppet-foreman_proxy_content/pull/19) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#7159](https://projects.theforeman.org/issues/7159): Add missing foreman\_proxy options. [\#18](https://github.com/theforeman/puppet-foreman_proxy_content/pull/18) ([ehelms](https://github.com/ehelms))
- Refs [\#6736](https://projects.theforeman.org/issues/6736): Updates to standard layout and adds basic test. [\#17](https://github.com/theforeman/puppet-foreman_proxy_content/pull/17) ([ehelms](https://github.com/ehelms))
- Refs [\#7147](https://projects.theforeman.org/issues/7147) - lock puppet-lint to \<= 1.0.0 [\#16](https://github.com/theforeman/puppet-foreman_proxy_content/pull/16) ([iNecas](https://github.com/iNecas))
- fixes [\#7108](https://projects.theforeman.org/issues/7108) - if using pulp at all, override both pulp and pulpnode settings [\#15](https://github.com/theforeman/puppet-foreman_proxy_content/pull/15) ([jlsherrill](https://github.com/jlsherrill))
- Refs [\#6927](https://projects.theforeman.org/issues/6927) - remove check around pulp capsule prerequsites [\#14](https://github.com/theforeman/puppet-foreman_proxy_content/pull/14) ([iNecas](https://github.com/iNecas))
- refs [\#6330](https://projects.theforeman.org/issues/6330) - adding support for pulp smart proxy plugin [\#13](https://github.com/theforeman/puppet-foreman_proxy_content/pull/13) ([jlsherrill](https://github.com/jlsherrill))
- Refs [\#6875](https://projects.theforeman.org/issues/6875) - Update the modules to the changes in puppet-certs module [\#12](https://github.com/theforeman/puppet-foreman_proxy_content/pull/12) ([iNecas](https://github.com/iNecas))
- fixes [\#6698](https://projects.theforeman.org/issues/6698) - install foreman proxy if realm is selected [\#10](https://github.com/theforeman/puppet-foreman_proxy_content/pull/10) ([stbenjam](https://github.com/stbenjam))
- Fixes [\#6088](https://projects.theforeman.org/issues/6088) - expose realm settings for smart proxy in the capsule installer [\#8](https://github.com/theforeman/puppet-foreman_proxy_content/pull/8) ([iNecas](https://github.com/iNecas))
- fixes [\#6077](https://projects.theforeman.org/issues/6077) - exposing http pulp repos for capsule [\#7](https://github.com/theforeman/puppet-foreman_proxy_content/pull/7) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#5815](https://projects.theforeman.org/issues/5815) - set up the qpid ssl connection properly [\#6](https://github.com/theforeman/puppet-foreman_proxy_content/pull/6) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#5815](https://projects.theforeman.org/issues/5815) - set up the qpid ssl connection properly [\#5](https://github.com/theforeman/puppet-foreman_proxy_content/pull/5) ([iNecas](https://github.com/iNecas))
- Refs [\#5423](https://projects.theforeman.org/issues/5423) - fix capsule configuration [\#4](https://github.com/theforeman/puppet-foreman_proxy_content/pull/4) ([iNecas](https://github.com/iNecas))
- Moving certs into their own class to prevent defined type from being [\#3](https://github.com/theforeman/puppet-foreman_proxy_content/pull/3) ([ehelms](https://github.com/ehelms))
- Updating variable names changed in puppet-certs. [\#2](https://github.com/theforeman/puppet-foreman_proxy_content/pull/2) ([ehelms](https://github.com/ehelms))
- $capsule::params::certs\_tar was not defined [\#1](https://github.com/theforeman/puppet-foreman_proxy_content/pull/1) ([iNecas](https://github.com/iNecas))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
