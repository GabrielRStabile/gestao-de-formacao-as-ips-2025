// notification-service/consumer.js
require('dotenv').config();
const eventBus = require('../shared/eventBus');
const transporter = require('./sender');
const db = require('../config/dbNotifications');

async function processNotification(data) {
  try {
    // Envia email
    await transporter.sendMail({
      from: '"Formação Contínua" <noreply@formacao.com>',
      to: data.recipient || 'test@localhost', // Ajuste conforme sua lógica
      subject: `Notificação: ${data.type}`,
      html: data.content
    });
    // Salva no banco como enviada
    await db.query(
      `INSERT INTO notifications(user_id, type, content, status) VALUES($1, $2, $3, $4)`,
      [data.user_id, data.type, data.content, 'SENT']
    );
    console.log('Notificação processada e enviada:', data);
  } catch (err) {
    // Salva no banco como falha
    await db.query(
      `INSERT INTO notifications(user_id, type, content, status) VALUES($1, $2, $3, $4)`,
      [data.user_id, data.type, data.content, 'FAILED']
    );
    console.error('Erro ao processar notificação:', err);
  }
}

async function startConsumer() {
  await eventBus.consume('notifications', processNotification);
  console.log('Consumidor de notificações iniciado e aguardando mensagens...');
}

startConsumer();
