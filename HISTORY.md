## [18.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/18.0.0) (2021-04-27)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/17.1.0...18.0.0)

**Breaking changes:**

- Refs [\#32239](https://projects.theforeman.org/issues/32239) - Drop pulp 2 parameters from foreman\_proxy::plugin::pulp [\#339](https://github.com/theforeman/puppet-foreman_proxy_content/pull/339) ([ehelms](https://github.com/ehelms))
- Refs [\#32037](https://projects.theforeman.org/issues/32037): Add flag to enable katello\_agent infrastructure and disable it by default [\#329](https://github.com/theforeman/puppet-foreman_proxy_content/pull/329) ([ehelms](https://github.com/ehelms))

**Implemented enhancements:**

- Allow puppet-certs \< 13.0.0 [\#348](https://github.com/theforeman/puppet-foreman_proxy_content/pull/348) ([wbclark](https://github.com/wbclark))
- Fixes [\#32160](https://projects.theforeman.org/issues/32160) - enable ansible content [\#343](https://github.com/theforeman/puppet-foreman_proxy_content/pull/343) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#32338](https://projects.theforeman.org/issues/32338) - expose pulpcore allowed\_content\_checksums [\#342](https://github.com/theforeman/puppet-foreman_proxy_content/pull/342) ([jlsherrill](https://github.com/jlsherrill))
- Allow puppet-qpid 8+ [\#341](https://github.com/theforeman/puppet-foreman_proxy_content/pull/341) ([ehelms](https://github.com/ehelms))
- Generalize Puppet certs chaining [\#340](https://github.com/theforeman/puppet-foreman_proxy_content/pull/340) ([ekohl](https://github.com/ekohl))

**Fixed bugs:**

- Refs [\#32338](https://projects.theforeman.org/issues/32338) - Move content array param to params.pp [\#346](https://github.com/theforeman/puppet-foreman_proxy_content/pull/346) ([ekohl](https://github.com/ekohl))

## [17.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/17.1.0) (2021-03-24)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/17.0.0...17.1.0)

**Implemented enhancements:**

- Fixes [\#32161](https://projects.theforeman.org/issues/32161): Set disablereuse=on and retry=0 on reverse proxy [\#337](https://github.com/theforeman/puppet-foreman_proxy_content/pull/337) ([ehelms](https://github.com/ehelms))
- Fixes [\#32149](https://projects.theforeman.org/issues/32149) - Expose pulpcore-{content,api} gunicorn worker timeouts [\#335](https://github.com/theforeman/puppet-foreman_proxy_content/pull/335) ([wbclark](https://github.com/wbclark))
- Add pulpcore\_django\_secret\_key parameter [\#331](https://github.com/theforeman/puppet-foreman_proxy_content/pull/331) ([laugmanuel](https://github.com/laugmanuel))

## [17.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/17.0.0) (2021-03-10)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/16.0.0...17.0.0)

**Breaking changes:**

- Refs [\#31878](https://projects.theforeman.org/issues/31878): Use client certificate auth to talk from qpid-dispatch t… [\#327](https://github.com/theforeman/puppet-foreman_proxy_content/pull/327) ([ehelms](https://github.com/ehelms))

**Implemented enhancements:**

- Fixes [\#31868](https://projects.theforeman.org/issues/31868): Switch to /pulp/content/ by default for clients [\#328](https://github.com/theforeman/puppet-foreman_proxy_content/pull/328) ([ehelms](https://github.com/ehelms))

**Merged pull requests:**

- Allow katello/qpid 7.x [\#332](https://github.com/theforeman/puppet-foreman_proxy_content/pull/332) ([ekohl](https://github.com/ekohl))

## [16.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/16.0.0) (2021-02-10)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/15.0.0...16.0.0)

**Breaking changes:**

- Refs [\#30360](https://projects.theforeman.org/issues/30360): Disable Pulp 2 foreman\_proxy plugin [\#321](https://github.com/theforeman/puppet-foreman_proxy_content/pull/321) ([ehelms](https://github.com/ehelms))

**Implemented enhancements:**

- Configure qpid dispatch router on EL8 [\#323](https://github.com/theforeman/puppet-foreman_proxy_content/pull/323) ([ehelms](https://github.com/ehelms))
- Fixes [\#31800](https://projects.theforeman.org/issues/31800) - Create qdrouter inbound link for katello.agent queue [\#322](https://github.com/theforeman/puppet-foreman_proxy_content/pull/322) ([jturel](https://github.com/jturel))
- Fixes [\#31642](https://projects.theforeman.org/issues/31642) - Add container gateway support [\#319](https://github.com/theforeman/puppet-foreman_proxy_content/pull/319) ([ianballou](https://github.com/ianballou))

## [15.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/15.0.0) (2021-02-01)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/14.2.0...15.0.0)

**Breaking changes:**

- Drop unused Pulp dependency and pulp\_nodes template [\#318](https://github.com/theforeman/puppet-foreman_proxy_content/pull/318) ([ekohl](https://github.com/ekohl))
- Drop parent\_fqdn in favor of deriving from foreman\_url [\#309](https://github.com/theforeman/puppet-foreman_proxy_content/pull/309) ([ehelms](https://github.com/ehelms))
- Refs [\#31614](https://projects.theforeman.org/issues/31614): Drop Pulp 2, Pulpcore only [\#306](https://github.com/theforeman/puppet-foreman_proxy_content/pull/306) ([ehelms](https://github.com/ehelms))
- Fixes [\#31435](https://projects.theforeman.org/issues/31435) - Drop ssl\_protocol parameter [\#302](https://github.com/theforeman/puppet-foreman_proxy_content/pull/302) ([ekohl](https://github.com/ekohl))
- Fixes [\#31385](https://projects.theforeman.org/issues/31385) - Default to strict qpid-router ciphers [\#301](https://github.com/theforeman/puppet-foreman_proxy_content/pull/301) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- include all pulpcore plugins conditionally [\#311](https://github.com/theforeman/puppet-foreman_proxy_content/pull/311) ([evgeni](https://github.com/evgeni))
- Simplify reverse proxy definition [\#308](https://github.com/theforeman/puppet-foreman_proxy_content/pull/308) ([ekohl](https://github.com/ekohl))
- Fixes [\#31509](https://projects.theforeman.org/issues/31509) - Allow changing node FQDN [\#307](https://github.com/theforeman/puppet-foreman_proxy_content/pull/307) ([ekohl](https://github.com/ekohl))
- Move static defaults from params to init [\#298](https://github.com/theforeman/puppet-foreman_proxy_content/pull/298) ([ekohl](https://github.com/ekohl))
- Refs [\#30436](https://projects.theforeman.org/issues/30436) - add import/export params [\#297](https://github.com/theforeman/puppet-foreman_proxy_content/pull/297) ([jeremylenz](https://github.com/jeremylenz))
- Deploy reverse proxy in Pulp 3 only scenarios [\#293](https://github.com/theforeman/puppet-foreman_proxy_content/pull/293) ([ehelms](https://github.com/ehelms))
- Proxy pulp/deb to pulpcore support [\#292](https://github.com/theforeman/puppet-foreman_proxy_content/pull/292) ([jlsherrill](https://github.com/jlsherrill))

**Fixed bugs:**

- Ensure foreman\_proxy::plugin::pulp does not enable Pulp 2 on EL8 [\#316](https://github.com/theforeman/puppet-foreman_proxy_content/pull/316) ([ehelms](https://github.com/ehelms))
- Fixes [\#31662](https://projects.theforeman.org/issues/31662): Set enable\_http to ensure pub dir is deployed to Pulp v… [\#315](https://github.com/theforeman/puppet-foreman_proxy_content/pull/315) ([ehelms](https://github.com/ehelms))
- enable pulpcore deb only if enabled [\#310](https://github.com/theforeman/puppet-foreman_proxy_content/pull/310) ([jlsherrill](https://github.com/jlsherrill))
- Don't enable Pulp2 Deb with Pulpcore [\#300](https://github.com/theforeman/puppet-foreman_proxy_content/pull/300) ([wbclark](https://github.com/wbclark))
- Fix missing variable scoping on reverse\_proxy and add tests for pulpcore [\#294](https://github.com/theforeman/puppet-foreman_proxy_content/pull/294) ([ehelms](https://github.com/ehelms))

## [14.2.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/14.2.0) (2020-12-07)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/14.1.0...14.2.0)

**Implemented enhancements:**

- Refs [\#31539](https://projects.theforeman.org/issues/31539) - Support deb content with Pulpcore [\#313](https://github.com/theforeman/puppet-foreman_proxy_content/pull/313) ([ekohl](https://github.com/ekohl))

## [14.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/14.1.0) (2020-12-07)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/14.0.0...14.1.0)

**Implemented enhancements:**

- Refs [\#30436](https://projects.theforeman.org/issues/30436) - Add import/export params [\#304](https://github.com/theforeman/puppet-foreman_proxy_content/pull/304) ([jeremylenz](https://github.com/jeremylenz))
## [14.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/14.0.0) (2020-10-30)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/13.0.0...14.0.0)

**Breaking changes:**

- Rely on pulpcore to set up Apache fragments [\#268](https://github.com/theforeman/puppet-foreman_proxy_content/pull/268) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Deploy Apache certificates for standalone Pulpcore [\#287](https://github.com/theforeman/puppet-foreman_proxy_content/pull/287) ([ekohl](https://github.com/ekohl))
- Set reverse proxy servername via certs [\#286](https://github.com/theforeman/puppet-foreman_proxy_content/pull/286) ([ekohl](https://github.com/ekohl))
- deploy pub\_dir also when not deploying pulp2 [\#282](https://github.com/theforeman/puppet-foreman_proxy_content/pull/282) ([evgeni](https://github.com/evgeni))

## [13.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/13.0.0) (2020-09-23)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/11.1.1...13.0.0)

**Breaking changes:**

- Fixes [\#30780](https://projects.theforeman.org/issues/30780) - support pulp\_container 2.0 registry [\#281](https://github.com/theforeman/puppet-foreman_proxy_content/pull/281) ([jlsherrill](https://github.com/jlsherrill))
- Fixes [\#30363](https://projects.theforeman.org/issues/30363): Rewrite bootstrap creation to use RPM [\#274](https://github.com/theforeman/puppet-foreman_proxy_content/pull/274) ([ehelms](https://github.com/ehelms))

**Fixed bugs:**

- Refs [\#30363](https://projects.theforeman.org/issues/30363): Generate new bootstrap RPM if old style is detected [\#280](https://github.com/theforeman/puppet-foreman_proxy_content/pull/280) ([ehelms](https://github.com/ehelms))
- Fixes [\#30716](https://projects.theforeman.org/issues/30716): Ensure /pub on foreman proxy can be browsed by default [\#277](https://github.com/theforeman/puppet-foreman_proxy_content/pull/277) ([ehelms](https://github.com/ehelms))

## [12.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/12.0.0) (2020-08-07)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/11.1.0...12.0.0)

**Breaking changes:**

- Fixes [\#30316](https://projects.theforeman.org/issues/30316): Move bootstrap RPM generation from puppet-certs [\#272](https://github.com/theforeman/puppet-foreman_proxy_content/pull/272) ([ehelms](https://github.com/ehelms))

**Implemented enhancements:**

- Allow katello/certs 9.x [\#273](https://github.com/theforeman/puppet-foreman_proxy_content/pull/273) ([ehelms](https://github.com/ehelms))
- Fixes [\#30057](https://projects.theforeman.org/issues/30057) - Expose Pulpcore Worker Count in Puppet-FPC [\#270](https://github.com/theforeman/puppet-foreman_proxy_content/pull/270) ([wbclark](https://github.com/wbclark))

## [11.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/11.1.0) (2020-06-30)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/10.0.0...11.1.0)

**Implemented enhancements:**

- Fixes [\#30217](https://projects.theforeman.org/issues/30217) - configure pulpcore db name [\#266](https://github.com/theforeman/puppet-foreman_proxy_content/pull/266) ([wbclark](https://github.com/wbclark))
- Fixes [\#30059](https://projects.theforeman.org/issues/30059) - Add config for protected content [\#263](https://github.com/theforeman/puppet-foreman_proxy_content/pull/263) ([sjha4](https://github.com/sjha4))
- Refs [\#30023](https://projects.theforeman.org/issues/30023): Enable Pulpcore RPM plugin [\#261](https://github.com/theforeman/puppet-foreman_proxy_content/pull/261) ([ehelms](https://github.com/ehelms))

**Fixed bugs:**

- Use the correct variables in pulpcore templates [\#267](https://github.com/theforeman/puppet-foreman_proxy_content/pull/267) ([ekohl](https://github.com/ekohl))
- Fixes [\#29660](https://projects.theforeman.org/issues/29660) - Serve Pulpcore ISO via HTTPS [\#260](https://github.com/theforeman/puppet-foreman_proxy_content/pull/260) ([ekohl](https://github.com/ekohl))

## [11.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/11.0.0) (2020-05-18)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/10.0.0...11.0.0)

**Breaking changes:**

- Use modern facts [\#258](https://github.com/theforeman/puppet-foreman_proxy_content/issues/258)

**Implemented enhancements:**

- Allow EL8 supported versions of dependencies [\#257](https://github.com/theforeman/puppet-foreman_proxy_content/pull/257) ([wbclark](https://github.com/wbclark))
- Fixes [\#29214](https://projects.theforeman.org/issues/29214): Add EL8 support to metadata [\#255](https://github.com/theforeman/puppet-foreman_proxy_content/pull/255) ([ehelms](https://github.com/ehelms))
- Refs [\#29211](https://projects.theforeman.org/issues/29211): Use extlib 5.x for EL8 support [\#254](https://github.com/theforeman/puppet-foreman_proxy_content/pull/254) ([ehelms](https://github.com/ehelms))
- Refs [\#29214](https://projects.theforeman.org/issues/29214): Only install Pulp and Qpid on El7 [\#251](https://github.com/theforeman/puppet-foreman_proxy_content/pull/251) ([ehelms](https://github.com/ehelms))
- Fixes [\#29278](https://projects.theforeman.org/issues/29278): Use default CA for crane SSL chain [\#246](https://github.com/theforeman/puppet-foreman_proxy_content/pull/246) ([ekohl](https://github.com/ekohl))
- Fixes [\#28901](https://projects.theforeman.org/issues/28901) - Support SSL connection for external Pulpcore PostgreSQL [\#244](https://github.com/theforeman/puppet-foreman_proxy_content/pull/244) ([wbclark](https://github.com/wbclark))
- Use loose coupling to Foreman's Apache config [\#243](https://github.com/theforeman/puppet-foreman_proxy_content/pull/243) ([ekohl](https://github.com/ekohl))
- Refs [\#28901](https://projects.theforeman.org/issues/28901) - support external postgres database in pulpcore [\#241](https://github.com/theforeman/puppet-foreman_proxy_content/pull/241) ([wbclark](https://github.com/wbclark))

**Fixed bugs:**

- Fixes [\#29589](https://projects.theforeman.org/issues/29589) - Ensure pulpcore before proxy [\#252](https://github.com/theforeman/puppet-foreman_proxy_content/pull/252) ([ekohl](https://github.com/ekohl))

## [10.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/10.0.0) (2020-02-12)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/9.1.0...10.0.0)

**Breaking changes:**

- Do not configure Pulp CA certificate [\#235](https://github.com/theforeman/puppet-foreman_proxy_content/pull/235) ([ehelms](https://github.com/ehelms))
- use pulpcore naming convention [\#226](https://github.com/theforeman/puppet-foreman_proxy_content/pull/226) ([wbclark](https://github.com/wbclark))
- Drop node\_server\_ca\_cert parameter [\#224](https://github.com/theforeman/puppet-foreman_proxy_content/pull/224) ([ekohl](https://github.com/ekohl))
- Derive $pulp\_master variable [\#217](https://github.com/theforeman/puppet-foreman_proxy_content/pull/217) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Refs [\#28904](https://projects.theforeman.org/issues/28904) - configure pulpcore django\_remote\_user [\#237](https://github.com/theforeman/puppet-foreman_proxy_content/pull/237) ([synkd](https://github.com/synkd))
- Allow katello/certs 7.x [\#234](https://github.com/theforeman/puppet-foreman_proxy_content/pull/234) ([ekohl](https://github.com/ekohl))
- Fixes [\#28696](https://projects.theforeman.org/issues/28696) - configures apache to serve docker content with pulp3 [\#233](https://github.com/theforeman/puppet-foreman_proxy_content/pull/233) ([wbclark](https://github.com/wbclark))
- katello/certs 7.x compatibility & use certs::qpid\_client variables [\#232](https://github.com/theforeman/puppet-foreman_proxy_content/pull/232) ([ekohl](https://github.com/ekohl))
- Fixes [\#28711](https://projects.theforeman.org/issues/28711) - Serve /pulp/content over http with pulp3 [\#231](https://github.com/theforeman/puppet-foreman_proxy_content/pull/231) ([wbclark](https://github.com/wbclark))
- Fixes [\#28654](https://projects.theforeman.org/issues/28654) - support client cert auth with pulp3 [\#229](https://github.com/theforeman/puppet-foreman_proxy_content/pull/229) ([wbclark](https://github.com/wbclark))
- fixes [\#28655](https://projects.theforeman.org/issues/28655) - support fetching files via /pulp/isos with pulp3 [\#228](https://github.com/theforeman/puppet-foreman_proxy_content/pull/228) ([wbclark](https://github.com/wbclark))
- Install file and container plugins for Pulp 3 [\#225](https://github.com/theforeman/puppet-foreman_proxy_content/pull/225) ([ehelms](https://github.com/ehelms))
- Add initial pulp3 support [\#222](https://github.com/theforeman/puppet-foreman_proxy_content/pull/222) ([wbclark](https://github.com/wbclark))
- Make dispatch router standalone classes [\#221](https://github.com/theforeman/puppet-foreman_proxy_content/pull/221) ([ekohl](https://github.com/ekohl))
- Use Stdlib::Port where appropriate [\#220](https://github.com/theforeman/puppet-foreman_proxy_content/pull/220) ([ekohl](https://github.com/ekohl))
- Drop unused templates [\#216](https://github.com/theforeman/puppet-foreman_proxy_content/pull/216) ([ekohl](https://github.com/ekohl))

**Fixed bugs:**

- Fixes [\#28983](https://projects.theforeman.org/issues/28983) - Allow integers for $proxy\_pass\_params [\#240](https://github.com/theforeman/puppet-foreman_proxy_content/pull/240) ([ekohl](https://github.com/ekohl))
- Pass https\_ca\_cert to pulp [\#236](https://github.com/theforeman/puppet-foreman_proxy_content/pull/236) ([ekohl](https://github.com/ekohl))
- Refs [\#28761](https://projects.theforeman.org/issues/28761) - Always set an empty REMOTE\_USER for pulpcore API [\#230](https://github.com/theforeman/puppet-foreman_proxy_content/pull/230) ([pdudley](https://github.com/pdudley))

**Merged pull requests:**

- Refs [\#28720](https://projects.theforeman.org/issues/28720) - connect to mongo for content migrations [\#238](https://github.com/theforeman/puppet-foreman_proxy_content/pull/238) ([wbclark](https://github.com/wbclark))
- remove redundant ProxyPassReverse url [\#223](https://github.com/theforeman/puppet-foreman_proxy_content/pull/223) ([wbclark](https://github.com/wbclark))
- Match author casing to name in metadata [\#213](https://github.com/theforeman/puppet-foreman_proxy_content/pull/213) ([ekohl](https://github.com/ekohl))

## [9.1.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/9.1.0) (2019-10-25)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/9.0.2...9.1.0)

**Implemented enhancements:**

- Fixes [\#27687](https://projects.theforeman.org/issues/27687) - Add vhost\_params and proxy\_pass\_params [\#210](https://github.com/theforeman/puppet-foreman_proxy_content/pull/210) ([ekohl](https://github.com/ekohl))
- Fixes [\#27689](https://projects.theforeman.org/issues/27689) - Allow customization of pub dir on foreman proxy server [\#207](https://github.com/theforeman/puppet-foreman_proxy_content/pull/207) ([snagoor](https://github.com/snagoor))

**Fixed bugs:**

- Fixes [\#28043](https://projects.theforeman.org/issues/28043) - Crane uses the Katello server CA [\#211](https://github.com/theforeman/puppet-foreman_proxy_content/pull/211) ([ekohl](https://github.com/ekohl))

## [9.0.2](https://github.com/theforeman/puppet-foreman_proxy_content/tree/9.0.2) (2019-07-31)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/9.0.1...9.0.2)

**Merged pull requests:**

- Allow theforeman/foreman\_proxy 12.x [\#208](https://github.com/theforeman/puppet-foreman_proxy_content/pull/208) ([ekohl](https://github.com/ekohl))

## [9.0.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/9.0.1) (2019-06-04)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/9.0.0...9.0.1)

**Fixed bugs:**

- Further namespace extlib functions [\#202](https://github.com/theforeman/puppet-foreman_proxy_content/pull/202) ([ekohl](https://github.com/ekohl))

**Merged pull requests:**

- Allow katello/qpid 6.x [\#206](https://github.com/theforeman/puppet-foreman_proxy_content/pull/206) ([ekohl](https://github.com/ekohl))
- allow newer versions of dependencies [\#203](https://github.com/theforeman/puppet-foreman_proxy_content/pull/203) ([mmoll](https://github.com/mmoll))

## [9.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/9.0.0) (2019-04-18)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/8.0.1...9.0.0)

**Breaking changes:**

- Drop Puppet 4 [\#199](https://github.com/theforeman/puppet-foreman_proxy_content/pull/199) ([ekohl](https://github.com/ekohl))
- Refs [\#26323](https://projects.theforeman.org/issues/26323) - Remove max\_tasks\_per\_child setting [\#196](https://github.com/theforeman/puppet-foreman_proxy_content/pull/196) ([chris1984](https://github.com/chris1984))
- Update qpid client certificate [\#185](https://github.com/theforeman/puppet-foreman_proxy_content/pull/185) ([ehelms](https://github.com/ehelms))
- Pulp vhosts80 moved to httpd conf.d [\#184](https://github.com/theforeman/puppet-foreman_proxy_content/pull/184) ([ehelms](https://github.com/ehelms))

**Implemented enhancements:**

- Allow theforeman-foreman\_proxy 11.x [\#195](https://github.com/theforeman/puppet-foreman_proxy_content/pull/195) ([ekohl](https://github.com/ekohl))

**Merged pull requests:**

- Require qpid \>= 4.5, allow newest major versions [\#198](https://github.com/theforeman/puppet-foreman_proxy_content/pull/198) ([ekohl](https://github.com/ekohl))

## [8.0.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/8.0.1) (2019-04-11)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/8.0.0...8.0.1)

**Fixed bugs:**

- Refs [\#26571](https://projects.theforeman.org/issues/26571) - Add dispatch router auth [\#197](https://github.com/theforeman/puppet-foreman_proxy_content/pull/197) ([jturel](https://github.com/jturel))

## [8.0.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/8.0.0) (2019-01-15)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.3.2...8.0.0)

**Breaking changes:**

- Remove certs\_tar parameter [\#176](https://github.com/theforeman/puppet-foreman_proxy_content/pull/176) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Allow apache 4.x and foreman\_proxy 10.x [\#191](https://github.com/theforeman/puppet-foreman_proxy_content/pull/191) ([ekohl](https://github.com/ekohl))
- Use extlib namespaced functions [\#190](https://github.com/theforeman/puppet-foreman_proxy_content/pull/190) ([ekohl](https://github.com/ekohl))
- Allow katello-certs 5.Y+ [\#186](https://github.com/theforeman/puppet-foreman_proxy_content/pull/186) ([ehelms](https://github.com/ehelms))
- Add Puppet 6 support [\#183](https://github.com/theforeman/puppet-foreman_proxy_content/pull/183) ([ekohl](https://github.com/ekohl))
- Set the ssl\_chain to the server ca cert [\#162](https://github.com/theforeman/puppet-foreman_proxy_content/pull/162) ([ekohl](https://github.com/ekohl))

## [7.3.3](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.3.3) (2019-04-30)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.3.2...7.3.3)

**Fixed bugs:**

- Refs [\#26571](https://projects.theforeman.org/issues/26571) - Add dispatch router auth [\#201](https://github.com/theforeman/puppet-foreman_proxy_content/pull/201) ([jturel](https://github.com/jturel))

## [7.3.2](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.3.2) (2018-10-31)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.3.1...7.3.2)

**Fixed bugs:**

- fixes [\#24316](https://projects.theforeman.org/issues/24316) - corrects route for foreman-proxy GPG keys [\#181](https://github.com/theforeman/puppet-foreman_proxy_content/pull/181) ([cfouant](https://github.com/cfouant))

## [7.3.1](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.3.1) (2018-10-23)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.3.0...7.3.1)

**Fixed bugs:**

- Correct chaining on puppet master integration [\#179](https://github.com/theforeman/puppet-foreman_proxy_content/pull/179) ([ekohl](https://github.com/ekohl))

## [7.3.0](https://github.com/theforeman/puppet-foreman_proxy_content/tree/7.3.0) (2018-10-18)

[Full Changelog](https://github.com/theforeman/puppet-foreman_proxy_content/compare/7.2.0...7.3.0)

**Implemented enhancements:**

- Allow puppetlabs-stdlib 5.x [\#177](https://github.com/theforeman/puppet-foreman_proxy_content/pull/177) ([ekohl](https://github.com/ekohl))
- Fixes [\#12386](https://projects.theforeman.org/issues/12386) - Let qdrouterd listen on IPv6 [\#139](https://github.com/theforeman/puppet-foreman_proxy_content/pull/139) ([ekohl](https://github.com/ekohl))

**Merged pull requests:**

- Allow extlib 4.x and foreman\_proxy 9.x + Release 7.3.0 [\#178](https://github.com/theforeman/puppet-foreman_proxy_content/pull/178) ([ekohl](https://github.com/ekohl))

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
