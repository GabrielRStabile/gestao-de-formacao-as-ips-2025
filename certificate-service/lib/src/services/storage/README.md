# Certificate Storage Services

Esta pasta contém as interfaces e implementações para o serviço de armazenamento de objetos usado pelo serviço de certificados.

## Arquitetura

### Interface Principal: `ObjectStorageService`

Interface genérica para operações de armazenamento de objetos compatível com S3/MinIO. Fornece métodos básicos para:

- **Upload**: Enviar objetos para o storage
- **Download**: Baixar objetos do storage  
- **Delete**: Remover objetos do storage
- **Metadata**: Obter informações sobre objetos
- **URL Pré-assinada**: Gerar URLs temporárias para acesso

### Interface Específica: `CertificateStorageService`

Interface especializada para operações relacionadas a certificados. Atua como uma camada de abstração sobre o `ObjectStorageService` com funcionalidades específicas para:

- **Templates de Certificado**: Upload, download e gerenciamento de templates PDF
- **Certificados Gerados**: Armazenamento e recuperação de certificados finalizados
- **URLs Temporárias**: Geração de links de download com expiração
- **Metadados**: Informações específicas como nome do aluno, curso, etc.

### Implementação: `MinIOCertificateStorageService`

Implementação concreta da interface `CertificateStorageService` que utiliza MinIO/S3 como backend de storage.

## Estrutura de Buckets

### Templates (`certificate-templates`)
```
templates/
  ├── {templateId}.pdf
  ├── {templateId}.pdf
  └── ...
```

### Certificados Gerados (`generated-certificates`)
```
certificates/
  ├── {certificateId}.pdf
  ├── {certificateId}.pdf
  └── ...
```

## Metadados

### Templates
- `template-id`: ID único do template
- `original-filename`: Nome original do arquivo
- `uploaded-at`: Timestamp do upload

### Certificados
- `certificate-id`: ID único do certificado
- `student-name`: Nome do estudante
- `course-name`: Nome do curso
- `generated-at`: Timestamp da geração

## Uso das Interfaces

```dart
// Serviço de storage genérico
final ObjectStorageService objectStorage = MinIOObjectStorageService(...);

// Serviço especializado em certificados
final CertificateStorageService certificateStorage = 
    MinIOCertificateStorageService(objectStorage);

// Upload de template
await certificateStorage.uploadCertificateTemplate(
  templateId: 'template-123',
  templateData: pdfBytes,
  fileName: 'certificado_conclusao.pdf',
);

// Download de certificado
final certificateData = await certificateStorage.downloadGeneratedCertificate(
  certificateId: 'cert-456',
);

// URL temporária para download
final downloadUrl = await certificateStorage.generateCertificateDownloadUrl(
  certificateId: 'cert-456',
  expiration: Duration(hours: 24),
);
```

## Tratamento de Erros

Todas as operações podem lançar exceções específicas:

- `ObjectStorageException`: Erros de baixo nível do storage
- `CertificateStorageException`: Erros específicos de operações com certificados

## Próximos Passos

1. **Implementar `ObjectStorageService`**: Criar implementação concreta usando biblioteca MinIO/S3
2. **Configuração**: Adicionar variáveis de ambiente para conexão com MinIO
3. **Testes**: Criar testes unitários e de integração
4. **Documentação**: Adicionar exemplos de uso e configuração
