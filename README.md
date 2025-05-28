# Sistema de Gestão de Formação Contínua - Backend

## Visão Geral do Projeto

Este projeto consiste no backend de um Sistema de Gestão de Formação Contínua, projetado para permitir o planejamento, gerenciamento de cursos de curta duração para profissionais, inscrições, gestão de certificados e avaliação de satisfação. A arquitetura é baseada em microserviços, visando reusabilidade, escalabilidade, resiliência e facilidade de integração.

**Objetivos Principais da Plataforma:**

*   Permitir que **Gestores** planejem e configurem cursos e seus templates de certificado.
*   Permitir que **Formadores** gerenciem o conteúdo dos cursos para os quais estão designados e aprovem a emissão de certificados para seus formandos.
*   Permitir que **Formandos** se inscrevam em cursos, acompanhem seu progresso, recebam certificados e forneçam feedback.
*   Garantir um sistema robusto com trilhas de auditoria e histórico de operações.
*   Facilitar a integração com sistemas externos, como plataformas de certificação.

## Arquitetura

O sistema adota uma arquitetura de **Microserviços**. Esta escolha foi feita para atender às características arquiteturais prioritárias:

*   **Reusabilidade:** Módulos de cursos, avaliações e funcionalidades de certificação são encapsulados em serviços dedicados.
*   **Suporte a Auditoria e Histórico:** Cada serviço pode gerar logs de auditoria, que são centralizados por um serviço dedicado.
*   **Facilidade de Integração:** A comunicação via APIs (REST) e mensageria facilita a integração interna e externa.
*   **Escalabilidade Independente:** Cada serviço pode ser escalado conforme sua necessidade.
*   **Resiliência:** Falhas em um serviço têm impacto limitado no restante do sistema.
*   **Manutenção e Deploy Isolados:** Permite desenvolvimento e implantação ágeis.

### Principais Microserviços

1.  **Serviço de Autenticação (`auth-service`):**
    *   Responsável por registrar usuários (com email, senha, role), validar credenciais e emitir tokens JWT.
    *   Expõe uma API para validação de tokens (introspecção) para outros serviços.
2.  **Serviço de Identidade (`identity-service`):**
    *   Gerencia informações de perfil adicionais dos usuários (nome, contatos, etc.), não relacionadas diretamente à autenticação.
3.  **Serviço de Cursos (`course-service`):**
    *   Gerencia o catálogo de cursos, módulos, conteúdo programático e agendamento de turmas (ofertas de curso).
4.  **Serviço de Inscrições (`enrollment-service`):**
    *   Processa as inscrições de formandos em turmas, gerencia o status das inscrições (pendente, aprovada, rejeitada, cancelada) e permite a aprovação/rejeição por gestores.
5.  **Serviço de Gestão de Certificados (`certificate-service`):**
    *   Gerencia templates de certificados (PDFs).
    *   Processa a aprovação de emissão de certificados por formadores.
    *   Gera os certificados em PDF, preenchendo templates com dados do formando e do curso.
    *   Armazena os PDFs dos certificados no Azure Blob Storage.
    *   Permite que formandos consultem e baixem seus certificados.
    *   Integra-se com sistemas externos de certificação.
6.  **Serviço de Avaliações (`feedback-service`):**
    *   Gerencia a criação de questionários de avaliação de satisfação reutilizáveis.
    *   Coleta respostas de formandos e gera relatórios.
7.  **Serviço de Notificações (`notification-service`):**
    *   Responsável por enviar comunicações aos usuários (ex: confirmação de inscrição, certificado disponível, solicitação de avaliação) via email, SMS, etc. Consome eventos de outros serviços.
8.  **Serviço de Auditoria (`audit-service`):**
    *   Consome eventos de auditoria de todos os outros serviços através de uma fila de mensagens.
    *   Armazena os logs de auditoria de forma persistente.
    *   Expõe uma API para consulta de logs por usuários autorizados.
