---
name: "🐛 Bug Report"
about: Reportar um bug ou problema no módulo de Virtual Machine
title: "[BUG] "
labels: ["bug", "virtual-machine"]
assignees: ''

---

name: "🚀 Feature Request"
about: Sugerir uma nova funcionalidade para o módulo
title: "[FEATURE] "
labels: ["enhancement"]
assignees: ''

---

name: "📚 Documentation"
about: Melhorar ou corrigir documentação
title: "[DOCS] "
labels: ["documentation"]
assignees: ''

---

name: "❓ Question"
about: Fazer uma pergunta sobre o uso do módulo
title: "[QUESTION] "
labels: ["question"]
assignees: ''
---

## 🐛 Template de Bug Report

**Descreva o bug**
Uma descrição clara e concisa do que é o bug.

**Para reproduzir**
Passos para reproduzir o comportamento:
1. Configurar o módulo com '...'
2. Executar 'terraform init'
3. Executar 'terraform plan'
4. Ver erro '....'

**Comportamento esperado**
Uma descrição clara e concisa do que você esperava que acontecesse.

**Capturas de tela**
Se aplicável, adicione capturas de tela para ajudar a explicar seu problema.

**Contexto adicional**
- Versão do Terraform: `terraform version`
- Versão do provider MGC:
- Versão do módulo:
- Sistema Operacional:
- Configuração do backend:

**Código Terraform**
```hcl
# Cole aqui sua configuração Terraform relevante
module "virtual_machine" {
  source = "terraform-magalu-cloud/virtual-machine/mgc"

  # Sua configuração
}
```

**Log*:
