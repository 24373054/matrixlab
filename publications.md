---
title: Publications
description: ""
layout: libdoc/page
category: Navigation
order: 110
---

{% for pub in site.data.publications %}
### [ {{ pub.title }}]({{ pub.url }})
**Authors**: {{ pub.authors }}  
{% if pub.journal %}**Journal**: {{ pub.journal }}  {% endif %}
{% if pub.conference %}**Conference**: {{ pub.conference }}  {% endif %}
**Year**: {{ pub.year }}  
{% if pub.citations %}**Citations**: {{ pub.citations }}{% endif %}

{% endfor %}

## Research Areas
- Blockchain Technology
- Federated Learning
- Intelligent Edge Computing
- Web 3.0 Ecosystem
- IoT Applications
- Smart Contract Security
- Consensus Mechanisms
- Cross-chain Transactions

## Contact Information
For more information about these publications or research collaborations, please contact the corresponding authors.

<script type="text/javascript" src="{{ '/assets/libdoc/js/publications-sort.js' | relative_url }}?v=2"></script>
