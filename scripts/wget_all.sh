#!/usr/bin/env bash

cd ~/git/rdf_rails/repo_aligner/

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/LineItem
wget http://purl.imsglobal.org/ctx/lis/v2/LineItem > repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/LineItem/lineitem.json

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/outcomes
wget http://purl.imsglobal.org/ctx/lis/v2/outcomes > repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/outcomes/LineItemContainer/LineItemContainer.jsonld

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/outcomes/ResultContainer
wget http://purl.imsglobal.org/ctx/lis/v2/outcomes/ResultContainer > repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/outcomes/ResultContainer/resultcontainer.jsonld

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/Result
wget http://purl.imsglobal.org/ctx/lis/v2/Result > repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/Result/result.json

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2p1/Result
wget http://purl.imsglobal.org/ctx/lis/v2p1/Result > repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2p1/Result/Result.json

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lis/v2/AssignmentLink.init
wget http://purl.imsglobal.org/ctx/lti/v2/AssignmentLink.init > repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/AssignmentLink.init/assignmentlink.init.json

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile
wget http://purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile > repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolConsumerProfile/toolconsumerprofile.jsonld

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolProxy
wget http://purl.imsglobal.org/ctx/lti/v2/ToolProxy > repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolProxy/toolproxy.jsonld

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolProxyId
wget http://purl.imsglobal.org/ctx/lti/v2/ToolProxyId > repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolProxyId/toolproxyid.jsonld

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolSettings
wget http://purl.imsglobal.org/ctx/lti/v2/ToolSettings > repo_raw_imsglobal/purl.imsglobal.org/ctx/lti/v2/ToolSettings/toolsettings.json

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/vocab/caliper/v1/core
wget http://purl.imsglobal.org/vocab/caliper/v1/core > repo_raw_imsglobal/purl.imsglobal.org/vocab/caliper/v1/core/TURTLE.ttl

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/vocab/lis/v2/outcomes
wget http://purl.imsglobal.org/vocab/lis/v2/outcomes > repo_raw_imsglobal/purl.imsglobal.org/vocab/lis/v2/outcomes/outcomes.ttl

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/vocab/lis/v2/pm
wget http://purl.imsglobal.org/vocab/lis/v2/pm > repo_raw_imsglobal/purl.imsglobal.org/vocab/lis/v2/pm/pm.ttl

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v1/ci
wget http://purl.imsglobal.org/vocab/lti/v1/ci > repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v1/ci/ci.ttl

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v2/capability
wget http://purl.imsglobal.org/vocab/lti/v2/capability > repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v2/capability/capability.ttl

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v2/lti
wget http://purl.imsglobal.org/vocab/lti/v2/lti > repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v2/lti/TURTLE.ttl

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v2/variable
wget http://purl.imsglobal.org/vocab/lti/v2/variable > repo_raw_imsglobal/purl.imsglobal.org/vocab/lti/v2/variable/variable.ttl

mkdir -p repo_raw_imsglobal/purl.imsglobal.org/xsd/lti/v2/ltid
wget http://purl.imsglobal.org/xsd/lti/v2/ltid > repo_raw_imsglobal/purl.imsglobal.org/xsd/lti/v2/ltid/ltid.xsd
